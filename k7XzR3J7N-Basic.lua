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
local Paragraph = Change:CreateParagraph({Title = "🔄️ V-ShXTHAMC", Content = "- [+] Add Script & Fixed Some Bugs\n- [+] Updated Key System UI & Key Generator"})

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
            Duration = 6,
            Image = "x",
        })
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
