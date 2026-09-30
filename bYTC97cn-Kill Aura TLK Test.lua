-- //==================================================================
-- // UNIVERSAL KILL AURA + ADVANCED ANTI-KICK BYPASS SYSTEM
-- // Support: 17 tools + Fist | 6 Layer Anti-Kick | Stealth Mode v2
-- // Author: waityouSkidLOL (Enhanced Edition)
-- //==================================================================

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")
local CoreGui           = game:GetService("CoreGui")
local LocalPlayer       = Players.LocalPlayer

-- Spam log awal
for i = 1, 20 do
    print("[UNIVERSAL AURA] Enhanced Edition | 6-Layer Anti-Kick Active")
end

-- //==================================================================
-- // DAFTAR SEMUA TOOL YANG DIDUKUNG
-- //==================================================================
local SUPPORTED_TOOLS = {
    "Pickaxe", "Axe", "PoliceBaton", "Shovel", "Pipe", "Knife",
    "Crowbar", "Bat", "Musket", "StopSign", "AK-47", "SprayPaint",
    "Taser", "Screwdriver", "Pliers", "Handsaw", "Hammer", "Fist"
}

-- Buat lookup table untuk pencarian cepat (O(1))
local TOOL_LOOKUP = {}
for _, name in ipairs(SUPPORTED_TOOLS) do
    TOOL_LOOKUP[name:lower()] = true
end

-- //==================================================================
-- // [1] ADVANCED ANTI-KICK BYPASS SYSTEM (6 LAYER)
-- //==================================================================
local bypassStats = {
    namecallBlocked = 0,
    kickFnBlocked   = 0,
    shutdownBlocked = 0,
    parentProtected = 0,
    coreGuiBlocked = 0,
    metaBlocked     = 0,
}

-- Daftar remote/fungsi berbahaya
local KICK_REMOTES = {
    "Kick", "KickPlayer", "Disconnect", "DisconnectPlayer",
    "AC_Kick", "AntiCheatKick", "SecurityKick", "KickClient",
    "SystemKick", "AdminKick", "Ban", "BanPlayer", "ForceKick",
    "AntiExploit", "Detection", "SecurityAlert", "CrashClient",
    "kick", "disconnect", "ban", "forcekick"
}

local KICK_FUNCTIONS = {
    "kick", "Kick", "disconnect", "Disconnect", "shutdown", "Shutdown",
    "Crash", "crash", "ForceClose", "forceclose"
}

-- ===== LAYER 1: hookmetamethod (__namecall) =====
local function installNamecallHook()
    if type(hookmetamethod) ~= "function" then
        warn("[ANTI-KICK L1] hookmetamethod tidak tersedia")
        return false
    end
    
    local ok, err = pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local name = tostring(self and self.Name or "")
            local lowerName = name:lower()
            
            if method == "FireServer" or method == "InvokeServer" then
                for _, kickName in ipairs(KICK_REMOTES) do
                    if lowerName:find(kickName:lower(), 1, true) then
                        bypassStats.namecallBlocked += 1
                        print("[ANTI-KICK L1] Diblokir: " .. name .. ":" .. method .. "()")
                        return nil
                    end
                end
            end
            
            -- Block pemanggilan :Kick() via namecall
            if method == "Kick" or method == "kick" then
                bypassStats.namecallBlocked += 1
                print("[ANTI-KICK L1] Diblokir: " .. name .. ":Kick() via namecall")
                return nil
            end
            
            return oldNamecall(self, ...)
        end))
    end)
    
    if ok then
        print("[ANTI-KICK L1] hookmetamethod berhasil dipasang")
        return true
    else
        warn("[ANTI-KICK L1] Gagal: " .. tostring(err))
        return false
    end
end

