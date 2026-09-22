local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ZETHUB | Area 51 Remake | V1.75",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading......",
   LoadingSubtitle = "By Zeutronxsite",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Zethubxsite"
   },
})

-- Notification Rayfield
Rayfield:Notify({
   Title = "⚠️ NOTIFICATION ALERT",
   Content = "- Thank you for using this script\n- This script is still in beta stage so there are many bugs",
   Duration = 5,
   Image = 4483362458,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay!",
         Callback = function()
        end
      },
   },
})

local Change = Window:CreateTab("📰 Changelogs", nil)
local MainTab = Window:CreateTab("🌌 Main Scripts", nil) -- Title, Image
local Theme = Window:CreateTab("🎨 Theme", nil)
local Misc = Window:CreateTab("🔥 Credits", nil)


local MainSection = Change:CreateSection("Information")
local Paragraph = Change:CreateParagraph({Title = "✅ VERSION 1.3", Content = "- [+] Add Teleporter\n- [+] Add Local Scripts\n- [+] Add 🎨 Theme\n- [+] Fixed Bug"})

local Paragraph = Change:CreateParagraph({Title = "✅ VERSION 1.5", Content = "- [+] Add Destroy UI\n- [+] Add Details\n- [+] Add 🔥 Credits"})

local Paragraph = Change:CreateParagraph({Title = "✅ VERSION 1.75 (Latest Update)", Content = "- [+] Add Teleporter Tool And More"})

local MainSection = MainTab:CreateSection("Teleporter")
local Paragraph = MainTab:CreateParagraph({Title = "📢 INFORMATION", Content = "Teleport tools require 2,500–5,555 Money to purchase."})

local locationsV1 = {
    ["Base/Safety"]              = CFrame.new(14, 528, -682),
    ["Shop"]            = CFrame.new(-13, 529, -970),
    ["Badge Collector"]             = CFrame.new(-278, 294, 173),
    ["Crafting"]         = CFrame.new(728, 269, -975),
    ["Shop Tunnel"]        = CFrame.new(1185, 185, -1562),
    ["Portal"]        = CFrame.new(-71, 298, -1621),
    ["The Abbys"]          = CFrame.new(1412, 185, -4596),
}

-- ==========================================
-- FUNGSI TELEPORT INSTANT
-- ==========================================

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function teleportTo(targetCFrame)
    local char = lp.Character
    if not char then
        warn("[ZETHUB] Character Not Spawn!")
        return
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        warn("[ZETHUB] HumanoidRootPart not found!")
        return
    end

    -- Teleport instant
    hrp.CFrame = targetCFrame
    hrp.Velocity = Vector3.new(0, 0, 0)
end

-- ==========================================
-- DROPDOWN VERSI 1
-- ==========================================

local optionsV1 = {}

for name, _ in pairs(locationsV1) do
    table.insert(optionsV1, name)
end

table.sort(optionsV1)

-- Default pilihan pertama
local selectedLocationV1 = optionsV1[1]

-- Dropdown hanya menyimpan pilihan
local DropdownV1 = MainTab:CreateDropdown({
    Name = "Teleporter",
    Options = optionsV1,
    CurrentOption = {selectedLocationV1},
    MultipleOptions = false,
    Flag = "TeleporterV1",
    Callback = function(Options)
        if Options and #Options > 0 and Options[1] then
            selectedLocationV1 = Options[1]
            print("[ZETHUB] Selected location: " .. tostring(selectedLocationV1))
        end
    end,
})

-- ==========================================
-- BUTTON EKSEKUSI
-- ==========================================

local Button = MainTab:CreateButton({
    Name = "Execute Selected Script",
    Callback = function()
        if not selectedLocationV1 then
            warn("[ZETHUB] No location selected!")
            return
        end

        local targetCFrame = locationsV1[selectedLocationV1]

        if not targetCFrame then
            warn("[ZETHUB] Invalid location: " .. tostring(selectedLocationV1))
            return
        end

        teleportTo(targetCFrame)
        print("[ZETHUB] Teleported to: " .. tostring(selectedLocationV1))
    end,
})

local locationsV2 = {
    ["Reaper Room"]              = CFrame.new(541, 297, -1721),
    ["Orthadon's Room"]            = CFrame.new(-710, 354, -891),
    ["Jack'o Latern"]             = CFrame.new(1159, 188, -2017),
    ["005 Room"]         = CFrame.new(196, 223, -332),
    ["VenomShank"]        = CFrame.new(439, -96, -849),
    ["Staff Of Steam"]        = CFrame.new(393, 249, -2796),
}

