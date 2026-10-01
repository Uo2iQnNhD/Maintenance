-- toggle
local Toggle = MainTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "UniversalKillAura",
    Callback = function(Value)
        _G.UniversalAura = Value
    end,
})

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local LocalPlayer       = Players.LocalPlayer

-- //==================================================================
-- // DAFTAR SEMUA TOOL YANG DIDUKUNG
-- //==================================================================
local SUPPORTED_TOOLS = {
    "Pickaxe", "Axe", "PoliceBaton", "Shovel", "Pipe", "Knife",
    "Crowbar", "Bat", "Musket", "StopSign", "Screwdriver", 
    "Pliers", "Handsaw", "Hammer", "Fist"
}

local TOOL_LOOKUP = {}
for _, name in ipairs(SUPPORTED_TOOLS) do
    TOOL_LOOKUP[name:lower()] = true
end

-- //==================================================================
-- // [1] ANTI-KICK BYPASS (HANYA LAYER 1: hookmetamethod __namecall)
-- //==================================================================
local KICK_REMOTES = {
    "Kick", "KickPlayer", "Disconnect", "DisconnectPlayer",
    "AC_Kick", "AntiCheatKick", "SecurityKick", "KickClient",
    "SystemKick", "AdminKick", "Ban", "BanPlayer", "ForceKick",
    "AntiExploit", "Detection", "SecurityAlert", "CrashClient",
    "kick", "disconnect", "ban", "forcekick"
}

if type(hookmetamethod) == "function" then
    pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local name = tostring(self and self.Name or "")
            local lowerName = name:lower()
            
            if method == "FireServer" or method == "InvokeServer" then
                for _, kickName in ipairs(KICK_REMOTES) do
                    if lowerName:find(kickName:lower(), 1, true) then
                        return nil
                    end
                end
            end
            
            if method == "Kick" or method == "kick" then
                return nil
            end
            
            return oldNamecall(self, ...)
        end))
    end)
end

-- //==================================================================
-- // [2] UNIVERSAL KILL AURA (STEALTH MODE v2) — TIDAK DIUBAH
-- //==================================================================

local MAX_DISTANCE   = 14.4
local BASE_CD        = 0.29
local ATTACK_SPEED   = BASE_CD / 1.30
local SMOOTH_OFFSET  = 0.3
local RANDOM_DELAY   = {0.02, 0.08}

_G.UniversalAura = false

local lastAttackTime = 0
local attackCount = 0
local killCount = 0

-- ===== SMART TOOL FINDER =====
local function findAnyWeapon(character)
    if not character then return nil end
    
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") or child:IsA("Model") then
            if TOOL_LOOKUP[child.Name:lower()] then
                return child
            end
        end
    end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, child in ipairs(backpack:GetChildren()) do
            if child:IsA("Tool") then
                if TOOL_LOOKUP[child.Name:lower()] then
                    return child
                end
            end
        end
    end
    
    return nil
end

-- Pre-fetch remote
local CombatEvent = nil
task.spawn(function()
    pcall(function()
        CombatEvent = ReplicatedStorage:WaitForChild("Combat", 10)
    end)
end)

-- ===== MAIN AURA LOOP =====
task.spawn(function()
    while true do
        task.wait(ATTACK_SPEED + math.random(RANDOM_DELAY[1]*100, RANDOM_DELAY[2]*100)/100)
        
        if not _G.UniversalAura then
            continue
        end
        
        local MyChar = LocalPlayer.Character
        local MyWeapon = findAnyWeapon(MyChar)
        local MyHRP = MyChar and MyChar:FindFirstChild("HumanoidRootPart")
        
        if not (MyChar and MyWeapon and MyHRP and CombatEvent) then
            continue
        end
        
        local now = tick()
        if now - lastAttackTime < 0.25 then
            attackCount += 1
            if attackCount > 4 then
                task.wait(0.5)
                attackCount = 0
                continue
            end
        else
            attackCount = 1
        end
        lastAttackTime = now
        
        local closestTarget = nil
        local closestScore = math.huge
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local TargetChar = player.Character
                local TargetTorso = TargetChar:FindFirstChild("Torso") or TargetChar:FindFirstChild("HumanoidRootPart")
                local TargetHumanoid = TargetChar:FindFirstChildOfClass("Humanoid")
                
                if TargetTorso and TargetHumanoid and TargetHumanoid.Health > 0 then
                    local distance = (MyHRP.Position - TargetTorso.Position).Magnitude
                    if distance <= MAX_DISTANCE then
                        local score = distance + (TargetHumanoid.Health / TargetHumanoid.MaxHealth) * 5
                        if score < closestScore then
                            closestScore = score
                            closestTarget = {
                                char = TargetChar,
                                torso = TargetTorso,
                                humanoid = TargetHumanoid,
                                distance = distance
                            }
                        end
                    end
                end
            end
        end
        
        if closestTarget then
            local initialHealth = closestTarget.humanoid.Health
            
            pcall(function()
                local TargetTorso = closestTarget.torso
                
                local randomOffset = Vector3.new(
                    math.random(-10, 10) / 50,
                    0,
                    math.random(-10, 10) / 50
                )
                local attackPos = TargetTorso.Position - (TargetTorso.CFrame.LookVector * SMOOTH_OFFSET) + randomOffset
                local originalCFrame = MyHRP.CFrame
                
                local targetLook = CFrame.new(attackPos, TargetTorso.Position)
                MyHRP.CFrame = originalCFrame:Lerp(targetLook, 1)
                
                CombatEvent:FireServer(MyChar, TargetTorso, MyWeapon)
                
                MyHRP.CFrame = MyHRP.CFrame:Lerp(originalCFrame, 1)
                
                MyHRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                MyHRP.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                
                task.delay(0.1, function()
                    if closestTarget.humanoid and closestTarget.humanoid.Health <= 0 
                       and initialHealth > 0 then
                        killCount += 1
                    end
                end)
            end)
        end
    end
end)
