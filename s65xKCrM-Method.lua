-- ==========================================
-- Services
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer

-- ==========================================
-- Namespaced State (CFRAME / RANDOM / HOOK terpisah)
-- ==========================================
local cframe = {
	isWalkspeedEnabled = false,
	isJumpPowerEnabled = false,
	isFlyEnabled = false,
	currentWalkSpeedValue = 16,
	currentJumpPowerValue = 50,
	flySpeed = 50,
}

local random = {
	isWalkspeedEnabled = false,
	isJumpPowerEnabled = false,
	currentWalkSpeedValue = 16,
	currentJumpPowerValue = 50,
	config = {
		walkVariation = 0.10,  -- ±10%
		jumpVariation = 0.10,  -- ±10%
		minInterval = 0.3,     -- detik
		maxInterval = 0.8,     -- detik
		useRandomization = true,
	}
}

local hookm = {
	isWalkspeedEnabled = false,
	isJumpPowerEnabled = false,
	currentWalkSpeedValue = 16,
	currentJumpPowerValue = 50,
}

local DEFAULT_WALKSPEED = 16
local DEFAULT_JUMPPOWER = 50

local hooks = {
	walkspeed = DEFAULT_WALKSPEED,
	jumppower = DEFAULT_JUMPPOWER,
}

-- ==========================================
-- Hook Metamethod Setup (SATU KALI, dipakai semua method)
-- ==========================================
local old_index, old_newindex

if hookmetamethod and checkcaller then
	old_index = hookmetamethod(game, "__index", function(self, property)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
			return hooks[property:lower()]
		end
		return old_index(self, property)
	end)

	old_newindex = hookmetamethod(game, "__newindex", function(self, property, value)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
			return
		end
		return old_newindex(self, property, value)
	end)
end

-- ==========================================
-- Sync Hooks (prioritas: HOOK > RANDOM > CFRAME)
-- ==========================================
local function syncHooks()
	-- WalkSpeed
	if hookm.isWalkspeedEnabled then
		hooks.walkspeed = hookm.currentWalkSpeedValue
	elseif random.isWalkspeedEnabled then
		-- dibiarkan: loop randomization yang set nilai final tiap interval
	elseif cframe.isWalkspeedEnabled then
		hooks.walkspeed = cframe.currentWalkSpeedValue
	else
		hooks.walkspeed = DEFAULT_WALKSPEED
	end
	-- JumpPower
	if hookm.isJumpPowerEnabled then
		hooks.jumppower = hookm.currentJumpPowerValue
	elseif random.isJumpPowerEnabled then
		-- dibiarkan: loop randomization yang set nilai final tiap interval
	elseif cframe.isJumpPowerEnabled then
		hooks.jumppower = cframe.currentJumpPowerValue
	else
		hooks.jumppower = DEFAULT_JUMPPOWER
	end
end

-- ==========================================
-- CFrame Fly Logic
-- ==========================================
local flyConnection = nil

local function setupCFrameFly(char)
	if flyConnection then
		flyConnection:Disconnect()
		flyConnection = nil
	end

	local hrp = char:WaitForChild("HumanoidRootPart", 5)
	if not hrp then return end

	flyConnection = RunService.RenderStepped:Connect(function(dt)
		if not cframe.isFlyEnabled then return end

		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then return end

		hrp.Velocity = Vector3.new(0, 0, 0)

		local camCF = workspace.CurrentCamera.CFrame
		local moveVector = Vector3.new()

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + camCF.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - camCF.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - camCF.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + camCF.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - Vector3.new(0, 1, 0) end

		moveVector = Vector3.new(moveVector.X, moveVector.Y, moveVector.Z)
		if moveVector.Magnitude > 0 then
			moveVector = moveVector.Unit * cframe.flySpeed * dt
		end

		hrp.CFrame = hrp.CFrame + moveVector
	end)
end

-- ==========================================
-- CFrame Walkspeed Loop
-- ==========================================
local cfWalkConnection = nil