-- ==========================================
-- FUNGSI TELEPORT INSTANT
-- ==========================================

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function teleportTo(targetCFrame)
    local char = lp.Character
    if not char then
        warn("[ZETHUB] Character Not Spawn!")
        return
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        warn("[ZETHUB] HumanoidRootPart not found!")
        return
    end

    -- Teleport instant
    hrp.CFrame = targetCFrame
    hrp.Velocity = Vector3.new(0, 0, 0)
end

-- ==========================================
-- DROPDOWN VERSI 1
-- ==========================================

local optionsV2 = {}

for name, _ in pairs(locationsV2) do
    table.insert(optionsV2, name)
end

table.sort(optionsV2)

-- Default pilihan pertama
local selectedLocationV2 = optionsV2[1]

-- Dropdown hanya menyimpan pilihan
local DropdownV1 = MainTab:CreateDropdown({
    Name = "Teleporter To Moster",
    Options = optionsV2,
    CurrentOption = {selectedLocationV2},
    MultipleOptions = false,
    Flag = "TeleporterV1",
    Callback = function(Options)
        if Options and #Options > 0 and Options[1] then
            selectedLocationV2 = Options[1]
            print("[ZETHUB] Selected location: " .. tostring(selectedLocationV2))
        end
    end,
})

-- ==========================================
-- BUTTON EKSEKUSI
-- ==========================================

local Button = MainTab:CreateButton({
    Name = "Execute Selected Script",
    Callback = function()
        if not selectedLocationV2 then
            warn("[ZETHUB] No location selected!")
            return
        end

        local targetCFrame = locationsV2[selectedLocationV2]

        if not targetCFrame then
            warn("[ZETHUB] Invalid location: " .. tostring(selectedLocationV2))
            return
        end

        teleportTo(targetCFrame)
        print("[ZETHUB] Teleported to: " .. tostring(selectedLocationV2))
    end,
})

local MainSection = MainTab:CreateSection("Teleporter Gun/tool")
local locationsV3 = {
    ["Pickaxe"]              = CFrame.new(1289, 97, -5229),
    ["Frying Pan"]            = CFrame.new(223, 310, -1566),
    ["Platinum M1 Grand"]         = CFrame.new(345, 332, -2435),
    ["Bronze Medkit"]        = CFrame.new(382, 372, -2316),
    ["Vulcan"]        = CFrame.new(523, 300, -2441),
    ["Icicle Launcher"]        = CFrame.new(-920, 271, -2476),
    ["Stygian Blaster"]        = CFrame.new(1126, 55, -5082),
    ["LXW Gun"]        = CFrame.new(-328, 189, -2770),
}

-- ==========================================
-- FUNGSI TELEPORT INSTANT
-- ==========================================

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function teleportTo(targetCFrame)
    local char = lp.Character
    if not char then
        warn("[ZETHUB] Character Not Spawn!")
        return
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        warn("[ZETHUB] HumanoidRootPart not found!")
        return
    end

    -- Teleport instant
    hrp.CFrame = targetCFrame
    hrp.Velocity = Vector3.new(0, 0, 0)
end

-- ==========================================
-- DROPDOWN VERSI 1
-- ==========================================

local optionsV3 = {}

for name, _ in pairs(locationsV3) do
    table.insert(optionsV3, name)
end

table.sort(optionsV3)

-- Default pilihan pertama
local selectedLocationV3 = optionsV3[1]

-- Dropdown hanya menyimpan pilihan
local DropdownV1 = MainTab:CreateDropdown({
    Name = "Teleporter To Tools (Map)",
    Options = optionsV3,
    CurrentOption = {selectedLocationV3},
    MultipleOptions = false,
    Flag = "TeleporterV1",
    Callback = function(Options)
        if Options and #Options > 0 and Options[1] then
            selectedLocationV3 = Options[1]
            print("[ZETHUB] Selected location: " .. tostring(selectedLocationV2))
        end
    end,
})