-- ===== LAYER 2: hookfunction (LocalPlayer:Kick) =====
local function installKickFunctionHook()
    if type(hookfunction) ~= "function" then
        warn("[ANTI-KICK L2] hookfunction tidak tersedia")
        return false
    end
    
    local success = false
    for _, fnName in ipairs(KICK_FUNCTIONS) do
        local ok = pcall(function()
            local kickFn = LocalPlayer[fnName]
            if type(kickFn) == "function" then
                hookfunction(kickFn, newcclosure(function(...)
                    bypassStats.kickFnBlocked += 1
                    print("[ANTI-KICK L2] Diblokir: LocalPlayer:" .. fnName .. "()")
                    return nil
                end))
                success = true
            end
        end)
    end
    
    -- Juga hook Player:Kick langsung di class
    pcall(function()
        local playerKick = Players.LocalPlayer.Kick
        if type(playerKick) == "function" then
            hookfunction(playerKick, newcclosure(function(self, reason)
                bypassStats.kickFnBlocked += 1
                print("[ANTI-KICK L2] Diblokir Player:Kick() - reason: " .. tostring(reason))
                return nil
            end))
            success = true
        end
    end)
    
    if success then
        print("[ANTI-KICK L2] hookfunction berhasil dipasang")
    else
        warn("[ANTI-KICK L2] Gagal pasang hookfunction")
    end
    return success
end

-- ===== LAYER 3: Parent Protection (Anti-Destroy) =====
local function installParentProtection()
    local ok = pcall(function()
        LocalPlayer.AncestryChanged:Connect(function(child, parent)
            if child == LocalPlayer and parent == nil then
                bypassStats.parentProtected += 1
                task.delay(0, function()
                    if not LocalPlayer.Parent then
                        pcall(function() LocalPlayer.Parent = Players end)
                        print("[ANTI-KICK L3] Mencegah LocalPlayer di-destroy")
                    end
                end)
            end
        end)
        
        -- Tambahan: cegah Character di-destroy paksa
        LocalPlayer.CharacterAdded:Connect(function(char)
            char.AncestryChanged:Connect(function(child, parent)
                if child == char and parent == nil then
                    task.delay(0, function()
                        if not char.Parent and LocalPlayer then
                            pcall(function() char.Parent = workspace end)
                        end
                    end)
                end
            end)
        end)
    end)
    
    if ok then
        print("[ANTI-KICK L3] Parent protection aktif")
    end
    return ok
end

-- ===== LAYER 4: Anti-Shutdown & Anti-Crash =====
local function installAntiShutdown()
    local success = false
    
    -- Hook game:Shutdown()
    pcall(function()
        if type(hookfunction) == "function" and type(game.Shutdown) == "function" then
            hookfunction(game.Shutdown, newcclosure(function()
                bypassStats.shutdownBlocked += 1
                print("[ANTI-KICK L4] Diblokir game:Shutdown()")
                return nil
            end))
            success = true
        end
    end)
    
    -- Hook fungsi crash umum
    local crashFns = {"crash", "Crash", "ForceCrash", "forcecrash"}
    for _, fn in ipairs(crashFns) do
        pcall(function()
            if type(game[fn]) == "function" then
                hookfunction(game[fn], newcclosure(function()
                    bypassStats.shutdownBlocked += 1
                    print("[ANTI-KICK L4] Diblokir game:" .. fn .. "()")
                    return nil
                end))
                success = true
            end
        end)
    end
    
    if success then
        print("[ANTI-KICK L4] Anti-shutdown aktif")
    end
    return success
end

-- ===== LAYER 5: CoreGui Protection (Block kick notifications) =====
local function installCoreGuiProtection()
    local ok = pcall(function()
        -- Monitor CoreGui untuk notifikasi kick
        CoreGui.ChildAdded:Connect(function(child)
            local name = child.Name:lower()
            if name:find("kick") or name:find("error") or name:find("disconnect") 
               or name:find("robloxgui") and name:find("prompt") then
                task.delay(0.05, function()
                    if child.Parent then
                        pcall(function() child:Destroy() end)
                        bypassStats.coreGuiBlocked += 1
                        print("[ANTI-KICK L5] Diblokir notifikasi: " .. child.Name)
                    end
                end)
            end
        end)
    end)
    
    if ok then
        print("[ANTI-KICK L5] CoreGui protection aktif")
    end
    return ok
