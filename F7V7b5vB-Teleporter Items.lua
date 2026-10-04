-- ==========================================
-- SERVICES
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lp = Players.LocalPlayer

-- ==========================================
-- FIX: DRAIN ANTRIAN REMOTE "MoveBodyPart"
-- Server game menembakkan event ini ke client terus-menerus saat
-- karakter di bawah tanah / ragdoll. Karena client tidak punya
-- handler, antrian penuh (128/256/512 events dropped).
-- Solusi: pasang handler kosong agar antrian selalu diproses.
-- ==========================================
task.spawn(function()
	local remote = ReplicatedStorage:FindFirstChild("MoveBodyPart")
	if not remote then
		local t0 = tick()
		while not remote and (tick() - t0) < 15 do
			task.wait(0.5)
			remote = ReplicatedStorage:FindFirstChild("MoveBodyPart")
		end
	end
	if remote and remote:IsA("RemoteEvent") then
		-- Handler kosong = antrian event diproses & tidak menumpuk
		remote.OnClientEvent:Connect(function() end)
	end
end)

-- ==========================================
-- DAFTAR LOKASI TELEPORT (3 Kategori)
-- ==========================================
local LOCATIONS = {
	Tools = {
		["Axe"]         = Vector3.new(206, 3, -611),
		["PoliceBaton"] = Vector3.new(148, 3, -109),
		["Shovel"]      = Vector3.new(292, 3, 40),
		["Pipe"]        = Vector3.new(259, -27, -441),
		["Knife"]       = Vector3.new(216, 16, -223),
		["Crowbar"]     = Vector3.new(316, 4, -48),
		["Bat"]         = Vector3.new(411, 19, -94),
		["Musket"]      = Vector3.new(322, 3, -459),
		["StopSign"]    = Vector3.new(551, 5, -380),
		["AK-47"]       = Vector3.new(42, 3, -89),
		["SprayPaint"]  = Vector3.new(335, -27, -426),
		["Taser"]       = Vector3.new(42, 3, -93),
		["Screwdriver"] = Vector3.new(459, -6, -88),
		["Pliers"]      = Vector3.new(459, -6, -88),
		["Handsaw"]     = Vector3.new(459, -6, -88),
		["Hammer"]      = Vector3.new(459, -6, -88),
	},
	Food = {
		["Hamburger"] = Vector3.new(257, 3, -601),
		["Doughnut"]  = Vector3.new(589, 3, -326),
		["Subway"]    = Vector3.new(394, -26, -301),
		["Drink"]     = Vector3.new(459, 5, 32),
		["Food"]      = Vector3.new(105, 3, -48),
	},
	Other = {
		["KeyCard"]              = Vector3.new(217, 31, -222),
		["BallNChainTool"]       = Vector3.new(135, 1, -27),
		["Broom"]                = Vector3.new(63, 3, 15),
		["BlindFold"]            = Vector3.new(51, 3, -113),
		["Rope"]                 = Vector3.new(54, 3, -141),
		["Handcuffs (fugitive)"] = Vector3.new(415, 19, -96),
		["Flashlight"]           = Vector3.new(432, 19, -99),
		["Board"]                = Vector3.new(274, 3, -104),
	},
}

-- Generate sorted option list untuk setiap kategori
local function buildOptions(list)
	local opts = {}
	for name, _ in pairs(list) do table.insert(opts, name) end
	table.sort(opts)
	return opts
end

local OPTIONS = {
	Tools = buildOptions(LOCATIONS.Tools),
	Food  = buildOptions(LOCATIONS.Food),
	Other = buildOptions(LOCATIONS.Other),
}

-- ==========================================
-- STATE & KONTROL TELEPORT
-- ==========================================
local currentTween = nil
local currentLoopActive = false
local noclipConnection = nil
local selections = {
	Tools = nil,
	Food  = nil,
	Other = nil,
}

-- ==========================================
-- FUNGSI NOCLIP
-- ==========================================
local function turnOnNoclip(char)
	if noclipConnection then 
		noclipConnection:Disconnect() 
	end
	noclipConnection = RunService.Stepped:Connect(function()
		if not char or not char.Parent then return end
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end)
end

