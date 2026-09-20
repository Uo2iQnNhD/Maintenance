-- ==========================================
-- Load UI Library
-- ==========================================
local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/zeutronxsite/M3kELKp3QMonkeUI/refs/heads/main/FmQTSqSpK.luau'))()

UI.Title.Text = "TLK PRISON [HOOKMETAMETHOD]"
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
-- Fungsi Helper untuk Apply Nilai
-- ==========================================
local function applyWalkSpeed()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if isWalkspeedEnabled then
        -- Toggle ON: pakai nilai slider
        hooks.walkspeed = currentWalkSpeedValue
        hum.WalkSpeed = currentWalkSpeedValue
    else
        -- Toggle OFF: reset ke default
        hooks.walkspeed = DEFAULT_WALKSPEED
        hum.WalkSpeed = DEFAULT_WALKSPEED
    end
end

local function applyJumpPower()
    local char = lp.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if isJumpPowerEnabled then
        hooks.jumppower = currentJumpPowerValue
        hum.JumpPower = currentJumpPowerValue
        hum.UseJumpPower = true
    else
        hooks.jumppower = DEFAULT_JUMPPOWER
        hum.JumpPower = DEFAULT_JUMPPOWER
        hum.UseJumpPower = false
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
            -- Script sudah tidak running, trigger cleanup
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
UI.newSlider(UI.Main, "WalkSpeed (Hookmetamethod)", 1, 100, function(value)
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
UI.newSlider(UI.Main, "JumpPower (Hookmetamethod)", 50, 200, function(value)
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
    char:WaitForChild("Humanoid")
    task.wait(0.2)
    
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
