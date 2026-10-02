-- ==========================================
-- Services
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer

-- ==========================================
-- Global Status Variables
-- ==========================================
local isWalkspeedEnabled = false
local isJumpPowerEnabled = false
local isFlyEnabled = false

local currentWalkSpeedValue = 16
local currentJumpPowerValue = 50
local flySpeed = 50 -- Default fly speed

local DEFAULT_WALKSPEED = 16
local DEFAULT_JUMPPOWER = 50

local hooks = {
	walkspeed = DEFAULT_WALKSPEED,
	jumppower = DEFAULT_JUMPPOWER,
}

-- ==========================================
-- Hook Metamethod Setup (Anti-Cheat Bypass)
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
		if not isFlyEnabled then return end

		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum or hum.Health <= 0 then return end

		-- Disable gravity & physics
		hrp.Velocity = Vector3.new(0, 0, 0)

		-- Get camera direction
		local camCF = workspace.CurrentCamera.CFrame
		local moveVector = Vector3.new()

		-- WASD movement relative to camera
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			moveVector = moveVector + camCF.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			moveVector = moveVector - camCF.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			moveVector = moveVector - camCF.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			moveVector = moveVector + camCF.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			moveVector = moveVector + Vector3.new(0, 1, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
			moveVector = moveVector - Vector3.new(0, 1, 0)
		end

		-- Normalize horizontal movement
		moveVector = Vector3.new(moveVector.X, moveVector.Y, moveVector.Z)
		if moveVector.Magnitude > 0 then
			moveVector = moveVector.Unit * flySpeed * dt
		end

		-- Apply CFrame offset (Y included for full flight control)
		hrp.CFrame = hrp.CFrame + moveVector
	end)
end

-- ==========================================
-- CFrame Walkspeed Setup
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

		if isWalkspeedEnabled and currentWalkSpeedValue > DEFAULT_WALKSPEED then
			local moveDir = hum.MoveDirection
			if moveDir.Magnitude > 0 and not hum.Sit and not hum.PlatformStand then
				local extraSpeed = currentWalkSpeedValue - DEFAULT_WALKSPEED
				local offset = moveDir * (extraSpeed * dt)
				hrp.CFrame = hrp.CFrame + Vector3.new(offset.X, 0, offset.Z)
			end
		end
	end)
end

-- ==========================================
-- Apply Functions
-- ==========================================
local function applyWalkSpeed()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if isWalkspeedEnabled then
		hooks.walkspeed = currentWalkSpeedValue
	else
		hooks.walkspeed = DEFAULT_WALKSPEED
	end

	hum.WalkSpeed = DEFAULT_WALKSPEED
end

local function applyJumpPower()
	local char = lp.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if isJumpPowerEnabled then
		hum.JumpPower = currentJumpPowerValue
		hum.UseJumpPower = true
		hooks.jumppower = currentJumpPowerValue
	else
		hum.JumpPower = DEFAULT_JUMPPOWER
		hum.UseJumpPower = false
		hooks.jumppower = DEFAULT_JUMPPOWER
	end
end

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
-- UI SETUP (LIBRARY BARU V3.2)
-- ==========================================
local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/XsHuV3JH-ZET%20UIv4.luau"))()

local Win = Lib:CreateWindow({
	Title = "ZETHUB | CFRAME METHOD",
	Subtitle = "Script by Externimate0",
})

local Main = Win:CreateTab("Main")

-- // WalkSpeed Section
Main:CreateSection("WalkSpeed (Speed ​​70 is recommended)")

Main:CreateToggle({
	Title = "Turn ON/Turn OFF",
	Default = false,
	Callback = function(state)
		isWalkspeedEnabled = state
		applyWalkSpeed()
	end
})

Main:CreateSlider({
	Title = "WalkSpeed Value",
	Min = 1,
	Max = 100,
	Default = currentWalkSpeedValue,
	Callback = function(value)
		currentWalkSpeedValue = value
		if isWalkspeedEnabled then
			applyWalkSpeed()
		end
	end
})

-- // JumpPower Section
Main:CreateSection("JumpPower (Speed ​​140-160 is recommended)")

Main:CreateToggle({
	Title = "Turn ON/Turn OFF",
	Default = false,
	Callback = function(state)
		isJumpPowerEnabled = state
		applyJumpPower()
	end
})

Main:CreateSlider({
	Title = "JumpPower Value",
	Min = 50,
	Max = 200,
	Default = currentJumpPowerValue,
	Callback = function(value)
		currentJumpPowerValue = value
		if isJumpPowerEnabled then
			applyJumpPower()
		end
	end
})

-- // Fly Section
Main:CreateSection("Fly (Speed 60 is recommended)")

Main:CreateToggle({
	Title = "Enable Fly",
	Default = false,
	Callback = function(state)
		isFlyEnabled = state
		local char = lp.Character
		if char and isFlyEnabled then
			setupCFrameFly(char)
		end
		if state then
			Lib:Notify("Fly enabled! WASD + Space/Shift", 3, "Fly")
		end
	end
})

Main:CreateSlider({
	Title = "Fly Speed",
	Min = 10,
	Max = 200,
	Default = flySpeed,
	Callback = function(value)
		flySpeed = value
	end
})

-- // Server Section
Main:CreateSection("Server")

Main:CreateButton({
	Title = "Rejoin Server (Refresh Character)",
	Callback = function()
		Lib:Notify("Cleaning up & rejoining...", 3, "Rejoin")
		cleanupAndRejoin()
	end
})

-- // Keybind Toggle UI (pengganti hotkey bawaan)
Main:CreateKeybind({
	Title = "Keybind",
	Default = Enum.KeyCode.K,
	Callback = function()
		Win:Toggle()
	end
})

Lib:Notify("Interface loaded successfully!", 4, "Welcome")

-- ==========================================
-- Auto Re-apply
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

	setupCFrameWalkspeed(char)
	if isFlyEnabled then
		setupCFrameFly(char)
	end

	applyWalkSpeed()
	applyJumpPower()
end

if lp.Character then
	onCharacterAdded(lp.Character)
end
lp.CharacterAdded:Connect(onCharacterAdded)

-- ==========================================
-- Inisialisasi
-- ==========================================
if lp.Character then
	local hum = lp.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = DEFAULT_WALKSPEED
		hum.JumpPower = DEFAULT_JUMPPOWER
		hum.UseJumpPower = false
	end
end