local function setupCFrameWalkspeed(char)
	if cfWalkConnection then
		cfWalkConnection:Disconnect()
		cfWalkConnection = nil
	end

	local hrp = char:WaitForChild("HumanoidRootPart", 5)
	if not hrp then return end

	cfWalkConnection = RunService.Heartbeat:Connect(function(dt)
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then return end

		if cframe.isWalkspeedEnabled and cframe.currentWalkSpeedValue > DEFAULT_WALKSPEED then
			local moveDir = hum.MoveDirection
			if moveDir.Magnitude > 0 and not hum.Sit and not hum.PlatformStand then
				local extraSpeed = cframe.currentWalkSpeedValue - DEFAULT_WALKSPEED
				local offset = moveDir * (extraSpeed * dt)
				hrp.CFrame = hrp.CFrame + Vector3.new(offset.X, 0, offset.Z)
			end
		end
	end)
end

-- ==========================================
-- Apply Functions - CFRAME
-- ==========================================
local function applyCFrameWalkSpeed()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	syncHooks()
	hum.WalkSpeed = DEFAULT_WALKSPEED
end

local function applyCFrameJumpPower()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if cframe.isJumpPowerEnabled then
		hum.JumpPower = cframe.currentJumpPowerValue
		hum.UseJumpPower = true
		hooks.jumppower = cframe.currentJumpPowerValue
	else
		hum.JumpPower = DEFAULT_JUMPPOWER
		hum.UseJumpPower = false
		hooks.jumppower = DEFAULT_JUMPPOWER
	end
end

-- ==========================================
-- Apply Functions - RANDOMIZATION
-- ==========================================
local function getRandomizedValue(baseValue, variationPercent)
	if not random.config.useRandomization then
		return baseValue
	end
	local variation = baseValue * variationPercent
	local minVal = baseValue - variation
	local maxVal = baseValue + variation
	return math.random(minVal * 10, maxVal * 10) / 10
end

local function applyRandomWalkSpeed()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if random.isWalkspeedEnabled then
		if random.currentWalkSpeedValue > DEFAULT_WALKSPEED then
			local finalSpeed = getRandomizedValue(random.currentWalkSpeedValue, random.config.walkVariation)
			hum.WalkSpeed = finalSpeed
			hooks.walkspeed = finalSpeed
		else
			hum.WalkSpeed = DEFAULT_WALKSPEED
			hooks.walkspeed = DEFAULT_WALKSPEED
		end
	else
		hum.WalkSpeed = DEFAULT_WALKSPEED
		hooks.walkspeed = DEFAULT_WALKSPEED
	end
end

local function applyRandomJumpPower()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if random.isJumpPowerEnabled then
		if random.currentJumpPowerValue > DEFAULT_JUMPPOWER then
			local finalPower = getRandomizedValue(random.currentJumpPowerValue, random.config.jumpVariation)
			hum.JumpPower = finalPower
			hum.UseJumpPower = true
			hooks.jumppower = finalPower
		else
			hum.JumpPower = DEFAULT_JUMPPOWER
			hum.UseJumpPower = true
			hooks.jumppower = DEFAULT_JUMPPOWER
		end
	else
		hum.JumpPower = DEFAULT_JUMPPOWER
		hum.UseJumpPower = false
		hooks.jumppower = DEFAULT_JUMPPOWER
	end
end

-- ==========================================
-- Apply Functions - HOOK METAMETHOD
-- ==========================================
local function applyHookWalkSpeed()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if hookm.isWalkspeedEnabled then
		-- Properti asli diubah; reset anti-cheat diblokir oleh __newindex hook
		hooks.walkspeed = hookm.currentWalkSpeedValue
		hum.WalkSpeed = hookm.currentWalkSpeedValue
	else
		hooks.walkspeed = DEFAULT_WALKSPEED
		hum.WalkSpeed = DEFAULT_WALKSPEED
	end
end

