local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ZETHUB | Steal An Egg | 8A9ESKII",
   Icon = "egg", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Initializing......",
   LoadingSubtitle = "By Exterminate0",
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
local Change = Window:CreateTab("Changelog", "newspaper")
local MainTab = Window:CreateTab("Main Scipts", "sword")
local Theme = Window:CreateTab("Theme & Settings", "palette")


-- Main Scripts
local MainSection = Change:CreateSection("Information & Version")

local Paragraph = Change:CreateParagraph({Title = "🔁 V-A9ESKII", Content = "- [+] Added Scipts GUI And Auto farm\n- [+] Add Changelog\n- [+] Add Theme and Destroy"})
local Paragraph = Change:CreateParagraph({Title = "🔁 V-8A9ESKII", Content = "- [+] Added Scripts Sena [HUB]\n- [+] Added Pet Spawner [Client] [Coming]\n- [+] Added More Details"})


local MainSection = Change:CreateSection("Next Update & Version")
local Paragraph = Change:CreateParagraph({Title = "❌ V-vVaLjCVc", Content = "Unknown, Coming Soon!"})

local MainSection = MainTab:CreateSection("Main Menu")

local Paragraph = MainTab:CreateParagraph({Title = "🛡️ System Information", Content = "This Scripts Is safe and has been tested\n- All these scripts are not mine"})

-- Initialize with because the CurrentOption default
local selectedOptions = {}

local function runScript(optionName)
    if optionName == "NIGHT [HUB & KEYLESS]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealEggOnly.luau"))()
        end)
    
    elseif optionName == "LENNON  [HUB & KEYLESS]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://flowauth.net/v1/ui/584e23b68f5f361081321954763ab5e5.lua"))()
        end)

    elseif optionName == "MIRANDA [HUB & KEYLESS]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://flowauth.net/v1/ui/5f7a6b969f81332d7994e3b5eb71c686.lua"))()
        end)

    elseif optionName == "Chilli [HUB & FREE]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
        end)

    elseif optionName == "Sena [HUB & V5]" then
        Rayfield:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 6,
            Image = "check",
        })
        task.wait(0.5)
        pcall(function()
            loadstring(game:HttpGet("https://senahub.xyz/raw/loader"))()
        end)
    end
end

local Dropdown = MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = {"NIGHT [HUB & KEYLESS]", "LENNON  [HUB & KEYLESS]", "MIRANDA [HUB & KEYLESS]", "Chilli [HUB & FREE]", "Sena [HUB & V5]"},
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


local MainSection = MainTab:CreateSection("Pet Spawner & More")
local Paragraph = MainTab:CreateParagraph({Title = "📚 Guide Information", Content = "This feature is coming soon!"})


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
