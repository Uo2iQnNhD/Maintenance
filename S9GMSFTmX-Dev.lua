local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ZETHUB | DEVELOPER MODE",
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
local dev = Window:CreateTab("Developer Settings", "wrench")
local Theme = Window:CreateTab("Theme & Settings", "settings")


-- Local Changelog Tab
local MainSection = Change:CreateSection("Information & Version")

local Paragraph = Change:CreateParagraph({Title = "🔄️ V-39MB2ZZS", Content = "- [+] Add Main Developer Mode, Admin Mode, Basic\n- [+] Add Main Scripts\n- [+] Add Theme & Settings"})
local Paragraph = Change:CreateParagraph({Title = "🔄️ V-LLQCH3DC", Content = "- [+] Add Script & Fixed Some Bugs\n- [+] Updated Key System UI & Key Generator\n- [+] Add 🥚 Steal an Egg"})

local MainSection = Change:CreateSection("Next Update & Version")
local Paragraph = Change:CreateParagraph({Title = "❌ V-7H4RXYE5", Content = "Unknown, Coming Soon!"})

-- local Maintab
local MainSection = MainTab:CreateSection("Game Support")

local Paragraph = MainTab:CreateParagraph({Title = "🛡️ System Information", Content = "Choose Your Script and execute that script"})
local Paragraph = MainTab:CreateParagraph({Title = "📚 Guide Information", Content = "When executed, the automatic picker selects and runs the appropriate script based on the game being played. if the game is supported, it uses a different script than it would for an unsupported game"})

-- Initialize with because the CurrentOption default
local selectedOptions = {}

local function runScript(optionName)
    if optionName == "🎮 Automatic [Picker]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/Checking/refs/heads/main/reworked"))()
        end)
    
    elseif optionName == "👑 Zeutron [HUB]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Release/refs/heads/main/New%20Interface"))()
        end)

    elseif optionName == "🛠️ TLK Prison" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/IOERHUB/CheckingV2/refs/heads/main/Protection"))()
        end)

    elseif optionName == "🎯 Area 51 Remake" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/Area-51-Remake/refs/heads/main/Latest%20Version"))()
        end)

    elseif optionName == "🚗 Jailbreak" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/M6txEKBDBreak/refs/heads/main/Working"))()
        end)

    elseif optionName == "🔪 Violence District" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/XptC65ba-MainVD.lua"))()
        end)

    elseif optionName == "🔥 Power Incremental" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/IOERHUB/Power-Incremental/refs/heads/main/Working"))()
        end)

    elseif optionName == "🥚 Steal an Egg" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/sAcfzDLt-Steal%20An%20Egg.lua"))()
        end)

    elseif optionName == "🚀 Untitled Upgrade Tree" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed, Please wait 3 second!",
            Duration = 6,
            Image = "check",
        })
        task.wait(3)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/XoDBQiPs-Untitled%20Upg%20Tree"))()
        end)
		
    end
end

local Dropdown = MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = {"🎮 Automatic [Picker]", "👑 Zeutron [HUB]", "🛠️ TLK Prison", "🎯 Area 51 Remake",
                "🚗 Jailbreak", "🔪 Violence District", "🔥 Power Incremental", "🥚 Steal an Egg", "🚀 Untitled Upgrade Tree"},
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

local MainSection = dev:CreateSection("Modification Player")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local plr = Players.LocalPlayer

-- Inisialisasi variable global
_G.infinjump = false

local Toggle = dev:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
      _G.infinjump = Value

      -- Notifikasi saat dinyalakan
      if Value then
         Rayfield:Notify({
            Title = "System Information",
            Content = "Infinite jump has been successfully enabled.",
            Duration = 6,
            Image = "person-standing",
         })
      else
         -- Notifikasi saat dimatikan
         Rayfield:Notify({
            Title = "System Information",
            Content = "Infinite jump has been disabled.",
            Duration = 6,
            Image = "person-standing",
         })
      end
   end,
})