local Button = MainTab:CreateButton({
    Name = "Execute Selected Script",
    Callback = function()
        if not selectedLocationV3 then
            warn("[ZETHUB] No location selected!")
            return
        end

        local targetCFrame = locationsV3[selectedLocationV3]

        if not targetCFrame then
            warn("[ZETHUB] Invalid location: " .. tostring(selectedLocationV3))
            return
        end

        teleportTo(targetCFrame)
        print("[ZETHUB] Teleported to: " .. tostring(selectedLocationV3))
    end,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local espEnabled = false
local espObjects = {} -- Menyimpan semua BillboardGui ESP
local updateConnection = nil

-- ==========================================
-- Mapping Warna Team
-- ==========================================
local function getTeamColor(player)
    local team = player.Team
    local teamName = team and team.Name or ""
    
    local teamColorMap = {
        ["Survivor"] = Color3.fromRGB(50, 100, 255),

        -- === Color Picker Team ===
        ["Red"]      = Color3.fromRGB(255, 50, 50),
        ["Blue"]     = Color3.fromRGB(50, 100, 255),
        ["Green"]    = Color3.fromRGB(50, 255, 50),
        ["Yellow"]   = Color3.fromRGB(255, 255, 50),
        ["Purple"]   = Color3.fromRGB(200, 50, 255),
        ["White"]    = Color3.fromRGB(255, 255, 255),
        ["Black"]    = Color3.fromRGB(50, 50, 50),
    }
    
    for name, color in pairs(teamColorMap) do
        if string.lower(teamName) == string.lower(name) then
            return color
        end
    end
    
    if team and team.TeamColor then
        return team.TeamColor.Color
    end
    
    return Color3.fromRGB(255, 255, 255)
end

-- ==========================================
-- Fungsi untuk Membuat ESP ke satu Player
-- ==========================================
local function createESP(targetPlayer)
    if targetPlayer == lp then return end
    
    local function setupESP(char)
        if not char then return end
        local head = char:WaitForChild("Head", 5)
        local hum = char:WaitForChild("Humanoid", 5)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if not head or not hum or not hrp then return end
        
        local teamColor = getTeamColor(targetPlayer)
        
        -- Hapus ESP lama (mencegah duplikat)
        if head:FindFirstChild("PlayerESP_GUI") then
            head.PlayerESP_GUI:Destroy()
        end
        if char:FindFirstChild("PlayerESP_HL") then
            char.PlayerESP_HL:Destroy()
        end
        
        -- 1. Highlight (Outline Player)
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerESP_HL"
        highlight.FillColor = teamColor
        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = char
        highlight.Parent = char
        
        -- 2. BillboardGui (Wadah untuk semua info)
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "PlayerESP_GUI"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 140, 0, 60) -- Diperbesar untuk menampung info baru
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.ResetOnSpawn = false
        billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        billboard.Parent = head
        
        -- 3. Nama Player
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 0, 14)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = targetPlayer.Name
        nameLabel.TextColor3 = teamColor
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 12
        nameLabel.Parent = billboard
        
        -- 4. Label Jarak (BARU)
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Name = "DistanceLabel"
        distanceLabel.Size = UDim2.new(1, 0, 0, 12)
        distanceLabel.Position = UDim2.new(0, 0, 0, 13)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = "[0m]"
        distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distanceLabel.TextStrokeTransparency = 0
        distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distanceLabel.Font = Enum.Font.GothamBold
        distanceLabel.TextSize = 11
        distanceLabel.Parent = billboard
        
        -- 5. Health Bar Background
        local hpBg = Instance.new("Frame")
        hpBg.Name = "HealthBg"
        hpBg.Size = UDim2.new(0, 120, 0, 6)
        hpBg.Position = UDim2.new(0.5, -60, 0, 26)
        hpBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        hpBg.BorderSizePixel = 0
        hpBg.Parent = billboard
        
        local hpCornerBg = Instance.new("UICorner")
        hpCornerBg.CornerRadius = UDim.new(0, 3)
        hpCornerBg.Parent = hpBg
        
        -- 6. Health Bar Fill
        local hpFill = Instance.new("Frame")
        hpFill.Name = "HealthFill"
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        hpFill.BorderSizePixel = 0
        hpFill.Parent = hpBg
        
        local hpCornerFill = Instance.new("UICorner")
        hpCornerFill.CornerRadius = UDim.new(0, 3)
        hpCornerFill.Parent = hpFill
        
        -- 7. Label HP (BARU) - Contoh: "HP: 100/100"
        local hpLabel = Instance.new("TextLabel")
        hpLabel.Name = "HPLabel"
        hpLabel.Size = UDim2.new(1, 0, 0, 12)
        hpLabel.Position = UDim2.new(0, 0, 0, 34)
        hpLabel.BackgroundTransparency = 1
        hpLabel.Text = "HP: 100/100"
        hpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        hpLabel.TextStrokeTransparency = 0
        hpLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        hpLabel.Font = Enum.Font.GothamBold
        hpLabel.TextSize = 11
        hpLabel.Parent = billboard
        
        -- 8. Label Team (BARU - opsional, agar lebih informatif)
        local teamLabel = Instance.new("TextLabel")
        teamLabel.Name = "TeamLabel"
        teamLabel.Size = UDim2.new(1, 0, 0, 10)
        teamLabel.Position = UDim2.new(0, 0, 0, 46)
        teamLabel.BackgroundTransparency = 1
        teamLabel.Text = "[" .. (targetPlayer.Team and targetPlayer.Team.Name or "No Team") .. "]"
        teamLabel.TextColor3 = teamColor
        teamLabel.TextStrokeTransparency = 0
        teamLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        teamLabel.Font = Enum.Font.Gotham
        teamLabel.TextSize = 10
        teamLabel.Parent = billboard
        
        -- Simpan referensi untuk update
        espObjects[targetPlayer] = {
            billboard = billboard,
            highlight = highlight,
            hpFill = hpFill,
            hpLabel = hpLabel,
            distanceLabel = distanceLabel,
            nameLabel = nameLabel,
            teamLabel = teamLabel,
            humanoid = hum,
            hrp = hrp,
            character = char
        }
    end
    
    if targetPlayer.Character then
        setupESP(targetPlayer.Character)
    end
    
    targetPlayer.CharacterAdded:Connect(function(char)
        if espEnabled then
            task.wait(0.5)
            setupESP(char)
        end
    end)
