-- ==========================================
-- Load UI Library
-- ==========================================
local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/zeutronxsite/M3kELKp3QMonkeUI/refs/heads/main/FmQTSqSpK.luau'))()

UI.Title.Text = "TLK PRISON [LINEAR VELOCITY]"
UI.newTab("Main")

-- ==========================================
-- Services
-- ==========================================
local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- ==========================================
-- Global Status Variables
-- ==========================================
local isWalkspeedEnabled = false
local isJumpPowerEnabled = false

local currentWalkSpeedValue = 16
local currentJumpPowerValue = 50

local DEFAULT_WALKSPEED = 16
local DEFAULT_JUMPPOWER = 50

local hooks = {
    walkspeed = DEFAULT_WALKSPEED,
    jumppower = DEFAULT_JUMPPOWER,
}

-- ==========================================
-- Hook Metamethod Setup
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
-- LinearVelocity Setup untuk WalkSpeed
-- ==========================================
local lvConnection = nil
local currentLV = nil

local function setupLinearVelocity(char)
    if lvConnection then
        lvConnection:Disconnect()
        lvConnection = nil
    end
    
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end
    
    -- Cleanup instance lama
    if hrp:FindFirstChild("SpeedAttachment") then
        hrp.SpeedAttachment:Destroy()
    end
    if hrp:FindFirstChild("SpeedVelocity") then
        hrp.SpeedVelocity:Destroy()
    end
    
    -- Buat Attachment baru
    local attachment = Instance.new("Attachment")
    attachment.Name = "SpeedAttachment"
    attachment.Parent = hrp
    
    -- Buat LinearVelocity
    local lv = Instance.new("LinearVelocity")
    lv.Name = "SpeedVelocity"
    lv.Attachment0 = attachment
    lv.MaxForce = math.huge
    lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    lv.Parent = hrp
    
    currentLV = lv
    
    -- Loop update velocity setiap frame
    lvConnection = RunService.Heartbeat:Connect(function()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then
            lv.VectorVelocity = Vector3.zero
            return
        end
        
        if isWalkspeedEnabled and currentWalkSpeedValue > DEFAULT_WALKSPEED then
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 and not hum.Sit and not hum.PlatformStand then
                -- LinearVelocity: Override velocity horizontal
                lv.VectorVelocity = Vector3.new(
                    moveDir.X * currentWalkSpeedValue,
                    0,
                    moveDir.Z * currentWalkSpeedValue
                )
            else
                lv.VectorVelocity = Vector3.zero
            end
        else
            lv.VectorVelocity = Vector3.zero
        end
    end)
end

-- ==========================================
-- Fungsi Helper untuk Apply WalkSpeed
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
    
    -- WalkSpeed asli SELALU tetap 16
    -- LinearVelocity yang handle movement
    hum.WalkSpeed = DEFAULT_WALKSPEED
end

-- ==========================================
-- Fungsi Helper untuk Apply JumpPower
-- ==========================================
local function applyJumpPower()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if isJumpPowerEnabled then
        -- JumpPower pakai hook (bukan LinearVelocity, karena lompatan = physics)
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
        -- 1. Reset karakter ke default
        if lp and lp.Character then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = DEFAULT_WALKSPEED
                hum.JumpPower = DEFAULT_JUMPPOWER
                hum.UseJumpPower = false
            end
            
            -- 2. Cleanup LinearVelocity instance
            local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if hrp:FindFirstChild("SpeedAttachment") then
                    hrp.SpeedAttachment:Destroy()
                end
                if hrp:FindFirstChild("SpeedVelocity") then
                    hrp.SpeedVelocity:Destroy()
                end
            end
        end
        
        -- 3. Reset hook state
        hooks.walkspeed = DEFAULT_WALKSPEED
        hooks.jumppower = DEFAULT_JUMPPOWER
        
        -- 4. Disconnect LinearVelocity connection
        if lvConnection then
            lvConnection:Disconnect()
            lvConnection = nil
        end
        
        -- 5. Reset LinearVelocity
        if currentLV then
            currentLV.VectorVelocity = Vector3.zero
        end
        
        -- 6. Rejoin server
        task.wait(0.3)
        TeleportService:Teleport(game.PlaceId, lp)
    end)
end

-- ==========================================
-- DETECTION: Script Close/Delete
-- ==========================================

-- Method 1: AncestryChanged
pcall(function()
    if script then
        script.AncestryChanged:Connect(function(child, parent)
            if child == script and parent == nil then
                cleanupAndRejoin()
            end
        end)
    end
end)

-- Method 2: Destroying event
pcall(function()
    if script and script.Destroying then
        script.Destroying:Connect(function()
            cleanupAndRejoin()
        end)
    end
end)

-- Method 3: Hook game shutdown/teleport
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

-- Method 4: Heartbeat watchdog
local lastHeartbeat = tick()
local watchdogConnection
watchdogConnection = RunService.Heartbeat:Connect(function()
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
-- UI Setup (Super Hot Monke UI)
-- ==========================================

-- Toggle WalkSpeed (LinearVelocity)
UI.newCheckBox(UI.Main, "Turn ON/Turn OFF", function(state)
    isWalkspeedEnabled = state
    applyWalkSpeed()
    
    -- Reset velocity kalau toggle OFF
    if not state and currentLV then
        currentLV.VectorVelocity = Vector3.zero
    end
end)

-- Slider WalkSpeed
UI.newSlider(UI.Main, "WalkSpeed (LinearVelocity)", 1, 100, function(value)
    currentWalkSpeedValue = value
    
    if isWalkspeedEnabled then
        applyWalkSpeed()
    end
end)

-- Toggle JumpPower (Hook)
UI.newCheckBox(UI.Main, "Turn ON/Turn OFF", function(state)
    isJumpPowerEnabled = state
    applyJumpPower()
end)

-- Slider JumpPower
UI.newSlider(UI.Main, "JumpPower (Velocity Method)", 50, 200, function(value)
    currentJumpPowerValue = value
    
    if isJumpPowerEnabled then
        applyJumpPower()
    end
end)

-- Tombol Manual Rejoin
UI.newButton(UI.Main, "Rejoin Server (Refresh Character)", function()
    cleanupAndRejoin()
end)

-- ==========================================
-- Auto Re-apply saat Respawn
-- ==========================================
local function onCharacterAdded(char)
    char:WaitForChild("HumanoidRootPart")
    char:WaitForChild("Humanoid")
    task.wait(0.2)
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = DEFAULT_WALKSPEED
        hum.UseJumpPower = false
    end
    
    -- Setup ulang LinearVelocity untuk karakter baru
    setupLinearVelocity(char)
    
    -- Re-apply status toggle + nilai slider saat respawn
    applyWalkSpeed()
    applyJumpPower()
end

if lp.Character then
    onCharacterAdded(lp.Character)
end
lp.CharacterAdded:Connect(onCharacterAdded)

-- ==========================================
-- Inisialisasi Awal
-- ==========================================
if lp.Character then
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = DEFAULT_WALKSPEED
        hum.JumpPower = DEFAULT_JUMPPOWER
        hum.UseJumpPower = false
    end
end