end

-- ===== LAYER 6: Metatable Protection (Anti-Tamper) =====
local function installMetaProtection()
    if type(getrawmetatable) ~= "function" or type(setreadonly) ~= "function" then
        warn("[ANTI-KICK L6] Metatable functions tidak tersedia")
        return false
    end
    
    local ok = pcall(function()
        local playerMeta = getrawmetatable(LocalPlayer)
        if playerMeta then
            -- Proteksi terhadap modifikasi metatable oleh AC
            local oldIndex = playerMeta.__index
            local oldNewIndex = playerMeta.__newindex
            
            -- Jika ada __index custom, wrap untuk block akses "Kick"
            if type(oldIndex) == "function" then
                -- set readonly dulu untuk aman
                setreadonly(playerMeta, false)
                
                playerMeta.__index = newcclosure(function(self, key)
                    if key == "Kick" or key == "kick" then
                        bypassStats.metaBlocked += 1
                        return function()
                            print("[ANTI-KICK L6] Diblokir akses meta Kick")
                            return nil
                        end
                    end
                    return oldIndex(self, key)
                end)
                
                setreadonly(playerMeta, true)
            end
        end
    end)
    
    if ok then
        print("[ANTI-KICK L6] Metatable protection aktif")
    end
    return ok
end

-- ===== Monitor Statistik Bypass (tiap 10 detik) =====
task.spawn(function()
    while true do
        task.wait(10)
        local total = 0
        for _, v in pairs(bypassStats) do total += v end
        if total > 0 then
            print(string.format(
                "[ANTI-KICK STATS] Total blocked: %d | Namecall:%d Kick:%d Shutdown:%d Parent:%d CoreGui:%d Meta:%d",
                total, bypassStats.namecallBlocked, bypassStats.kickFnBlocked,
                bypassStats.shutdownBlocked, bypassStats.parentProtected,
                bypassStats.coreGuiBlocked, bypassStats.metaBlocked
            ))
        end
    end
end)

-- Aktifkan semua 6 layer
task.spawn(function()
    task.wait(1)
    
    local layers = {
        installNamecallHook(),
        installKickFunctionHook(),
        installParentProtection(),
        installAntiShutdown(),
        installCoreGuiProtection(),
        installMetaProtection(),
    }
    
    local active = 0
    for _, v in ipairs(layers) do if v then active += 1 end end
    
    print(string.format("[ANTI-KICK] %d/6 layer aktif", active))
end)

-- //==================================================================
-- // [2] UNIVERSAL KILL AURA (STEALTH MODE v2)
-- //==================================================================

local MAX_DISTANCE   = 14.4
local BASE_CD        = 0.29
local ATTACK_SPEED   = BASE_CD / 1.30
local SMOOTH_OFFSET  = 0.3
local RANDOM_DELAY   = {0.02, 0.08}

_G.UniversalAura = true

local lastAttackTime = 0
local attackCount = 0
local killCount = 0

-- ===== SMART TOOL FINDER (case-insensitive, support semua tool) =====
local function findAnyWeapon(character)
    if not character then return nil end
    
    -- Cari di character
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") or child:IsA("Model") then
            if TOOL_LOOKUP[child.Name:lower()] then
                return child
            end
        end
    end
    
    -- Fallback: cek di backpack jika tool belum di-equip
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
    local ok = pcall(function()
        CombatEvent = ReplicatedStorage:WaitForChild("Combat", 10)
    end)
    if ok then
        print("[AURA] Remote 'Combat' ditemukan")
    else
        warn("[AURA] Remote 'Combat' TIDAK ditemukan! Script tidak akan bekerja.")
    end