end

-- ==========================================
-- Fungsi Hapus Semua ESP
-- ==========================================
local function clearAllESP()
    for _, data in pairs(espObjects) do
        pcall(function()
            if data.billboard then data.billboard:Destroy() end
            if data.highlight then data.highlight:Destroy() end
        end)
    end
    espObjects = {}
end

-- ==========================================
-- Fungsi Update: HP + Jarak (Looping)
-- ==========================================
local function startUpdateLoop()
    if updateConnection then updateConnection:Disconnect() end
    
    updateConnection = RunService.RenderStepped:Connect(function()
        -- Dapatkan HRP player lokal
        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        
        for player, data in pairs(espObjects) do
            pcall(function()
                local hum = data.humanoid
                local hrp = data.hrp
                local fill = data.hpFill
                local hpLabel = data.hpLabel
                local distLabel = data.distanceLabel
                
                -- === Update HP Bar & Label ===
                if hum and fill and hpLabel and hum.Parent then
                    local currentHP = math.floor(hum.Health)
                    local maxHP = math.floor(hum.MaxHealth)
                    local percent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    
                    -- Update ukuran bar
                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    
                    -- Update teks HP: "HP: 100/100"
                    hpLabel.Text = string.format("HP: %d/%d", currentHP, maxHP)
                    
                    -- Warna bar berubah: Hijau -> Kuning -> Merah
                    if percent > 0.6 then
                        fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        hpLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif percent > 0.3 then
                        fill.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                        hpLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                    else
                        fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        hpLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                end
                
                -- === Update Jarak (Meter) ===
                if myHRP and hrp and hrp.Parent and distLabel then
                    local distance = (myHRP.Position - hrp.Position).Magnitude
                    
                    -- Format jarak bulat
                    distLabel.Text = string.format("[%dm]", math.floor(distance))
                    
                    -- Warna jarak: Merah (dekat), Kuning (sedang), Putih (jauh)
                    if distance < 15 then
                        distLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                    elseif distance < 40 then
                        distLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                    else
                        distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end)
        end
    end)
end

-- ==========================================
-- Fungsi Toggle ESP ON/OFF
-- ==========================================
local function toggleESP(state)
    espEnabled = state
    
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= lp then
                createESP(player)
            end
        end
        startUpdateLoop()
    else
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        clearAllESP()
    end
end