-- Gunakan UserInputService.JumpRequest (Mendukung Spasi PC, Tombol Lompat Mobile, & Controller)
-- Diletakkan di luar callback agar tidak membuat koneksi ganda (mencegah lag/memory leak)
UserInputService.JumpRequest:Connect(function()
   if _G.infinjump then
      local char = plr.Character
      if char then
         local humanoid = char:FindFirstChildOfClass("Humanoid")
         if humanoid then
            -- Metode modern dan stabil untuk infinite jump
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            
            -- CATATAN: Jika game tertentu memblokir cara di atas dan kamu 
            -- membutuhkan trik "Seated" seperti script asli kamu, hapus tanda komentar (--), 
            -- dan gunakan task.wait() (karena wait() sudah deprecated).
            -- task.wait()
            -- humanoid:ChangeState(Enum.HumanoidStateType.Seated)
         end
      end
   end
end)

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

-- Inisialisasi variable global
_G.walkspeedValue = 16
_G.jumppowerValue = 50
_G.walkspeedActive = false
_G.jumppowerActive = false

-- Fungsi helper untuk mendapatkan humanoid
local function getHumanoid()
   local char = plr.Character
   if char then
      return char:FindFirstChildOfClass("Humanoid")
   end
   return nil
end

-- ============================================
-- WALKSPEED SECTION
-- ============================================

local WalkSpeedSlider = dev:CreateSlider({
   Name = "WalkSpeed",
   Range = {0, 5000},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      _G.walkspeedValue = Value
      -- Update langsung jika toggle sedang aktif
      if _G.walkspeedActive then
         local humanoid = getHumanoid()
         if humanoid then
            humanoid.WalkSpeed = Value
         end
      end
   end,
})

local WalkSpeedToggle = dev:CreateToggle({
   Name = "Turn ON/OFF WalkSpeed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle",
   Callback = function(Value)
      _G.walkspeedActive = Value
      local humanoid = getHumanoid()
      
      if Value then
         -- AKTIFKAN: Terapkan nilai slider
         if humanoid then
            humanoid.WalkSpeed = _G.walkspeedValue
         end
         Rayfield:Notify({
            Title = "WalkSpeed ON",
            Content = "WalkSpeed on with value " .. _G.walkspeedValue,
            Duration = 5,
            Image = "zap",
         })
      else
         -- NONAKTIFKAN: Reset ke default (16)
         if humanoid then
            humanoid.WalkSpeed = 16
         end
         Rayfield:Notify({
            Title = "WalkSpeed OFF",
            Content = "WalkSpeed disable (reset to 16)",
            Duration = 5,
            Image = "x-circle",
         })
      end
   end,
})

-- ============================================
-- JUMPPOWER SECTION
-- ============================================

local JumpPowerSlider = dev:CreateSlider({
   Name = "JumpPower",
   Range = {0, 5000},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      _G.jumppowerValue = Value
      -- Update langsung jika toggle sedang aktif
      if _G.jumppowerActive then
         local humanoid = getHumanoid()
         if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = Value
         end
      end
   end,
})

local JumpPowerToggle = dev:CreateToggle({
   Name = "Turn ON/OFF JumpPower",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
      _G.jumppowerActive = Value
      local humanoid = getHumanoid()
      
      if Value then
         -- AKTIFKAN: Terapkan nilai slider
         if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = _G.jumppowerValue
         end
         Rayfield:Notify({
            Title = "JumpPower ON",
            Content = "JumpPower on with value " .. _G.jumppowerValue,
            Duration = 5,
            Image = "trending-up",
         })
      else
         -- NONAKTIFKAN: Reset ke default (50)
         if humanoid then
            humanoid.JumpPower = 50
         end
         Rayfield:Notify({
            Title = "JumpPower OFF",
            Content = "JumpPower disable (reset to 50)",
            Duration = 5,
            Image = "x-circle",
         })
      end
   end,
})

-- ============================================
-- AUTO REAPPLY SAAT RESPAWN
-- ============================================
plr.CharacterAdded:Connect(function(char)
   task.wait(1) -- Tunggu humanoid siap
   local humanoid = char:WaitForChild("Humanoid", 5)
   if not humanoid then return end
   
   if _G.walkspeedActive then
      humanoid.WalkSpeed = _G.walkspeedValue
   end
   if _G.jumppowerActive then
      humanoid.UseJumpPower = true
      humanoid.JumpPower = _G.jumppowerValue
   end
end)