local function applyHookJumpPower()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if hookm.isJumpPowerEnabled then
		hooks.jumppower = hookm.currentJumpPowerValue
		hum.JumpPower = hookm.currentJumpPowerValue
		hum.UseJumpPower = true
	else
		hooks.jumppower = DEFAULT_JUMPPOWER
		hum.JumpPower = DEFAULT_JUMPPOWER
		hum.UseJumpPower = false
	end
end

-- ==========================================
-- Randomization Loop
-- ==========================================
local lastWalkApplyTime = 0
local lastJumpApplyTime = 0
local nextWalkInterval = math.random(random.config.minInterval * 10, random.config.maxInterval * 10) / 10
local nextJumpInterval = math.random(random.config.minInterval * 10, random.config.maxInterval * 10) / 10

RunService.Heartbeat:Connect(function()
	local now = tick()

	if random.isWalkspeedEnabled and random.currentWalkSpeedValue > DEFAULT_WALKSPEED then
		if now - lastWalkApplyTime >= nextWalkInterval then
			applyRandomWalkSpeed()
			lastWalkApplyTime = now
			nextWalkInterval = math.random(random.config.minInterval * 10, random.config.maxInterval * 10) / 10
		end
	end

	if random.isJumpPowerEnabled and random.currentJumpPowerValue > DEFAULT_JUMPPOWER then
		if now - lastJumpApplyTime >= nextJumpInterval then
			applyRandomJumpPower()
			lastJumpApplyTime = now
			nextJumpInterval = math.random(random.config.minInterval * 10, random.config.maxInterval * 10) / 10
		end
	end
end)

-- ==========================================
-- CLEANUP & REJOIN FUNCTION
-- ==========================================
local isCleaning = false

local function cleanupAndRejoin()
	if isCleaning then return end
	isCleaning = true

	pcall(function()
		if lp and lp.Character then
			local hum = lp.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = DEFAULT_WALKSPEED
				hum.JumpPower = DEFAULT_JUMPPOWER
				hum.UseJumpPower = false
			end
		end

		hooks.walkspeed = DEFAULT_WALKSPEED
		hooks.jumppower = DEFAULT_JUMPPOWER

		if cfWalkConnection then
			cfWalkConnection:Disconnect()
			cfWalkConnection = nil
		end
		if flyConnection then
			flyConnection:Disconnect()
			flyConnection = nil
		end

		task.wait(0.3)
		TeleportService:Teleport(game.PlaceId, lp)
	end)
end

-- ==========================================
-- DETECTION: Script Close/Delete
-- ==========================================
pcall(function()
	if script then
		script.AncestryChanged:Connect(function(child, parent)
			if child == script and parent == nil then
				cleanupAndRejoin()
			end
		end)
	end
end)

pcall(function()
	if script and script.Destroying then
		script.Destroying:Connect(function()
			cleanupAndRejoin()
		end)
	end
end)

if hookmetamethod and checkcaller then
	pcall(function()
		local mt = getrawmetatable(game)
		local old_namecall = mt.__namecall

		setreadonly(mt, false)
		mt.__namecall = newcclosure(function(self, ...)
			local method = getnamecallmethod()
			if method == "Teleport" or method == "TeleportToPlaceInstance" then
				cleanupAndRejoin()
			end
			return old_namecall(self, ...)
		end)
		setreadonly(mt, true)
	end)
end

local lastHeartbeat = tick()
local watchdogConnection = RunService.Heartbeat:Connect(function()
	lastHeartbeat = tick()
end)

task.spawn(function()
	while task.wait(5) do
		if tick() - lastHeartbeat > 10 then
			watchdogConnection:Disconnect()
			break
		end
	end
end)

-- ==========================================
-- UI SETUP (LIBRARY V3.2)
-- ==========================================
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/XsHuV3JH-ZET%20UIv4.luau"))()

local Win = Lib:CreateWindow({
	Title = "ZETHUB | METHOD | V15",
	Subtitle = "By Externimate0",
})