local function turnOffNoclip(char)
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end
	if char and char.Parent then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end

-- ==========================================
-- STATE GUARD (Anti-Ragdoll / Anti spam MoveBodyPart)
-- ==========================================
local function lockStates(hum)
	if hum and hum.Parent then
		pcall(function()
			hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
		end)
	end
end

local function restoreStates(hum)
	if hum and hum.Parent then
		pcall(function()
			hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
			hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		end)
	end
end

-- ==========================================
-- FUNGSI TELEPORT (Metode Turun -> Geser Bawah -> Naik)
-- ==========================================
local function cancelTeleport()
	if currentTween then
		pcall(function() currentTween:Cancel() end)
		currentTween = nil
	end
	if currentLoopActive then
		currentLoopActive = false
	end
	-- Cleanup: matikan noclip & kembalikan state humanoid
	local char = lp.Character
	if char then
		turnOffNoclip(char)
		restoreStates(char:FindFirstChildOfClass("Humanoid"))
	end
end

local function teleportTo(category, name)
	-- Validasi input
	if not LOCATIONS[category] or not LOCATIONS[category][name] then return end

	-- Cancel previous
	cancelTeleport()
	task.wait(0.1)

	local char = lp.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	-- 1. NYALAKAN NOCLIP + KUNCI STATE (anti ragdoll)
	turnOnNoclip(char)
	lockStates(hum)

	local pos = LOCATIONS[category][name]
	local startPos = hrp.Position

	-- Strategi Anti-Ragdoll & Anti-Tembok:
	local offsetBawah = 70
	local safeY = startPos.Y - offsetBawah
	
	local step1 = Vector3.new(startPos.X, safeY, startPos.Z) -- Turun di tempat
	local step2 = Vector3.new(pos.X, safeY, pos.Z)           -- Geser di bawah tanah
	local step3 = pos                                        -- Naik ke tujuan

	-- Kecepatan tween diperlambat (20 stud/detik) agar aman dari deteksi speedhack
	local TWEEN_SPEED = 150

	currentLoopActive = true
	local startTime = tick()
	local totalDuration = 15 -- Total waktu maksimal proses

	task.spawn(function()
		-- Cleanup terpusat untuk semua jalur keluar
		local function cleanup()
			turnOffNoclip(char)
			restoreStates(hum)
			currentLoopActive = false
			currentTween = nil
		end

		-- Helper untuk tween per langkah
		local function doTween(targetPos, minDuration)
			if not currentLoopActive then return false end
			if not hrp.Parent or not hum.Parent then
				currentLoopActive = false
				return false
			end
			-- Death guard: berhenti jika karakter mati (void dll)
			-- agar server tidak terus mengirim koreksi MoveBodyPart
			if hum.Health <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead then
				currentLoopActive = false
				return false
			end
			
			-- Durasi dinamis berdasarkan jarak agar kecepatan konstan & tidak menyentak
			local distance = (hrp.Position - targetPos).Magnitude
			local duration = math.max(minDuration, distance / TWEEN_SPEED)
			
			-- Sine InOut memberikan efek percepatan dan perlambatan yang natural
			local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
			currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
			currentTween:Play()

			local tweenDone = false
			local conn
			conn = currentTween.Completed:Connect(function()
				tweenDone = true
				if conn then conn:Disconnect() end
			end)

			local waitStart = tick()
			while not tweenDone and currentLoopActive do
				task.wait(0.1)
				if tick() - waitStart >= duration + 1 then break end
			end
			if conn then conn:Disconnect() end
			
			return currentLoopActive
		end

		-- 1. Turun ke bawah di tempat (min 2.0 detik)
		local ok1 = doTween(step1, 2.0)
		if not ok1 then cleanup() return end

		-- 2. Geser horizontal ke X, Z tujuan (min 1.0 detik)
		local ok2 = doTween(step2, 1.0)
		if not ok2 then cleanup() return end

		-- 3. Naik ke posisi tujuan sebenarnya (min 2.0 detik)
		local ok3 = doTween(step3, 2.0)
		if not ok3 then cleanup() return end

		-- MATIKAN NOCLIP + KEMBALIKAN STATE KARENA SUDAH SAMPAI TUJUAN
		turnOffNoclip(char)
		restoreStates(hum)

		-- 4. Spam di posisi akhir untuk memastikan sinkronisasi server
		while currentLoopActive and (tick() - startTime < totalDuration) do
			local okSpam = doTween(step3, 0.5)
			if not okSpam then break end
		end

		cleanup()
	end)