local MainSection = dev:CreateSection("Visual Player")

local Button = dev:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
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

local Button = dev:CreateButton({
    Name = "Executor Editor [BETA]",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/nf5guunQd-exec/refs/heads/main/executor.luau"))()
 end,
})

local Button = dev:CreateButton({
    Name = "Waypoint Manager [S.W.P]",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/xtvqz7us-Waypoint.lua"))()
 end,
})


local Button = dev:CreateButton({
    Name = "Anti-Fling [Protection]",
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/MhJDcWjR"))()
 end,
})

-- ============================================
-- PLAYER JOIN / LEAVE NOTIFICATION SYSTEM (ULTRA FIXED & SAFE)
-- ============================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Buat ScreenGui khusus untuk notifikasi
local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "JoinLeaveNotificationGui"
NotificationGui.ResetOnSpawn = false
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotificationGui.IgnoreGuiInset = true
NotificationGui.DisplayOrder = 999999 -- Paling depan dari UI lain (BIAR TIDAK KETIMPA)
NotificationGui.Parent = PlayerGui

-- Flag global untuk mengontrol status toggle
_G.JoinLeaveEnabled = false

-- Tabel untuk menyimpan referensi notifikasi yang sedang aktif
local activeNotifications = {}

-- ============================================
-- SISTEM ANTREAN (QUEUE) AMAN
-- ============================================
local notificationQueue = {}
local isProcessingQueue = false

-- Deklarasi fungsi di awal agar pasti terbaca (hoisting)
local processNotificationQueue
local showPlayerNotification

processNotificationQueue = function()
	-- Jika sedang memproses atau antrean kosong, hentikan
	if isProcessingQueue or #notificationQueue == 0 then return end
	
	isProcessingQueue = true
	
	-- Ambil data notifikasi pertama dari antrean
	local data = table.remove(notificationQueue, 1)
	
	-- Panggil fungsi dengan pengecekan tipe data agar tidak "attempt to call a nil value"
	if type(showPlayerNotification) == "function" then
		showPlayerNotification(data.playerName, data.userId, data.isJoining)
	end
	
	-- Beri delay sebelum memproses notifikasi berikutnya
	task.delay(0.5, function()
		isProcessingQueue = false
		if type(processNotificationQueue) == "function" then
			processNotificationQueue()
		end
	end)
end

-- ============================================
-- FUNGSI UTAMA
-- ============================================

local function getAvatarUrl(userId)
	if not userId or userId == 0 then
		return "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end
	return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=150&height=150&format=png"
end

local function getCurrentTime()
	-- Gunakan pcall untuk mencegah error jika executor memblokir os.date
	local success, time = pcall(function()
		return os.date("*t")
	end)
	if success and time then
		return string.format("%02d:%02d:%02d", time.hour, time.min, time.sec)
	end
	return "00:00:00"
end

local function updateNotificationPositions()
	for i, frame in ipairs(activeNotifications) do
		if frame.Parent then
			local count = #activeNotifications
			local yOffset = -(100 + (count - i) * 90)
			local targetPosition = UDim2.new(1, -340, 1, yOffset)
			
			TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = targetPosition
			}):Play()
		end
	end
end