-- ========================================================================
-- TAB 1: CFRAME METHOD
-- ========================================================================
local TabCFrame = Win:CreateTab("CFRAME")

-- // WalkSpeed Section
TabCFrame:CreateSection("WalkSpeed (CFrame Method)")
TabCFrame:CreateLabel("Speed 70 is recommended")

TabCFrame:CreateToggle({
	Title = "Turn ON/OFF",
	Default = false,
	Callback = function(state)
		cframe.isWalkspeedEnabled = state
		if state and (random.isWalkspeedEnabled or hookm.isWalkspeedEnabled) then
			Lib:Notify("Disable Random/Hook WalkSpeed first!", 4, "Warning")
		end
		applyCFrameWalkSpeed()
	end
})

TabCFrame:CreateSlider({
	Title = "WalkSpeed Value",
	Min = 1,
	Max = 100,
	Default = cframe.currentWalkSpeedValue,
	Callback = function(value)
		cframe.currentWalkSpeedValue = value
		if cframe.isWalkspeedEnabled then
			applyCFrameWalkSpeed()
		end
	end
})

-- // JumpPower Section
TabCFrame:CreateSection("JumpPower (Hook Method)")
TabCFrame:CreateLabel("140-160 is recommended")

TabCFrame:CreateToggle({
	Title = "Turn ON/OFF",
	Default = false,
	Callback = function(state)
		cframe.isJumpPowerEnabled = state
		if state and (random.isJumpPowerEnabled or hookm.isJumpPowerEnabled) then
			Lib:Notify("Disable Random/Hook JumpPower first!", 4, "Warning")
		end
		applyCFrameJumpPower()
	end
})

TabCFrame:CreateSlider({
	Title = "JumpPower Value",
	Min = 50,
	Max = 200,
	Default = cframe.currentJumpPowerValue,
	Callback = function(value)
		cframe.currentJumpPowerValue = value
		if cframe.isJumpPowerEnabled then
			applyCFrameJumpPower()
		end
	end
})

-- // Fly Section
TabCFrame:CreateSection("Fly (CFrame Method)")
TabCFrame:CreateLabel("Speed 60 is recommended")

TabCFrame:CreateToggle({
	Title = "Enable Fly",
	Default = false,
	Callback = function(state)
		cframe.isFlyEnabled = state
		local char = lp.Character
		if char and state then
			setupCFrameFly(char)
		end
		if state then
			Lib:Notify("Fly enabled! WASD + Space/Shift", 3, "Fly")
		end
	end
})

TabCFrame:CreateSlider({
	Title = "Fly Speed",
	Min = 10,
	Max = 200,
	Default = cframe.flySpeed,
	Callback = function(value)
		cframe.flySpeed = value
	end
})

-- // Server Section
TabCFrame:CreateSection("Server")

TabCFrame:CreateButton({
	Title = "Rejoin Server (Refresh Character)",
	Callback = function()
		Lib:Notify("Cleaning up & rejoining...", 3, "Rejoin")
		cleanupAndRejoin()
	end
})

TabCFrame:CreateKeybind({
	Title = "Keybind",
	Default = Enum.KeyCode.K,
	Callback = function()
		Win:Toggle()
	end
})

-- ========================================================================
-- TAB 2: RANDOMIZATION METHOD
-- ========================================================================
local TabRandom = Win:CreateTab("RANDOM")

-- // WalkSpeed Section
TabRandom:CreateSection("WalkSpeed (Randomized)")
TabRandom:CreateLabel("Anti-pattern: value fluctuates every interval")

TabRandom:CreateToggle({
	Title = "Turn ON/OFF",
	Default = false,
	Callback = function(state)
		random.isWalkspeedEnabled = state
		if state and (cframe.isWalkspeedEnabled or hookm.isWalkspeedEnabled) then
			Lib:Notify("Disable CFrame/Hook WalkSpeed first!", 4, "Warning")
		end
		if state then
			applyRandomWalkSpeed()
			Lib:Notify("Random WalkSpeed enabled", 3, "Randomization")
		else
			local char = lp.Character
			if char then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then hum.WalkSpeed = DEFAULT_WALKSPEED hooks.walkspeed = DEFAULT_WALKSPEED end
			end
		end
	end
})