end)

-- ===== MAIN AURA LOOP =====
task.spawn(function()
    task.wait(2.5) -- tunggu bypass aktif
    print("[AURA] Universal Kill Aura dimulai - monitoring " .. #SUPPORTED_TOOLS .. " tools")
    
    while _G.UniversalAura do
        task.wait(ATTACK_SPEED + math.random(RANDOM_DELAY[1]*100, RANDOM_DELAY[2]*100)/100)
        
        local MyChar = LocalPlayer.Character
        local MyWeapon = findAnyWeapon(MyChar)
        local MyHRP = MyChar and MyChar:FindFirstChild("HumanoidRootPart")
        
        -- Skip jika tidak punya weapon yang didukung
        if not (MyChar and MyWeapon and MyHRP and CombatEvent) then
            continue
        end
        
        -- Rate limiter: max 4 serangan per detik
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
        
        -- Cari target terdekat (prioritas: health rendah -> jarak dekat)
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
                        -- Score: jarak + health ratio (prioritas target sekarat)
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
        
        -- Eksekusi serangan STEALTH MODE v2
        if closestTarget then
            local initialHealth = closestTarget.humanoid.Health
            
            pcall(function()
                local TargetTorso = closestTarget.torso
                
                -- Posisi attack dengan random offset kecil untuk variasi
                local randomOffset = Vector3.new(
                    math.random(-10, 10) / 50,
                    0,
                    math.random(-10, 10) / 50
                )
                local attackPos = TargetTorso.Position - (TargetTorso.CFrame.LookVector * SMOOTH_OFFSET) + randomOffset
                local originalCFrame = MyHRP.CFrame
                
                -- STEALTH v2: Lerp + rotation variation
                local targetLook = CFrame.new(attackPos, TargetTorso.Position)
                MyHRP.CFrame = originalCFrame:Lerp(targetLook, 1)
                
                -- Fire server
                CombatEvent:FireServer(MyChar, TargetTorso, MyWeapon)
                
                -- Kembali dengan lerp
                MyHRP.CFrame = MyHRP.CFrame:Lerp(originalCFrame, 1)
                
                -- Zero velocity + reset assembly
                MyHRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                MyHRP.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                
                -- Cek kill
                task.delay(0.1, function()
                    if closestTarget.humanoid and closestTarget.humanoid.Health <= 0 
                       and initialHealth > 0 then
                        killCount += 1
                        print("[KILL #" .. killCount .. "] Target eliminated with " .. MyWeapon.Name)
                    end
                end)
            end)
        end
    end
end)

-- //==================================================================
-- // [3] COMMANDS / KONTROL
-- //==================================================================
local function toggleAura()
    _G.UniversalAura = not _G.UniversalAura
    print("[UNIVERSAL AURA] Status: " .. (_G.UniversalAura and "ON" or "OFF"))
end

local function showStatus()
    print("=== UNIVERSAL KILL AURA STATUS ===")
    print("Aura Active: " .. tostring(_G.UniversalAura))
    print("Total Kills: " .. killCount)
    print("Supported Tools: " .. #SUPPORTED_TOOLS)
    print("Bypass Stats: ")
    for k, v in pairs(bypassStats) do
        print("  " .. k .. ": " .. v)
    end
    print("==================================")
end

_G.ToggleAura = toggleAura
_G.StopAura = function()
    _G.UniversalAura = false
    print("[UNIVERSAL AURA] Dihentikan permanen | Total kills: " .. killCount)
end
_G.AuraStatus = showStatus

print("[+] Script loaded. 6-Layer Anti-Kick + Universal Kill Aura aktif.")
print("[+] Supported tools: " .. table.concat(SUPPORTED_TOOLS, ", "))
print("[+] Commands:")
print("    _G.ToggleAura()    - ON/OFF")
print("    _G.StopAura()      - Stop permanen")
print("    _G.AuraStatus()    - Lihat statistik")