end

-- ==========================================
-- UI SETUP (LIBRARY V3.2)
-- ==========================================
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/XsHuV3JH-ZET%20UIv4.luau"))()

-- Wrapper aman: error internal library (spt GetChildren nil) tidak lagi
-- muncul sebagai error merah di console
local function notify(msg, dur, kind)
	pcall(function() Lib:Notify(msg, dur, kind) end)
end

local Win = Lib:CreateWindow({
	Title = "ZETHUB | TELEPORTER",
	Subtitle = "Tools • Food • Other",
})

-- Helper: bangun tab teleport untuk satu kategori
local function buildTeleportTab(categoryName, description)
	local tab = Win:CreateTab(categoryName:upper())

	tab:CreateSection(categoryName .. " Locations")
	tab:CreateLabel(description)

	-- Dropdown pilih lokasi
	local dropdown = tab:CreateDropdown({
		Title = "Select " .. categoryName,
		Options = OPTIONS[categoryName],
		Default = OPTIONS[categoryName][1] or "None",
		Callback = function(opt)
			selections[categoryName] = opt
		end
	})
	-- Default selection
	selections[categoryName] = OPTIONS[categoryName][1]

	-- Tombol Teleport
	tab:CreateButton({
		Title = "Teleport Now",
		Callback = function()
			local selected = selections[categoryName]
			if not selected or selected == "None" then
				notify("Please select a location first!", 3, "Warning")
				return
			end
			local char = lp.Character
			if not char then
				notify("Character not found!", 3, "Error")
				return
			end
			notify("Teleporting to " .. selected .. "...", 3, "Teleport")
			teleportTo(categoryName, selected)
		end
	})

	-- Tombol Cancel
	tab:CreateButton({
		Title = "Cancel Teleport",
		Callback = function()
			if currentLoopActive then
				cancelTeleport()
				notify("Teleport cancelled", 2, "Info")
			else
				notify("No active teleport", 2, "Info")
			end
		end
	})


-- Info tambahan
	tab:CreateSection("Info")
	tab:CreateLabel("Teleporter Duration is 15 Second!")
    tab:CreateLabel("If you cannot move, wait 15 seconds!")

	-- Server utility
	tab:CreateSection("Server")
	tab:CreateButton({
		Title = "Rejoin Server",
		Callback = function()
			notify("Rejoining server...", 2, "Server")
			cancelTeleport()
			task.wait(0.3)
			pcall(function()
				TeleportService:Teleport(game.PlaceId, lp)
			end)
		end
	})

	return tab
end

-- ========================================================================
-- TAB 1: TOOLS
-- ========================================================================
buildTeleportTab("Tools", "16 tool locations — weapons, melee, ranged")

-- ========================================================================
-- TAB 2: FOOD
-- ========================================================================
buildTeleportTab("Food", "5 food locations — fast food & drinks")

-- ========================================================================
-- TAB 3: OTHER
-- ========================================================================
buildTeleportTab("Other", "8 miscellaneous item locations")

-- ========================================================================
-- SETTINGS TAB (Keybind)
-- ========================================================================
local TabSettings = Win:CreateTab("SETTINGS")
TabSettings:CreateSection("Interface")
TabSettings:CreateKeybind({
	Title = "Keybind",
	Default = Enum.KeyCode.K,
	Callback = function()
		Win:Toggle()
	end
})

-- ==========================================
-- AUTO-CANCEL ON RESPAWN (safety)
-- ==========================================
lp.CharacterAdded:Connect(function(char)
	cancelTeleport()
end)

-- ==========================================
-- WELCOME
-- ==========================================
notify("Interface loaded! Select location & click Teleport", 5, "Welcome")
notify("Press K to Show/hide UI", 4, "Info")
