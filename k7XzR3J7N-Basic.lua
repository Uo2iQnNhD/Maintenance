local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ZETHUB | PORTAL HUB",
   Icon = "user", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Initializing......",
   LoadingSubtitle = "By Exterminate0",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Zethubx.file"
   },
})

-- Notification Rayfield
Rayfield:Notify({
   Title = "Information",
   Content = "Thank you for using this script, more stuff is coming",
   Duration = 6,
   Image = "bell",
})

-- Local Tab
local Change = Window:CreateTab("Changelog", "mails")
local MainTab = Window:CreateTab("Main Scipts", "sword")
local Theme = Window:CreateTab("Theme & Settings", "settings")


-- Local Changelog Tab
local MainSection = Change:CreateSection("Information & Version")

local Paragraph = Change:CreateParagraph({Title = "🔄️ V-D74XABR4", Content = "- [+] Add Main Developer Mode, Admin Mode, Basic\n- [+] Add Main Scripts\n- [+] Add Theme & Settings"})
local Paragraph = Change:CreateParagraph({Title = "🔄️ V-ShXTHAMC", Content = "- [+] Add Script & Fixed Some Bugs\n- [+] Updated Key System UI & Key Generator\n- [+] Add Infinite yield & Esp Player"})

local MainSection = Change:CreateSection("Next Update & Version")
local Paragraph = Change:CreateParagraph({Title = "❌ V-XSSJVLZY", Content = "Unknown, Coming Soon!"})

-- local Maintab
local MainSection = MainTab:CreateSection("Game Support")

local Paragraph = MainTab:CreateParagraph({Title = "🛡️ System Information", Content = "Choose Your Script and execute that script"})
local Paragraph = MainTab:CreateParagraph({Title = "📚 Guide Information", Content = "When executed, the automatic picker selects and runs the appropriate script based on the game being played. if the game is supported, it uses a different script than it would for an unsupported game"})

-- Initialize with because the CurrentOption default
local selectedOptions = {}

local function runScript(optionName)
    if optionName == "🎮 Automatic [Picker]" then
        Rayfield:Notify({
            Title = "Failed to execute",
            Content = "This script isn't working due to several issues, please use a different script",
            Duration = 8,
            Image = "x",
        })
        pcall(function()
            
        end)
    
    elseif optionName == "👑 Zeutron [HUB]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Release/refs/heads/main/New%20Interface"))()
        end)

    elseif optionName == "🛠️ TLK Prison" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/IOERHUB/CheckingV2/refs/heads/main/Protection"))()
        end)

    elseif optionName == "🎯 Area 51 Remake" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/Area-51-Remake/refs/heads/main/Latest%20Version"))()
        end)

    elseif optionName == "🚗 Jailbreak" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/M6txEKBDBreak/refs/heads/main/Working"))()
        end)

    elseif optionName == "🔪 Violence District" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/XptC65ba-MainDestrict/refs/heads/main/5N8Eji9H"))()
        end)

    elseif optionName == "🔥 Power Incremental" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/IOERHUB/Power-Incremental/refs/heads/main/Working"))()
        end)
    end
end

local Dropdown = MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = {"🎮 Automatic [Picker]", "👑 Zeutron [HUB]", "🛠️ TLK Prison", "🎯 Area 51 Remake",
                "🚗 Jailbreak", "🔪 Violence District", "🔥 Power Incremental"},
    CurrentOption = {"None"},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(options)
        -- Handle both table and string returns
        if type(options) == "table" then
            selectedOptions = options
        elseif type(options) == "string" then
            selectedOptions = {options}
        else
            selectedOptions = {}
        end
    end,
})

local Button = MainTab:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        if #selectedOptions == 0 or selectedOptions[1] == "None" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please select a script first!",
                Duration = 5,
                Image = "triangle-alert",
            })
            return
        end
        
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            if option and option ~= "None" then
                runScript(option)
            end
        end
    end
})

local MainSection = MainTab:CreateSection("???-Locked")
local Paragraph = MainTab:CreateParagraph({Title = "📢 Information", Content = "More Stuff Is coming Soon"})


local MainSection = Theme:CreateSection("Select Theme")
local Paragraph = Theme:CreateParagraph({Title = "📚 Guide Information", Content = "Select a color to change the Scripts"})
local selectedOptions = {}

local function runScript2(optionName)
    if optionName == "Default" then
        task.wait(0.5)
        pcall(function()
            Window.ModifyTheme('Default')
        end)
    
    elseif optionName == "AmberGlow" then
        task.wait(0.5)
        pcall(function()
            Window.ModifyTheme('AmberGlow')
        end)

    elseif optionName == "Bloom" then
        task.wait(0.5)
        pcall(function()
            Window.ModifyTheme('Bloom')
        end)

    elseif optionName == "Amethyst" then
        task.wait(0.5)
        pcall(function()
            Window.ModifyTheme('Amethyst')
        end)

    elseif optionName == "DarkBlue" then
        task.wait(0.5)
        pcall(function()
            Window.ModifyTheme('DarkBlue')
        end)

    elseif optionName == "Green" then
        task.wait(0.5)
        pcall(function()
           Window.ModifyTheme('Green')
        end)

    elseif optionName == "Light" then
        task.wait(0.5)
        pcall(function()
            Window.ModifyTheme('Light')
        end)

    elseif optionName == "Ocean" then
        task.wait(0.5)
        pcall(function()
            Window.ModifyTheme('Ocean')
        end)
    end
end

local Dropdown = Theme:CreateDropdown({
    Name = "Select Scripts",
    Options = {"Default", "AmberGlow", "Bloom", "Amethyst",
                "DarkBlue", "Green", "Light", "Ocean"},
    CurrentOption = {"None"},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(options)
        -- Handle both table and string returns
        if type(options) == "table" then
            selectedOptions = options
        elseif type(options) == "string" then
            selectedOptions = {options}
        else
            selectedOptions = {}
        end
    end,
})

local Button = Theme:CreateButton({
    Name = "Execute Selected Theme",
    Callback = function()
        if #selectedOptions == 0 or selectedOptions[1] == "None" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please select a Theme first!",
                Duration = 5,
                Image = "triangle-alert",
            })
            return
        end
        
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            if option and option ~= "None" then
                runScript2(option)
            end
        end
    end
})

local MainSection = Theme:CreateSection("More Settings")

local Button = Theme:CreateButton({
    Name = "Zeutron [HUB]",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Release/refs/heads/main/New%20Interface"))()
   end
})

local Button = Theme:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Release/refs/heads/main/New%20Interface"))()
   end
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
        ["Fugitive"] = Color3.fromRGB(255, 50, 50),
        ["Prison"]   = Color3.fromRGB(255, 150, 0),
        ["Police"]   = Color3.fromRGB(0, 100, 255),
        ["Civilian"] = Color3.fromRGB(50, 255, 50),
        
        -- === TEAM TAMBAHAN & DIUBAH WARNA NYA ===
        ["Hostage"]  = Color3.fromRGB(255, 0, 255),
        ["Choosing"] = Color3.fromRGB(0, 255, 255),
        ["ADMIN"]    = Color3.fromRGB(255, 215, 0),

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
local Toggle = Theme:CreateToggle({
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

local Button = Theme:CreateButton({
    Name = "Destroy Interface",
    Callback = function()
    Rayfield:Notify({
                    Title = "⚠️ Warning Detected",
                    Content = "The script will self-destruct in 7 seconds!",
                    Duration = 7,
                    Image = "shield-alert",
                })
        wait(7)
    Rayfield:Destroy()
   end
})