TabRandom:CreateSlider({
	Title = "WalkSpeed Value (Base)",
	Min = 1,
	Max = 100,
	Default = random.currentWalkSpeedValue,
	Callback = function(value)
		random.currentWalkSpeedValue = value
		if random.isWalkspeedEnabled then
			applyRandomWalkSpeed()
		end
	end
})

-- // JumpPower Section
TabRandom:CreateSection("JumpPower (Randomized)")

TabRandom:CreateToggle({
	Title = "Turn ON/OFF",
	Default = false,
	Callback = function(state)
		random.isJumpPowerEnabled = state
		if state and (cframe.isJumpPowerEnabled or hookm.isJumpPowerEnabled) then
			Lib:Notify("Disable CFrame/Hook JumpPower first!", 4, "Warning")
		end
		if state then
			applyRandomJumpPower()
			Lib:Notify("Random JumpPower enabled", 3, "Randomization")
		else
			local char = lp.Character
			if char then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then hum.JumpPower = DEFAULT_JUMPPOWER hum.UseJumpPower = false hooks.jumppower = DEFAULT_JUMPPOWER end
			end
		end
	end
})

TabRandom:CreateSlider({
	Title = "JumpPower Value (Base)",
	Min = 50,
	Max = 200,
	Default = random.currentJumpPowerValue,
	Callback = function(value)
		random.currentJumpPowerValue = value
		if random.isJumpPowerEnabled then
			applyRandomJumpPower()
		end
	end
})

-- // Anti-Pattern Configuration
TabRandom:CreateSection("Anti-Pattern Configuration")

TabRandom:CreateToggle({
	Title = "Enable Randomization",
	Default = random.config.useRandomization,
	Callback = function(state)
		random.config.useRandomization = state
		if state then
			Lib:Notify("Randomization active: values fluctuate", 3, "Config")
		else
			Lib:Notify("Randomization disabled: static values", 3, "Config")
		end
	end
})

TabRandom:CreateSlider({
	Title = "Walk Variation %",
	Min = 0,
	Max = 50,
	Default = math.floor(random.config.walkVariation * 100),
	Callback = function(value)
		random.config.walkVariation = value / 100
		Lib:Notify("Walk variation: ±" .. value .. "%", 2, "Config")
	end
})

TabRandom:CreateSlider({
	Title = "Jump Variation %",
	Min = 0,
	Max = 50,
	Default = math.floor(random.config.jumpVariation * 100),
	Callback = function(value)
		random.config.jumpVariation = value / 100
		Lib:Notify("Jump variation: ±" .. value .. "%", 2, "Config")
	end
})

TabRandom:CreateSlider({
	Title = "Min Interval (×0.1s)",
	Min = 1,
	Max = 20,
	Default = math.floor(random.config.minInterval * 10),
	Callback = function(value)
		random.config.minInterval = value / 10
		Lib:Notify("Min interval: " .. (value/10) .. "s", 2, "Config")
	end
})

TabRandom:CreateSlider({
	Title = "Max Interval (×0.1s)",
	Min = 1,
	Max = 20,
	Default = math.floor(random.config.maxInterval * 10),
	Callback = function(value)
		random.config.maxInterval = value / 10
		Lib:Notify("Max interval: " .. (value/10) .. "s", 2, "Config")
	end
})

-- // Server Section
TabRandom:CreateSection("Server")

TabRandom:CreateButton({
	Title = "Rejoin Server (Refresh Character)",
	Callback = function()
		Lib:Notify("Cleaning up & rejoining...", 3, "Rejoin")
		cleanupAndRejoin()
	end
})

-- ========================================================================
-- TAB 3: HOOK METAMETHOD (BARU)
-- ========================================================================
local TabHook = Win:CreateTab("HOOK")

