local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ZETHUB | Jailbreak | v1.5",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading......",
   LoadingSubtitle = "By Zeutronxsite",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Zethubisbest"
   },
})

Rayfield:Notify({
   Title = "Notification Alert",
   Content = "Thank you for using this scripts",
   Duration = 6,
   Image = "bell",
})

-- Workspace
local Change = Window:CreateTab("📰 Changelog", nil)
local MainTab = Window:CreateTab("⚔️ Main Scipts", nil)
local Theme = Window:CreateTab("🎨 Theme & Settings", nil)


-- Main Scripts
local MainSection = Change:CreateSection("Information & Version")

local Paragraph = Change:CreateParagraph({Title = "✅ VERSION 1.5", Content = "- [+] Add Scipts GUI And Auto farm\n- [+] Add Changelog\n- [+] Add Theme and Destroy"})


local MainSection = MainTab:CreateSection("Scripts UI/GUI")

local Paragraph = MainTab:CreateParagraph({Title = "🛡️ System Information", Content = "This Scripts Is safe and has been tested\n- All these scripts are not mine"})

-- Initialize with because the CurrentOption default
local selectedOptions = {}

local function runScript(optionName)
    if optionName == "Rendex [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotWhyLclc/Rendex/main/Loader.luau", true))()
        end)
    
    elseif optionName == "Flow [KEYLESS]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/5946add9ab91f1e04cb005346a8b1968.lua", true))()
        end)

    elseif optionName == "Sexsation [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/730854e5b6499ee91deb1080e8e12ae3.lua"))()
        end)

    elseif optionName == "Iliomium [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/dUAj0Vpx"))()
        end)

    elseif optionName == "Spark [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ultimatep568/Spark-Hub/refs/heads/main/SparkHub_Loader.lua"))()
        end)
    end
end

local Dropdown = MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = {"Rendex [FREE]", "Flow [KEYLESS]", "Iliomium [FREE]", "Spark [FREE]"},
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

local MainSection = MainTab:CreateSection("Auto Farm")

local Paragraph = MainTab:CreateParagraph({Title = "🛡️ System Information", Content = "This Scripts Auto farm Money and op"})

-- Initialize with because the CurrentOption default
local selectedOptions = {}

local function runScript2(optionName)
    if optionName == "Blitz [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/BlitzIsKing/UniversalFarm/main/Loader/Regular'))()
        end)
    
    elseif optionName == "Snowy [KEYLESS]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4ad6a2d2335968486879c1b1a2dcefc6937ea63c8acb88e703a1ec95a4a146ea/download"))()
        end)

    elseif optionName == "Project Auto [KEYLESS]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
        loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoRobV6'))()
        wait(2)
        loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoArrestV4'))()
        end)
    end
end

local Dropdown = MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = {"Blitz [FREE]", "Snowy [KEYLESS]", "Project Auto [KEYLESS]"},
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
                runScript2(option)
            end
        end
    end
})


local MainSection = Theme:CreateSection("Select Theme")
local Paragraph = Theme:CreateParagraph({Title = "❓ System Guide", Content = "Select a color to change the Scripts"})
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

local MainSection = Theme:CreateSection("More Settings")

local Button = Theme:CreateButton({
    Name = "ZETHUB GUI",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Release/refs/heads/main/New%20Interface"))()
   end
})


local Button = Theme:CreateButton({
    Name = "Destroy UI/Interface",
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
