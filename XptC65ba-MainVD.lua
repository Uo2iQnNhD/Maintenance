local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ZETHUB | Violence District | v177",
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

local Paragraph = Change:CreateParagraph({Title = "🔁 VERSION 174", Content = "- [+] Add Scipts GUI And Auto farm\n- [+] Add Changelog\n- [+] Add Theme and Destroy"})
local Paragraph = Change:CreateParagraph({Title = "🔁 VERSION 175", Content = "- [+] Add More Scripts"})
local Paragraph = Change:CreateParagraph({Title = "🔁 VERSION 177", Content = "- [+] Updated Script Bolong HUB"})


local MainSection = MainTab:CreateSection("Scripts UI/GUI")

local Paragraph = MainTab:CreateParagraph({Title = "🛡️ System Information", Content = "This Scripts Is safe and has been tested\n- All these scripts are not mine"})

-- Initialize with because the CurrentOption default
local selectedOptions = {}

local function runScript(optionName)
    if optionName == "BolongHub [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/RillBoys/bolong.cat/refs/heads/main/main/Loader", true))()
        end)
    
    elseif optionName == "WisnuHub [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/TjcqcZ2KDistrictV2/refs/heads/main/AcCVkYFU"))()
        end)

    elseif optionName == "W424HUB [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/N8GYFQc7DestrictV3/refs/heads/main/nTon3cet"))()
        end)

    elseif optionName == "4LynxX [FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/2CHCDGJVDistictV3/refs/heads/main/GxHqbZZLua"))()
        end)
    end
end

local Dropdown = MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = {"BolongHub [FREE]", "WisnuHub [FREE]", "W424HUB [FREE]", "4LynxX [FREE]"},
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
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/F4DiY9yZ9-Checking.luau"))()
   end
})

local Button = Theme:CreateButton({
    Name = "Maintenance",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/ey6vY5D76-Key.luau"))()
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
