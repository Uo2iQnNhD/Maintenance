-- ==========================================
-- SERVICES
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer

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
local selections = {
	Tools = nil,
	Food  = nil,
	Other = nil,
}

-- ==========================================
-- FUNGSI TELEPORT (TweenService + Spam 7 Detik)
-- ==========================================
local function cancelTeleport()
	if currentTween then
		pcall(function() currentTween:Cancel() end)
		currentTween = nil
	end
	if currentLoopActive then
		currentLoopActive = false
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

	local pos = LOCATIONS[category][name]
	local targetCFrame = CFrame.new(pos)

	currentLoopActive = true
	local startTime = tick()
	local totalDuration = 7    -- Total spam: 7 detik
	local tweenDuration = 2.5  -- Durasi per tween

	task.spawn(function()
		while currentLoopActive and (tick() - startTime < totalDuration) do
			-- Validasi karakter masih ada
			if not hrp.Parent or not hum.Parent then
				currentLoopActive = false
				break
			end

			local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
			currentTween:Play()

			-- Tunggu sampai tween selesai atau timeout
			local tweenDone = false
			local conn
			conn = currentTween.Completed:Connect(function()
				tweenDone = true
				if conn then conn:Disconnect() end
			end)

			local waitStart = tick()
			while not tweenDone and currentLoopActive and (tick() - startTime < totalDuration) do
				task.wait(0.1)
				if tick() - waitStart >= tweenDuration then break end
			end

			if conn then conn:Disconnect() end
		end

		currentLoopActive = false
		currentTween = nil
	end)
end

-- ==========================================
-- UI SETUP (LIBRARY V3.2)
-- ==========================================
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/XsHuV3JH-ZET%20UIv4.luau"))()

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
				Lib:Notify("Please select a location first!", 3, "Warning")
				return
			end
			local char = lp.Character
			if not char then
				Lib:Notify("Character not found!", 3, "Error")
				return
			end
			Lib:Notify("Teleporting to " .. selected .. "...", 3, "Teleport")
			teleportTo(categoryName, selected)
		end
	})

	-- Tombol Cancel
	tab:CreateButton({
		Title = "Cancel Teleport",
		Callback = function()
			if currentLoopActive then
				cancelTeleport()
				Lib:Notify("Teleport cancelled", 2, "Info")
			else
				Lib:Notify("No active teleport", 2, "Info")
			end
		end
	})

	-- Info tambahan
	tab:CreateSection("Info")
	tab:CreateLabel("• Tween duration: 2.5s per loop")
	tab:CreateLabel("• Total spam time: 7 seconds")
	tab:CreateLabel("• Auto-cancel on respawn")

	-- Server utility
	tab:CreateSection("Server")
	tab:CreateButton({
		Title = "Rejoin Server",
		Callback = function()
			Lib:Notify("Rejoining server...", 2, "Server")
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
Lib:Notify("Interface loaded! Select location & click Teleport", 5, "Welcome")
Lib:Notify("Press K to Show/hide UI", 4, "Info")
