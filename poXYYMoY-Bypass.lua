-- ==========================================
-- SAFE ANTI-RESTRICTION (NO RENDER ERRORS)
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Daftar script yang akan dihancurkan
local scriptsToKill = {
    "Anticheat", "ServerHitbox", 
    "ToolHandler", "FlyScript", "ClientModificationScript", 
    "JumpLimit", "Movement", "Physics", "PlayerInteractionGui"
}

local StarterCharacterScripts = game:GetService("StarterPlayer").StarterCharacterScripts

-- 1. Hancurkan Script di StarterCharacterScripts
for _, name in ipairs(scriptsToKill) do
    local s = StarterCharacterScripts:FindFirstChild(name)
    if s then 
        s:Destroy()
    end
end

-- 2. HOOK YANG LEBIH AMAN - Hanya hook fungsi spesifik Humanoid
local humanoidCache = {}

local function setupHumanoidHooks(char)
    local humanoid = char:WaitForChild("Humanoid", 10)
    if not humanoid or humanoidCache[humanoid] then return end
    humanoidCache[humanoid] = true
    
    -- Simpan fungsi asli
    local originalSetStateEnabled = humanoid.SetStateEnabled
    local originalChangeState = humanoid.ChangeState
    
    -- Hook SetStateEnabled (untuk bypass JumpLimit)
    if hookfunction then
        hookfunction(humanoid.SetStateEnabled, function(self, state, enabled)
            -- Izinkan semua state, terutama Jumping
            if state == Enum.HumanoidStateType.Jumping then
                return originalSetStateEnabled(self, state, true)
            end
            return originalSetStateEnabled(self, state, enabled)
        end)
        
        -- Hook ChangeState (untuk bypass Ragdoll paksa)
        hookfunction(humanoid.ChangeState, function(self, state)
            -- Blokir state Ragdoll yang tidak diinginkan
            if state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.Physics then
                return originalChangeState(self, Enum.HumanoidStateType.GettingUp)
            end
            return originalChangeState(self, state)
        end)
    end
end

-- 3. CLEAN CHARACTER FUNCTION (Tanpa hook berbahaya)
local function cleanCharacter(char)
    task.wait(0.5)
    
    -- Hancurkan script di Character
    for _, name in ipairs(scriptsToKill) do
        local s = char:FindFirstChild(name)
        if s then 
            s:Destroy() 
        end
    end
    
    -- Setup hook yang aman
    setupHumanoidHooks(char)
    
    local humanoid = char:WaitForChild("Humanoid")
    
    -- Loop ringan untuk UI dan Camera (tanpa hook berat)
    local cleanConnection
    cleanConnection = RunService.RenderStepped:Connect(function()
        if not char or not char.Parent or humanoid.Health <= 0 then
            cleanConnection:Disconnect()
            return
        end
        
        -- Kembalikan camera ke humanoid jika diambil alih
        if workspace.CurrentCamera and workspace.CurrentCamera.CameraSubject ~= humanoid then
            workspace.CurrentCamera.CameraSubject = humanoid
        end
        
        -- Pastikan UI tetap aktif
        pcall(function()
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        end)
    end)
    
    -- Reset nilai-nilai restriktif
    local restrictedValues = {"IsCuffed", "FrontCuffed", "IsHogged", "IsGrabbed", "RagDoll", "DownState", "SJ", "LockInSeat"}
    for _, valName in ipairs(restrictedValues) do
        local val = char:FindFirstChild(valName)
        if val and val:IsA("BoolValue") then
            val.Value = false
        end
    end
    
    -- Set WalkSpeed dan JumpPower normal
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50
end

-- Jalankan pada character saat ini
if LocalPlayer.Character then
    cleanCharacter(LocalPlayer.Character)
end

-- Jalankan setiap respawn
LocalPlayer.CharacterAdded:Connect(cleanCharacter)

warn("Working??")
