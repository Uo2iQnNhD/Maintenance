-- ==========================================
-- Load UI Library
-- ==========================================
local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/zeutronxsite/M3kELKp3QMonkeUI/refs/heads/main/FmQTSqSpK.luau'))()

UI.Title.Text = "TLK PRISON [RANDOMIZATION]"
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

-- ==========================================
-- Konfigurasi Randomization
-- ==========================================
local CONFIG = {
    walkVariation = 0.10,      -- ±10% variasi untuk WalkSpeed
    jumpVariation = 0.10,      -- ±10% variasi untuk JumpPower
    minInterval = 0.3,         -- Interval minimum update (detik)
    maxInterval = 0.8,         -- Interval maximum update (detik)
    useRandomization = true,   -- Toggle randomization on/off
}

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
-- Randomization Functions
-- ==========================================
local function getRandomizedValue(baseValue, variationPercent)
    if not CONFIG.useRandomization then
        return baseValue
    end
    
    local variation = baseValue * variationPercent
    local minVal = baseValue - variation
    local maxVal = baseValue + variation
    
    -- Random value dengan 1 decimal agar tidak terlalu aneh
    local randomVal = math.random(minVal * 10, maxVal * 10) / 10
    
    return randomVal
end

-- ==========================================
-- Fungsi Helper untuk Apply Nilai
-- ==========================================
local function applyWalkSpeed()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if isWalkspeedEnabled then
        if currentWalkSpeedValue > DEFAULT_WALKSPEED then
            local finalSpeed = getRandomizedValue(currentWalkSpeedValue, CONFIG.walkVariation)
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

local function applyJumpPower()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if isJumpPowerEnabled then
        if currentJumpPowerValue > DEFAULT_JUMPPOWER then
            local finalPower = getRandomizedValue(currentJumpPowerValue, CONFIG.jumpVariation)
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
-- Randomization Loop
-- ==========================================
local lastWalkApplyTime = 0
local lastJumpApplyTime = 0
local nextWalkInterval = math.random(CONFIG.minInterval * 10, CONFIG.maxInterval * 10) / 10
local nextJumpInterval = math.random(CONFIG.minInterval * 10, CONFIG.maxInterval * 10) / 10

RunService.Heartbeat:Connect(function()
    local now = tick()
    
    -- Randomization WalkSpeed
    if isWalkspeedEnabled and currentWalkSpeedValue > DEFAULT_WALKSPEED then
        if now - lastWalkApplyTime >= nextWalkInterval then
            applyWalkSpeed()
            lastWalkApplyTime = now
            nextWalkInterval = math.random(CONFIG.minInterval * 10, CONFIG.maxInterval * 10) / 10
        end
    end
    
    -- Randomization JumpPower
    if isJumpPowerEnabled and currentJumpPowerValue > DEFAULT_JUMPPOWER then
        if now - lastJumpApplyTime >= nextJumpInterval then
            applyJumpPower()
            lastJumpApplyTime = now
            nextJumpInterval = math.random(CONFIG.minInterval * 10, CONFIG.maxInterval * 10) / 10
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
        -- 1. Reset karakter ke default
        if lp and lp.Character then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = DEFAULT_WALKSPEED
                hum.JumpPower = DEFAULT_JUMPPOWER
                hum.UseJumpPower = false
            end
        end
        
        -- 2. Reset hook state
        hooks.walkspeed = DEFAULT_WALKSPEED
        hooks.jumppower = DEFAULT_JUMPPOWER
        
        -- 3. Rejoin server (teleport ke place yang sama)
        task.wait(0.3)
        TeleportService:Teleport(game.PlaceId, lp)
    end)
end

-- ==========================================
-- DETECTION: Script Close/Delete
-- ==========================================

-- Method 1: AncestryChanged (detect saat script dihapus dari parent)
pcall(function()
    if script then
        script.AncestryChanged:Connect(function(child, parent)
            if child == script and parent == nil then
                cleanupAndRejoin()
            end
        end)
    end
end)

-- Method 2: Destroying event (detect saat script di-destroy)
pcall(function()
    if script and script.Destroying then
        script.Destroying:Connect(function()
            cleanupAndRejoin()
        end)
    end
end)

-- Method 3: Hook game shutdown/teleport (detect manual rejoin/kick)
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

-- Method 4: Heartbeat watchdog (detect jika script berhenti running)
local lastHeartbeat = tick()
local watchdogConnection
watchdogConnection = RunService.Heartbeat:Connect(function()
    lastHeartbeat = tick()
end)

-- Cek setiap 5 detik apakah script masih hidup
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

-- Toggle WalkSpeed
UI.newCheckBox(UI.Main, "Turn ON/Turn OFF", function(state)
    isWalkspeedEnabled = state
    applyWalkSpeed()
end)

-- Slider WalkSpeed
UI.newSlider(UI.Main, "WalkSpeed (Randomization)", 1, 100, function(value)
    currentWalkSpeedValue = value
    
    if isWalkspeedEnabled then
        applyWalkSpeed()
    end
end)

-- Toggle JumpPower
UI.newCheckBox(UI.Main, "Turn ON/Turn OFF", function(state)
    isJumpPowerEnabled = state
    applyJumpPower()
end)

-- Slider JumpPower
UI.newSlider(UI.Main, "JumpPower (Randomization)", 50, 200, function(value)
    currentJumpPowerValue = value
    
    if isJumpPowerEnabled then
        applyJumpPower()
    end
end)

-- Toggle Randomization
UI.newCheckBox(UI.Main, "Enable Anti-Pattern Detection", function(state)
    CONFIG.useRandomization = state
end)

-- Tombol Manual Rejoin
UI.newButton(UI.Main, "Rejoin Server (Refresh Character)", function()
    cleanupAndRejoin()
end)

-- ==========================================
-- Auto Re-apply saat Respawn
-- ==========================================
local function onCharacterAdded(char)
    char:WaitForChild("Humanoid")
    task.wait(0.2)
    
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