showPlayerNotification = function(playerName, userId, isJoining)
	local themeColor = isJoining and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(255, 80, 80)
	local actionText = isJoining and "Joined the Server" or "Left the Server"
	
	local notifFrame = Instance.new("Frame")
	notifFrame.Name = "PlayerNotification"
	notifFrame.Size = UDim2.new(0, 320, 0, 80)
	notifFrame.Position = UDim2.new(1, 20, 1, 20) 
	notifFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	notifFrame.BorderSizePixel = 0
	notifFrame.Parent = NotificationGui
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = notifFrame
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = themeColor
	stroke.Thickness = 2
	stroke.Parent = notifFrame
	
	local avatarImage = Instance.new("ImageLabel")
	avatarImage.Size = UDim2.new(0, 50, 0, 50)
	avatarImage.Position = UDim2.new(0, 12, 0, 15)
	avatarImage.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	avatarImage.BorderSizePixel = 0
	avatarImage.Image = getAvatarUrl(userId)
	avatarImage.Parent = notifFrame
	
	local avatarCorner = Instance.new("UICorner")
	avatarCorner.CornerRadius = UDim.new(1, 0)
	avatarCorner.Parent = avatarImage
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -75, 0, 20)
	titleLabel.Position = UDim2.new(0, 72, 0, 12)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = actionText
	titleLabel.TextColor3 = themeColor
	titleLabel.TextSize = 14
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = notifFrame
	
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -75, 0, 20)
	nameLabel.Position = UDim2.new(0, 72, 0, 30)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = playerName
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextSize = 15
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = notifFrame
	
	-- ============================================
	-- PERBAIKAN UTAMA: Menggunakan pcall untuk game.MaxPlayers
	-- ============================================
	local currentPlayers = #Players:GetPlayers()
	if not isJoining then
		currentPlayers = math.max(0, currentPlayers - 1)
	end

	-- Coba ambil game.MaxPlayers dengan aman. Jika error (seperti di game UGC), gunakan fallback 99
	local maxPlayers = 99 
	local success, result = pcall(function()
		return game.MaxPlayers
	end)
	
	if success and type(result) == "number" and result > 0 then
		maxPlayers = result
	end
	
	local infoText = string.format("Players Left: %d | Time: %s", 
		currentPlayers, 
		getCurrentTime()
	)
	
	local infoLabel = Instance.new("TextLabel")
	infoLabel.Size = UDim2.new(1, -75, 0, 18)
	infoLabel.Position = UDim2.new(0, 72, 0, 50)
	infoLabel.BackgroundTransparency = 1
	infoLabel.Text = infoText
	infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	infoLabel.TextSize = 11
	infoLabel.Font = Enum.Font.Gotham
	infoLabel.TextXAlignment = Enum.TextXAlignment.Left
	infoLabel.Parent = notifFrame
	
	table.insert(activeNotifications, notifFrame)
	updateNotificationPositions()
	
	task.delay(4, function()
		if not notifFrame.Parent then return end
		
		TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 20, 1, 20),
			BackgroundTransparency = 1
		}):Play()
		
		TweenService:Create(avatarImage, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
		TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(nameLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		TweenService:Create(infoLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
		
		task.wait(0.5)
		notifFrame:Destroy()
		
		for idx, frame in ipairs(activeNotifications) do
			if frame == notifFrame then
				table.remove(activeNotifications, idx)
				break
			end
		end
		
		updateNotificationPositions()
	end)
end

-- ============================================
-- EVENT LISTENERS (JOIN / LEAVE)
-- ============================================

Players.PlayerAdded:Connect(function(player)
	if not _G.JoinLeaveEnabled then return end
	
	table.insert(notificationQueue, {
		playerName = player.Name, 
		userId = player.UserId, 
		isJoining = true
	})
	if type(processNotificationQueue) == "function" then
		processNotificationQueue()
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if not _G.JoinLeaveEnabled then return end
	
	table.insert(notificationQueue, {
		playerName = player.Name, 
		userId = player.UserId, 
		isJoining = false
	})
	if type(processNotificationQueue) == "function" then
		processNotificationQueue()
	end
end)

-- ============================================
-- UI LIBRARY TOGGLE (RAYFIELD)
-- ============================================

-- Pastikan variabel 'dev' (Tab/Window Rayfield) sudah didefinisikan di atas script ini
local JoinLeaveToggle = Theme:CreateToggle({
   Name = "Player Notification",
   CurrentValue = false,
   Flag = "ToggleJoinLeaveNotif", 
   Callback = function(Value)
      _G.JoinLeaveEnabled = Value
      
      if Value then
         -- Safeguard: Pastikan LocalPlayer ada sebelum mengambil data
         local pName = (LocalPlayer and LocalPlayer.Name) or "Unknown"
         local pId = (LocalPlayer and LocalPlayer.UserId) or 0
         
         table.insert(notificationQueue, {
            playerName = pName .. " (You)", 
            userId = pId, 
            isJoining = true
         })
         
         -- Safeguard: Cek apakah fungsi benar-benar ada sebelum dipanggil
         if type(processNotificationQueue) == "function" then
            processNotificationQueue()
         else
            warn("Rayfield Fix: processNotificationQueue is nil!")
         end
      end
   end,
})