-- ==========================================
-- Handle Player Baru Join / Leave
-- ==========================================
Players.PlayerAdded:Connect(function(player)
    if espEnabled and player ~= lp then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        pcall(function()
            if espObjects[player].billboard then espObjects[player].billboard:Destroy() end
            if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
        end)
        espObjects[player] = nil
    end
end)

-- ==========================================
-- UI Toggle (ESP Player)
-- ==========================================
local Toggle = MainTab:CreateToggle({
   Name = "ESP Player",
   CurrentValue = false,
   Flag = "ESPPlayerToggle",
   Callback = function(Value)
       toggleESP(Value)
   end,
})

-- ==========================================
-- Inisialisasi Awal
-- ==========================================
if lp.Character then
    -- Siap pakai, tinggal toggle untuk aktifkan
end


local MainSection = MainTab:CreateSection("Local Scripts")
local Paragraph = MainTab:CreateParagraph({Title = "📢 INFORMATION", Content = "All these scripts are supported in this game."})

local Button = MainTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})

local Button = MainTab:CreateButton({
   Name = "Area 51 Remake GUI",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/KGuestHUB/Mods/refs/heads/main/Universal"))()
   end,
})

local MainSection = Theme:CreateSection("Choose Theme")
local Paragraph = Theme:CreateParagraph({Title = "📢 INFORMATION", Content = "All these themes are built-in from Rayfield"})
-- Dropdown Theme Selector
local ThemeDropdown = Theme:CreateDropdown({
    Name = "Select Theme",
    Options = {
        "Default", 
        "AmberGlow", 
        "Bloom", 
        "Amethyst", 
        "DarkBlue", 
        "Green", 
        "Light", 
        "Ocean"
    },
    CurrentOption = {"Default"}, -- Tema awal
    MultipleOptions = false,     -- Hanya bisa pilih satu tema
    Flag = "ThemeSelector",      -- Identifier unik untuk config
    Callback = function(Options)
        -- Options adalah tabel, karena MultipleOptions = false, kita ambil index pertama [1]
        local selectedTheme = Options[1]
        
        -- Mencocokkan string pilihan dengan fungsi ModifyTheme
        if selectedTheme == "Default" then
            Window.ModifyTheme('Default')
        elseif selectedTheme == "AmberGlow" then
            Window.ModifyTheme('AmberGlow')
        elseif selectedTheme == "Bloom" then
            Window.ModifyTheme('Bloom')
        elseif selectedTheme == "Amethyst" then
            Window.ModifyTheme('Amethyst')
        elseif selectedTheme == "DarkBlue" then
            Window.ModifyTheme('DarkBlue')
        elseif selectedTheme == "Green" then
            Window.ModifyTheme('Green')
        elseif selectedTheme == "Light" then
            Window.ModifyTheme('Light')
        elseif selectedTheme == "Ocean" then
            Window.ModifyTheme('Ocean')
        end
        
        print("Theme changed to: " .. selectedTheme)
    end,
})

local MainSection = Theme:CreateSection("Configuration")

local Button = Theme:CreateButton({
   Name = "Zeutron [HUB]",
   Callback = function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/F4DiY9yZ9-Checking.luau"))()
   end,
})

local Button = Theme:CreateButton({
   Name = "Destroy UI",
   Callback = function()
   Rayfield:Notify({
   Title = "⚠️ WARNING",
   Content = "This script will self-destruct in 7 seconds!",
   Duration = 6,
   Image = "triangle-alert",
})
   wait(7)
   Rayfield:Destroy()
   end,
})

local MainSection = Misc:CreateSection("Information")
local Paragraph = Misc:CreateParagraph({Title = "⚒️ CREATOR SCRIPT", Content = "- 3streakzx: Programmer\n- 4Streakzx: Builder\n- Therepositori & kamunanya3vx: Tester Scripts"})

local Paragraph = Misc:CreateParagraph({Title = "🔍 LINK SCRIPTS & SUPPORT", Content = "- Pastebin.com/u/Ty4rds\n- https://github.com/ioerhub"})

local Paragraph = Misc:CreateParagraph({Title = "🛡️ INFORMATION", Content = "- Latest Version: Latest Update\n- Max Version: 3.0\n- Status: 🟡 Progress"})

local Paragraph = Misc:CreateParagraph({Title = "🌐 GROUP & TEAM", Content = "- @Zeutron Community\n- @Zyptrue Dev Community\n- @IOER State Community"})