-- // WalkSpeed Section
TabHook:CreateSection("WalkSpeed (Hook Metamethod)")
TabHook:CreateLabel("Real property changed, anti-cheat reset blocked by hook")

TabHook:CreateToggle({
	Title = "Turn ON/OFF",
	Default = false,
	Callback = function(state)
		hookm.isWalkspeedEnabled = state
		if state and (cframe.isWalkspeedEnabled or random.isWalkspeedEnabled) then
			Lib:Notify("Disable CFrame/Random WalkSpeed first!", 4, "Warning")
		end
		applyHookWalkSpeed()
		if state then
			Lib:Notify("Hook WalkSpeed enabled", 3, "HookMethod")
		end
	end
})

TabHook:CreateSlider({
	Title = "WalkSpeed Value",
	Min = 1,
	Max = 100,
	Default = hookm.currentWalkSpeedValue,
	Callback = function(value)
		hookm.currentWalkSpeedValue = value
		if hookm.isWalkspeedEnabled then
			applyHookWalkSpeed()
		end
	end
})

-- // JumpPower Section
TabHook:CreateSection("JumpPower (Hook Metamethod)")
TabHook:CreateLabel("140-160 is recommended")

TabHook:CreateToggle({
	Title = "Turn ON/OFF",
	Default = false,
	Callback = function(state)
		hookm.isJumpPowerEnabled = state
		if state and (cframe.isJumpPowerEnabled or random.isJumpPowerEnabled) then
			Lib:Notify("Disable CFrame/Random JumpPower first!", 4, "Warning")
		end
		applyHookJumpPower()
		if state then
			Lib:Notify("Hook JumpPower enabled", 3, "HookMethod")
		end
	end
})

TabHook:CreateSlider({
	Title = "JumpPower Value",
	Min = 50,
	Max = 200,
	Default = hookm.currentJumpPowerValue,
	Callback = function(value)
		hookm.currentJumpPowerValue = value
		if hookm.isJumpPowerEnabled then
			applyHookJumpPower()
		end
	end
})

-- // Server Section
TabHook:CreateSection("Server")

TabHook:CreateButton({
	Title = "Rejoin Server (Refresh Character)",
	Callback = function()
		Lib:Notify("Cleaning up & rejoining...", 3, "Rejoin")
		cleanupAndRejoin()
	end
})

Lib:Notify("Interface Successfully loaded!", 4, "Welcome")
Lib:Notify("Only enable 1 method don't 2", 6, "Info")

-- ==========================================
-- Auto Re-apply on Respawn
-- ==========================================
local function onCharacterAdded(char)
	char:WaitForChild("HumanoidRootPart")
	char:WaitForChild("Humanoid")
	task.wait(0.2)

	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = DEFAULT_WALKSPEED
		hum.JumpPower = DEFAULT_JUMPPOWER
		hum.UseJumpPower = false
	end

	-- Setup loops
	setupCFrameWalkspeed(char)
	if cframe.isFlyEnabled then
		setupCFrameFly(char)
	end

	-- Apply current states (urutan: cframe -> hook -> random)
	syncHooks()
	if cframe.isWalkspeedEnabled then applyCFrameWalkSpeed() end
	if hookm.isWalkspeedEnabled then applyHookWalkSpeed() end
	if random.isWalkspeedEnabled then applyRandomWalkSpeed() end
	if cframe.isJumpPowerEnabled then applyCFrameJumpPower() end
	if hookm.isJumpPowerEnabled then applyHookJumpPower() end
	if random.isJumpPowerEnabled then applyRandomJumpPower() end
end

if lp.Character then
	onCharacterAdded(lp.Character)
end
lp.CharacterAdded:Connect(onCharacterAdded)

-- ==========================================
-- Initial Setup
-- ==========================================
if lp.Character then
	local hum = lp.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = DEFAULT_WALKSPEED
		hum.JumpPower = DEFAULT_JUMPPOWER
		hum.UseJumpPower = false
	end
end
