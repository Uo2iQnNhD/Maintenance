-- ============================================
-- Free Korblox + Headless (Client-Side Only)
-- Support: R6 & R15
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Asset IDs
local KORPLEX_MESHES = {
    RightUpperLeg = "rbxassetid://902942096",
    RightLowerLeg = "rbxassetid://902942093",
    RightFoot     = "rbxassetid://902942089",
    Texture       = "rbxassetid://902843398"
}

-- Fungsi Headless (sembunyikan kepala + wajah)
local function applyHeadless(character)
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if head then
        -- Sembunyikan mesh kepala
        head.Transparency = 1
        
        -- Sembunyikan Face Decal
        for _, v in ipairs(head:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
            -- Sembunyikan Face wrap (R15)
            if v:IsA("WrapLayer") or v.Name == "face" then
                v.Transparency = 1
            end
        end
    end
end

-- Fungsi Korblox (terapkan mesh ke kaki kanan)
local function applyKorblox(character)
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- Cek R6 atau R15
    local rigType = humanoid.RigType
    
    if rigType == Enum.HumanoidRigType.R6 then
        -- R6: Hanya punya "Right Leg" (satu bagian)
        local rightLeg = character:FindFirstChild("Right Leg")
        if rightLeg then
            -- Hapus mesh lama
            for _, v in ipairs(rightLeg:GetChildren()) do
                if v:IsA("SpecialMesh") or v:IsA("BlockMesh") then
                    v:Destroy()
                end
            end
            -- Buat mesh baru
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshId = KORPLEX_MESHES.RightLowerLeg
            mesh.TextureId = KORPLEX_MESHES.Texture
            mesh.Scale = Vector3.new(1, 1, 1)
            mesh.Parent = rightLeg
            rightLeg.Transparency = 1
        end
        
    elseif rigType == Enum.HumanoidRigType.R15 then
        -- R15: Kaki terbagi 3 bagian
        local parts = {
            RightUpperLeg = character:FindFirstChild("RightUpperLeg"),
            RightLowerLeg = character:FindFirstChild("RightLowerLeg"),
            RightFoot     = character:FindFirstChild("RightFoot")
        }
        
        -- RightUpperLeg
        if parts.RightUpperLeg then
            for _, v in ipairs(parts.RightUpperLeg:GetChildren()) do
                if v:IsA("SpecialMesh") then v:Destroy() end
            end
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshId = KORPLEX_MESHES.RightUpperLeg
            mesh.TextureId = KORPLEX_MESHES.Texture
            mesh.Parent = parts.RightUpperLeg
            parts.RightUpperLeg.Transparency = 1
        end
        
        -- RightLowerLeg
        if parts.RightLowerLeg then
            for _, v in ipairs(parts.RightLowerLeg:GetChildren()) do
                if v:IsA("SpecialMesh") then v:Destroy() end
            end
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshId = KORPLEX_MESHES.RightLowerLeg
            mesh.TextureId = KORPLEX_MESHES.Texture
            mesh.Parent = parts.RightLowerLeg
            parts.RightLowerLeg.Transparency = 1
        end
        
        -- RightFoot
        if parts.RightFoot then
            for _, v in ipairs(parts.RightFoot:GetChildren()) do
                if v:IsA("SpecialMesh") then v:Destroy() end
            end
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshId = KORPLEX_MESHES.RightFoot
            mesh.TextureId = KORPLEX_MESHES.Texture
            mesh.Parent = parts.RightFoot
            parts.RightFoot.Transparency = 1
        end
    end
end

-- Fungsi utama untuk apply semua efek
local function applyAll(character)
    applyHeadless(character)
    applyKorblox(character)
end

-- Event listener
local function onCharacterAdded(character)
    -- Tunggu sebentar sampai humanoid siap
    character:WaitForChild("Humanoid", 5)
    task.wait(0.5)
    applyAll(character)
    
    -- Terapkan ulang saat karakter respawn
    character.Humanoid.Died:Connect(function()
        task.wait(2)
        if player.Character then
            applyAll(player.Character)
        end
    end)
end

-- Setup
if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)

-- Heartbeat untuk jaga-jaga (apply terus setiap frame jika perlu)
RunService.Heartbeat:Connect(function()
    if player.Character then
        applyAll(player.Character)
    end
end)
