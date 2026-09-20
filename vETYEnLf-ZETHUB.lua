-- loading Alexchad Library
local AlexchadLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Alexchad-Ui-Library/refs/heads/main/Remake"))()

-- Service
local UserInputService = game:GetService("UserInputService");

-- Create main window
local Window = AlexchadLibrary:CreateWindow({
    Name = "ZEUTRON HUB", --Title
    Subtitle = "Universal Scripts", -- Subtitle smaller than title
    Version = "This Is Version V2.6.0", -- version of your script(i didnt make it number only tho)
    LoadingTitle = "Loading......", -- self explanatory
    LoadingSubtitle = "By Zeutronxsite", -- also self explanatory
    Theme = "Midnight", -- Default, Midnight, Ocean, Emerald, Light, Dark
    AnimationSpeed = 0.2, -- general animation speed for everything                
    RippleEnabled = true, -- wether ripple/pulse should be on or not  default = true           
    RippleSpeed = 0.35,-- how fast the ripple/pulse is                  
    CornerRadius = 12,            
    ElementCornerRadius = 10, -- how round things should be                 
    BlurEnabled = false, -- true = blur when window is maximized false = completely off --default = true
    ConfigurationSaving = {
        Enabled = false, --true = saving everything toggles, dropdwons, slider value, etc.
        FolderName = "ZETYXLibrary", --foldername of config
        FileName = "Config" -- filename of config
    },
    ToggleKey = Enum.KeyCode.K --right shift ui toggle
})


local Info = Window:CreateTab({ --Create Tab with name and icon(lucide icons soon)
    Name = "News",
    Icon = "📢"
})

local Section1 = Info:CreateSection("📰 RELEASE UPDATE")

Section1:CreateParagraph({
    Title = "✅ Version [2.6.0-Latest Update]",
    Content = "- [+] Add Multi Section\n- [+] Add Guide/Tips\n- [+] More Details\n- [+] More Information"
})

local Section1 = Info:CreateSection("⏩ Next Update")

Section1:CreateParagraph({
    Title = "📢 Information related to next update",
    Content = "- Next Update Don't know when but the update will be released soon\n- The next update is uncertain so wait until it is actually updated."
})

Section1:CreateParagraph({
    Title = "❌ Version [Small-Update]",
    Content = "- [+] Add 5 Scripts\n- [+] More Details and Information\n- [+] Checking Scripts Failed Or Not"
})

local Section1 = Info:CreateSection("❓ Announcement")
Section1:CreateParagraph({
    Title = "📩 Information [N/A]",
    Content = "The next update will be the last one because all the libraries are full and I will be busy with the world, enjoy this script while you can!\n \n \n@ Created By Community Zeutron"
})

local dev = Window:CreateTab({ --Create Tab with name and icon(lucide icons soon)
    Name = "Creator",
    Icon = "🛠️"
})

local Section2 = dev:CreateSection("🛠️ Developer & More")

Section2:CreateButton({
    Name = "Owner/Developer",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "kamunanya3v\n- Status: Not Working [Banned 6 Month]\n- Game Favorit: The Strongest battle, Strongest Punch Simulator, Murderer vs Sheriff Duels",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

Section2:CreateButton({
    Name = "Co-Owner",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "4Streakzx\n- Status: Working\n- Game Favorit: The Strongest battle, Power Incremental, Murderer vs Sheriff Duels",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

Section2:CreateButton({
    Name = "Admin",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "God_dwigon13z\n- Status: Working\n- Game Favorit: World Zero, Horor Game, Anime Game",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

Section2:CreateButton({
    Name = "Co-Admin",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "baconhecker1YT\n- Status: Working\n- Game Favorit: The Strongest battle, Strongest Punch Simulator, Murderer vs Sheriff Duels",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

local Section2 = dev:CreateSection("🏗️ Builder & More")

Section2:CreateButton({
    Name = "Designer",
    Callback = function()
        Window:Dialog({
            Title = "Username",
            Content = "Alexchad",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

Section2:CreateButton({
    Name = "Programmer",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "Theexterminate0\n- Status: Working\n- Game Favorit: The Strongest battle, Murderer vs Sheriff Duels",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

Section2:CreateButton({
    Name = "Builder",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "Thetecnologyz\n- Status: Working\n- Game Favorit: The Strongest battle, Murderer vs Sheriff Duels",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

local Section2 = dev:CreateSection("💵 SUPPORTER")

Section2:CreateButton({
    Name = "Supporter I",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "K2_Ztazz\n- Status: Working\n- Game Favorit: The Strongest battle",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

Section2:CreateButton({
    Name = "Supporter II",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "zyptruex\n- Status: Working\n- Game Favorit: The Strongest battle",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})

Section2:CreateButton({
    Name = "Supporter III",
    Callback = function()
        Window:Dialog({
            Title = "Username - Roblox",
            Content = "SupremePass7\n- Status: Working\n- Game Favorit: Shoot And Eat Noobs",
            Buttons = {
                {
                    Title = "✅ Confirm",
                    Primary = true,
                    Callback = function()
                    end
                }
            }
        })
    end
})


local Tab1 = Window:CreateTab({ --Create Tab with name and icon(lucide icons soon)
    Name = "Home",
    Icon = "🏠"
})

local Section3 = Tab1:CreateSection("👟 WalkSpeed") --create section for the tab

-- Global For Status
local isWalkspeedEnabled = false
local isJumpPowerEnabled = false

Section3:CreateToggle({
    Name = "Enable/Re-Enable WalkSpeed",
    Flag = "Toggle1",
    CurrentValue = false,
    Callback = function(value)
        isWalkspeedEnabled = value -- Update status global
        
        if value then
            -- Jika True: Aktifkan slider (biarkan nilai slider yang berlaku)
            -- Kita panggil ulang logika slider dengan nilai saat ini agar langsung terupdate
            local currentSliderValue = 18 -- Ganti ini jika library Anda punya cara mengambil nilai slider saat ini
            -- Catatan: Jika library menyimpan state, Anda mungkin perlu mengambilnya via Flag "Slider1"
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = currentSliderValue
        else
            -- Jika False: Matikan slider, reset ke 16
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 18
        end
    end
})

Section3:CreateSlider({
    Name = "Walkspeed",
    Flag = "Slider1",
    Range = {0, 9999},
    Increment = 1,
    CurrentValue = 18,
    Suffix = " KM/H",
    Callback = function(value)
        -- Cek apakah toggle sedang aktif sebelum mengubah walkspeed
        if isWalkspeedEnabled then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        else
            -- Opsional: Jika user menggeser slider saat toggle mati, 
            -- kita bisa memaksa toggle jadi true atau sekadar ignor perubahannya.
            -- Di sini kita pilih untuk mengignor perubahan sampai toggle dinyalakan.
        end
    end
})

local Section3 = Tab1:CreateSection("⬆️ JumpPower")

Section3:CreateToggle({
    Name = "Enable/Re-Enable JumpPower",
    Flag = "ToggleJumpPower",
    CurrentValue = false,
    Callback = function(value)
        isJumpPowerEnabled = value
        
        if value then
            -- Jika ON: Terapkan nilai slider saat ini (Default 50)
            local currentVal = 50
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = currentVal
            end
        else
            -- Jika OFF: Reset ke Normal (50)
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
            end
        end
    end
})

Section3:CreateSlider({
    Name = "JumpPower",
    Flag = "Slider2",
    Range = {0, 9999},
    Increment = 1,
    CurrentValue = 50,
    Suffix = " POWER",
    Callback = function(value)
        -- Hanya ubah JumpPower jika Toggle sedang AKTIF
        if isJumpPowerEnabled then
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
            end
        else
            -- Jika toggle mati, slider digeser pun tidak akan mengubah karakter
            -- print("JumpPower Toggle is OFF. Cannot change power.")
        end
    end
})

local Section3 = Tab1:CreateSection("👑 POWERFULL SCRIPTS")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Infinite Yield"}

local function runScript(optionName)
    if optionName == "Infinite Yield" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
    
    elseif optionName == "Test Sunc/Unc" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zryr/executor-test-panel/refs/heads/main/panel.lua"))()

    elseif optionName == "Invisible" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()

    elseif optionName == "Fly Gui" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/IOERHUB/Fly/refs/heads/main/Gui"))()

    end
end


Section3:CreateDropdown({
    Name = "Universal Scripts",
    Flag = "Dropdown2",
    Options = {"Infinite Yield", "Test Sunc/Unc", "Invisible", "Fly Gui"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})


Section3:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

--Im tired explaining the rest is from Chatgpt
-- Tab: Sliders
local Tab2 = Window:CreateTab({
    Name = "Scripts",
    Icon = "💉"
})

local Section4 = Tab2:CreateSection("📚 RAYFIELD LIBRARY")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Version [1]"}

local function runScript(optionName)
    if optionName == "Version [1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Main-Scripts/refs/heads/main/Main%20Scripts%20%5BV1%5D"))()

    elseif optionName == "Version [2]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Main-ScriptsV2/refs/heads/main/Version%202"))()

    elseif optionName == "Version [3]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Main-ScriptsV3/refs/heads/main/Version%203"))()

    elseif optionName == "Version [4]" then
        Window:Notify({
            Title = "Information",
            Content = "Version 4 Coming soon, Please wait until update",
            Duration = 3,
            Type = "Info"
        })
    end
end


Section4:CreateDropdown({
    Name = "ZEUTRON MAIN",
    Flag = "Dropdown2",
    Options = {"Version [1]", "Version [2]", "Version [3]", "Version [4]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})


Section4:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section4 = Tab2:CreateSection("🎮 MAIN SCRIPT")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Super Ring V6"}

local function runScript(option)
    if option == "Super Ring V6" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/hhyT3gQr"))()
        elseif option == "Instant Click" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/5qXz6a5L"))()
        elseif option == "God Mode" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/ignore-touchinterests/main/main",true))()
        elseif option == "Noclip Tool" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/IOERHUB/Noclip/refs/heads/main/Testing"))()

    end
end

Section4:CreateDropdown({
    Name = "NORMAL SCRIPT",
    Flag = "Dropdown2",
    Options = {"Super Ring V6", "Instant Click", "God Mode", "Noclip Tool"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section4:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"Tool Giver"}

local function runScript(option)
    if option == "Tool Giver" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua"))()
        elseif option == "Vehiclefly" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20Fe%20Vehicle%20Fly%20GUI%20script'))()
        elseif option == "Multi Tool" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/MultiToolsV1/main/script"))()
        elseif option == "Ghost Hub" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))()

    end
end

Section4:CreateDropdown({
    Name = "BASIC SCRIPT",
    Flag = "Dropdown2",
    Options = {"Tool Giver", "Vehiclefly", "Multi Tool", "Ghost Hub"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section4:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section4 = Tab2:CreateSection("👁️ Inspect/Spy")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Foki [HUB]"}

local function runScript(option)
    if option == "Foki [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)   
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Foki-hub-only-remote-spy-135917"))()

        elseif option == "RSPY Remake" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/RemoteSpy-V2.lua.txt"))()
            
        elseif option == "Cobalt [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()

        elseif option == "Ketamine [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Ketamine-46055"))()

    end
end

Section4:CreateDropdown({
    Name = "NORMAL SCRIPT",
    Flag = "Dropdown2",
    Options = {"Foki [HUB]", "RSPY Remake", "Cobalt [HUB]", "Ketamine [HUB]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section4:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section4 = Tab2:CreateSection("🛡️ SHIELD/ANTI")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Anti-TP"}

local function runScript(option)
        if option == "Anti-TP" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/VttTZyrT"))()
        elseif option == "Anti-Fling" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/MhJDcWjR"))()

    end
end

Section4:CreateDropdown({
    Name = "PROTECTION",
    Flag = "Dropdown2",
    Options = {"Anti-TP", "Anti-Fling"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section4:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section4 = Tab2:CreateSection("🎛️ Server Hop")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Server Small Finder"}

local function runScript(option)
        if option == "Server Small Finder" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/WZYjUXvg"))()

        elseif option == "Server Hop Finder" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Serverhop/refs/heads/main/Server%20List"))()

    end
end

Section4:CreateDropdown({
    Name = "Server List",
    Flag = "Dropdown2",
    Options = {"Server Small Finder", "Server Hop Finder"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section4:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section4 = Tab2:CreateSection("✂️ Free Gamepass")

-- Initialize with because the CurrentOption default
local selectedOptions = {"FGP1 [Working]"}

local function runScript(option)
        if option == "FGP1 [Working]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/FreeG1/refs/heads/main/Some%20Game%20Working"))()

    end
end

Section4:CreateDropdown({
    Name = "Buy Product",
    Flag = "Dropdown2",
    Options = {"FGP1 [Working]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section4:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Tab5 = Window:CreateTab({
    Name = "Library [A]",
    Icon = "📕"
})

local Section5 = Tab5:CreateSection("📢 Announcement")
Section5:CreateParagraph({
    Title = "⚠️ Information",
    Content = "- Use Executor 99/100% For Experience\n- Some Scripts can make you get kick or Banned!\n- Fun Fact: This Is Version V1 Main Scripts"
})

local Section5 = Tab5:CreateSection("🔒 Jailbreak")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Rendex [HUB]"}

local function runScript(option)
        if option == "Rendex [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotWhyLclc/Rendex/refs/heads/main/Loader.luau"))() 

        elseif option == "Solix [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Main/Farm]",
    Flag = "Dropdown2",
    Options = {"Rendex [HUB]", "Solix [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("🔫 MVSD")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Zephyr-V2 [HUB]"}

local function runScript(option)
        if option == "Zephyr-V2 [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/script.lua", true))()

        elseif option == "ProjectSnare [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://scripts.projectsnare.online/SnareMvsd", true))()

        elseif option == "Ekuve [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ekuve/ekuvehub/main/main.lua"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Main/Gui]",
    Flag = "Dropdown2",
    Options = {"Zephyr-V2 [HUB]", "ProjectSnare [HUB]", "Ekuve [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("💪 The Strongest")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Dovi [HUB]"}

local function runScript(option)
        if option == "Dovi [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/needanewphone32-eng/tsbfiles/refs/heads/main/Main1.lua"))()

        elseif option == "Vexon [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub"))()

        elseif option == "Nicuse [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://loader.nicuse.xyz"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Main]",
    Flag = "Dropdown2",
    Options = {"Dovi [HUB]", "Vexon [HUB]", "Nicuse [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"Trash Can"}

local function runScript(option)
        if option == "Trash Can" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man",true))()

        elseif option == "Divene Form Emote" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkRandomUsernameok/PublicAssets/refs/heads/main/Releases/MUI.lua"))()

        elseif option == "CombosRemake" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/CombosRemake/refs/heads/main/Script"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Farm/More]",
    Flag = "Dropdown2",
    Options = {"Trash Can", "Divene Form Emote", "CombosRemake"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("🐟 Fish It")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Bloxy [HUB]"}

local function runScript(option)
        if option == "Bloxy [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/fcc63f5f04efa9a6a85d6f16a179b870.lua"))()

        elseif option == "Legend [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/iyYc5zds"))()

        elseif option == "Rock [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://rockhub.net/beta/main.lua"))()

        elseif option == "Limit [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/FakeModz/LimitHub/refs/heads/main/LimitHub_Luarmor_E.lua')))()

        elseif option == "Sora [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/elainaceles/SoraHub/refs/heads/main/fishhit.lua"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Farm V1]",
    Flag = "Dropdown2",
    Options = {"Bloxy [HUB]", "Legend [HUB]", "Rock [HUB]", "Limit [HUB]", "Sora [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"Sanz [HUB]"}

local function runScript(option)
        if option == "Sanz [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/DyyITT/SansMobaHub/refs/heads/main/Fishit-Free'))()

        elseif option == "Vikai [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/vinxonez/ViKai-HUB/refs/heads/main/loader"))()

        elseif option == "Lexs [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/albibot69-lgtm/Lexs/refs/heads/main/Loader/Main.lua"))()

        elseif option == "Blessed [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/iyYc5zds"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Farm V2]",
    Flag = "Dropdown2",
    Options = {"Sanz [HUB]", "Vikai [HUB]", "Lexs [HUB]", "Blessed [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("🏃 Evade")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Best Evade [Free/More]"}

local function runScript(option)
        if option == "Best Evade [Free/More]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://rawscripts.net/raw/Evade-Evade-The-Best-Free-GUI-Script-lots-of-Features-20718"))()

        elseif option == "LabyCatUser [Name]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/LabyCatUser/rawr/refs/heads/main/evade.lua'))()

        elseif option == "kasra50 [Name]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/kasra50/Idk/refs/heads/main/I%20mean%20nobody%20can%20stop%20me.txt'))()

        elseif option == "Iliankytb [Name]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
             loadstring(game:HttpGet("https://raw.githubusercontent.com/Iliankytb/Iliankytb/main/NewbestEvadeCheat"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Main/Farm]",
    Flag = "Dropdown2",
    Options = {"Best Evade [Free/More]", "LabyCatUser [Name]", "kasra50 [Name]", "Iliankytb [Name]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("🌲 99 Night")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Overpower [Bring All]"}

local function runScript(option)
        if option == "Overpower [Bring All]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/CgiJB7mR"))()

        elseif option == "Soluna [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://soluna-script.vercel.app/99-Nights-in-the-Forest.lua",true))()

        elseif option == "Rift [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://rifton.top/loader.lua"))()

        elseif option == "Indra [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/wJKRvL4W"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Bring All/More]",
    Flag = "Dropdown2",
    Options = {"Overpower [Bring All]", "Soluna [HUB]", "Rift [HUB]", "Indra [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("🖐️ Steal A Brainrot")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Farming [Steal]"}

local function runScript(option)
        if option == "Farming [Steal]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastefy.app/HwHqIU1n/raw"))()

        elseif option == "Vulkan [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"))()

        elseif option == "Chili [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()

        elseif option == "Blaze [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Makuscripts/Steal-A-Brainrot/refs/heads/main/BlazeHub"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Auto Steal/Farm]",
    Flag = "Dropdown2",
    Options = {"Farming [Steal]", "Vulkan [HUB]", "Chili [HUB]", "Blaze [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("⚽ Blade Ball")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Kaitor [HUB]"}

local function runScript(option)
        if option == "Kaitor [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/redopy7/Blade-Ball/refs/heads/main/Kalitor"))()

        elseif option == "Argon [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AgentX771/ArgonHubX/main/Loader.lua"))()

        elseif option == "Ronix [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/fda9babd071d6b536a745774b6bc681c.lua"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Auto Parry]",
    Flag = "Dropdown2",
    Options = {"Kaitor [HUB]", "Argon [HUB]", "Ronix [HUB]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("💵 Pls Donate")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Mozil [HUB]"}

local function runScript(option)
        if option == "Mozil [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MoziIOnTop/MoziIHub/refs/heads/main/PlsDonate"))()

        elseif option == "Vax3478 [Name]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Vax3478/Vax/refs/heads/main/plsdonatescriptkeyless-dash"))()

        elseif option == "Overpower [???]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastefy.app/djoI9rG6/raw"))()

        elseif option == "Ifneopldnonea [Name]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Ifneopldnonea/Unilop/refs/heads/main/Script'))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Steal Robux]",
    Flag = "Dropdown2",
    Options = {"Mozil [HUB]", "Vax3478 [Name]", "Overpower [???]", "Ifneopldnonea [Name]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("👽 Area 51")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Overpower [Keyless]"}

local function runScript(option)
        if option == "Overpower [Keyless]" then
        Window:Dialog({
            Title = "Information",
            Content = "Click Execute For Script \nKey: https://pastebin.com/raw/xZecigFi",
            Buttons = {
                 {
                    Title = "❌ Close",
                    Callback = function()
                    end
                },
                {
                    Title = "⚔️ Execute",
                    Primary = true,
                    Callback = function()
            Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
                    wait(2)
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/KGuestHUB/Mods/refs/heads/main/Universal"))()
                    end
                }
            }
        })
    end  
end

Section5:CreateDropdown({
    Name = "Main/Script",
    Flag = "Dropdown2",
    Options = {"Overpower [Keyless]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("😄 Infection Smile")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Ice [HUB]"}

local function runScript(option)
        if option == "Ice [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet(("https://raw.githubusercontent.com/Justaverageguym/Hub/main/Scripts/Infectious%20smile.lua")))()

        elseif option == "Gui [Interface]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/TqgbdDjF"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Auto Steal Key/More]",
    Flag = "Dropdown2",
    Options = {"Ice [HUB]", "Gui [Interface]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("😡 Peta-Peta")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Gui [Interface]"}

local function runScript(option)
        if option == "Gui [Interface]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/CeoOfDims/Peta/refs/heads/main/Petapeta.lua'))()

        elseif option == "Visual [ESP]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/ZxsfJ54F"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Work in Chapter 1]",
    Flag = "Dropdown2",
    Options = {"Gui [Interface]", "Visual [ESP]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("🎹 Sambung Kata")

-- Initialize with because the CurrentOption default
local selectedOptions = {"KBBI V4 [PACTHED]"}

local function runScript(option)
        if option == "KBBI V4 [PACTHED]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/A4BiwU9C"))()

        elseif option == "KBBI V2 [Not Work]" then
        Window:Notify({
            Title = "Information",
            Content = "This Scripts Is Not Working. Please Report any Bugs To Exeterminate0 Or Pastebin.com/u/zyptrue",
            Duration = 3,
            Type = "Information"
        })

        elseif option == "SBX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/pearanoids/Sambung-Kata-Roblox/refs/heads/main/SBX_Script.lua"))()

        elseif option == "Qiell [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/eE3rvwkG"))()

        elseif option == "Free Script [78k+]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ArchIsDead/scripts/refs/heads/main/sambung-kata.lua"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Auto Correct/More]",
    Flag = "Dropdown2",
    Options = {"KBBI V4 [WORKING]", "KBBI V2 [Not Work]", "SBX [HUB]", "Qiell [HUB]", "Free Script [78k+]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("🧟 100 Waves Later")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Inf Money [WORK]"}

local function runScript(option)
        if option == "Inf Money [WORK]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/ScPDygWB"))()

        elseif option == "Inf Revive [WORK]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/ECxEC9hV"))()

        elseif option == "Auto Explode [WORK]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/gLfVwwe1"))()
    end
end

Section5:CreateDropdown({
    Name = "Script [Inf Money/More]",
    Flag = "Dropdown2",
    Options = {"Inf Money [WORK]", "Inf Revive [WORK]", "Auto Explode [WORK]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"Axon [HUB]"}

local function runScript(option)
        if option == "Axon [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua"))()

        elseif option == "Core-X [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Core-X-m3lm/CoreX-Hub/refs/heads/main/Main.lua"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Gui/Hub]",
    Flag = "Dropdown2",
    Options = {"Axon [HUB]", "Core-X [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section5 = Tab5:CreateSection("😎 Swing Obby for Brainrots")

-- Initialize with because the CurrentOption default
local selectedOptions = {"Toraisme [HUB]"}

local function runScript(option)
        if option == "Toraisme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SwingObbyforBrainrots"))()

        elseif option == "GG [HUB]" then
            Window:Dialog({
            Title = "Key System",
            Content = "gghub_S5h60TutOl8",
            Buttons = {
                {
                    Title = "Close",
                    Callback = function()
                    end
                },
                {
                    Title = "Execute",
                    Primary = true,
                    Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Farx11122/GGHUB_FREE/refs/heads/main/gghubLoader_games"))()
                    end
                }
            }
        })

        elseif option == "TITAN [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/VJVkivY2"))()

    end
end

Section5:CreateDropdown({
    Name = "Script [Farm/More]",
    Flag = "Dropdown2",
    Options = {"Toraisme [HUB]", "GG [HUB]", "TITAN [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section5:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Tab6 = Window:CreateTab({
    Name = "Library [B]",
    Icon = "📙"
})

local Section6 = Tab6:CreateSection("📢 Announcement")
Section6:CreateParagraph({
    Title = "⚠️ Information",
    Content = "- Use Executor 99/100% For Experience\n- Some Scripts can make you get kick or Banned!\n- Fun Fact: This Is Version V2 Main Scripts"
})

local Section6 = Tab6:CreateSection("🍇 Blox Fruits")
-- Local variables for Blox Fruits
local selectedBloxOptions = {}
local function runBloxScript(option)
    if option == "Blue x [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()

    elseif option == "Alchemy [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()

    elseif option == "Quantum [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()

    elseif option == "AnDepZai [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/h6hbii/AnDepZaiHub/refs/heads/main/AndepzaiHub.lua"))()

    elseif option == "Tuan [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhTuanDzai-Hub/TuanAnhIOS/refs/heads/main/TuanAnhIOS-Main.Lua"))()

    end
end

Section6:CreateDropdown({
    Name = "Script [Auto Farm V2]",
    Flag = "BloxDropdown",
    Options = {"Blue x [HUB]", "Alchemy [HUB]", "Quantum [HUB]", "AnDepZai [HUB]", "Tuan [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedBloxOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedBloxOptions) do
            runBloxScript(option)
        end
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"HOHO [HUB]"}

local function runScript(option)
        if option == "HOHO [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()

        elseif option == "Cokka [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet"https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua")()

    end
end

Section6:CreateDropdown({
    Name = "Script [Auto Farm V2]",
    Flag = "Dropdown2",
    Options = {"HOHO [HUB]", "Cokka [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section6 = Tab6:CreateSection("🏡 Brookhaven")
-- Local variables for Brookhaven
local selectedBrookOptions = {}
local function runBrookScript(option)
    if option == "SP [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/as6cd0/SP_Hub/refs/heads/main/Brookhaven"))()

    elseif option == "Sander XY [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kigredns/testUIDK/refs/heads/main/panel.lua"))()

    elseif option == "No Name [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/fqYcv7vR/raw"))()

    elseif option == "Tubers [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/5RXjUt9d/raw"))()

    elseif option == "Rendz [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/9OoVFBCU/raw"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Troll Player]",
    Flag = "BrookDropdown",
    Options = {"SP [HUB]", "Sander XY [HUB]", "No Name [HUB]", "Tubers [HUB]", "Rendz [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedBrookOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedBrookOptions) do
            runBrookScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("🧑‍🦯 Blind Shot")
-- Local variables for Blind Shot
local selectedBlindOptions = {}
local function runBlindScript(option)
    if option == "BAF [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet('https://pastefy.app/D61KBKLf/raw'))()

    elseif option == "Toraisme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BlindShot"))()

    elseif option == "Blind V1" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/vjB2N8PE"))()

    elseif option == "Blind V2" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/ucfjm7sc/raw"))()

    elseif option == "Blind V3" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/ULaWpxKm/raw"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Esp/Auto]",
    Flag = "BlindDropdown",
    Options = {"BAF [HUB]", "Toraisme [HUB]", "Blind V1", "Blind V2", "Blind V3"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedBlindOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedBlindOptions) do
            runBlindScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("⚒️ The Forge")
-- Local variables for The Forge
local selectedForgeOptions = {}
local function runForgeScript(option)
    if option == "Zenith [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://zenithhub.cloud/panel/script"))()

    elseif option == "Catraz [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nurvian/Catraz-HUB/refs/heads/main/Catraz/main.lua"))()

    elseif option == "Lunor [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://lunor.dev/loader"))()

    elseif option == "Airflows [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://airflowsscript.com/loader"))()

    elseif option == "Chiyo [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kaisenlmao/loader/refs/heads/main/chiyo.lua"))()

    end
end

Section6:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "ForgeDropdown",
    Options = {"Zenith [HUB]", "Catraz [HUB]", "Lunor [HUB]", "Airflows [HUB]", "Chiyo [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedForgeOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedForgeOptions) do
            runForgeScript(option)
        end
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"ForgeX [HUB]"}

local function runScript(option)
        if option == "ForgeX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/AnonymoDGH/scripts/refs/heads/main/forgex.lua'))()

        elseif option == "Hydra [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/17ed9911cd58c19ebce56b3a36d60320.lua"))()

        elseif option == "Ryzen [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3e05c29156e4b16232286e86f97b97b4.lua"))()

        elseif option == "Ather [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2529a5f9dfddd5523ca4e22f21cceffa.lua"))()

        elseif option == "Astra [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://getastra.lol/loader.lua"))()

    end
end

Section6:CreateDropdown({
    Name = "Script [Auto Farm V2]",
    Flag = "Dropdown2",
    Options = {"ForgeX [HUB]", "Hydra [HUB]", "Ryzen [HUB]", "Ather [HUB]", "Astra [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section6 = Tab6:CreateSection("🔫 Flick")
-- Local variables for Flick
local selectedFlickOptions = {}
local function runFlickScript(option)
    if option == "RobloxScriptsFree1 [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/RZK9XdtH"))()

    elseif option == "UNX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://apigetunx.vercel.app/UNX.lua",true))()

    elseif option == "Claude [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CludeHub/BANKROLL-CS2-Menu/refs/heads/main/Bankroll-CludeHub.lua"))()

    elseif option == "Project 10 [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://rscripts.net/raw/dinas-project-10-aimbot-esp_1763806640379_klEHQpC3bs.txt",true))()

    elseif option == "Syrex [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Joshingtonn123/JoshScript/refs/heads/main/SyrexhubSniperOrDie"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Esp/Silent Aim]",
    Flag = "FlickDropdown",
    Options = {"RobloxScriptsFree1 [HUB]", "UNX [HUB]", "Claude [HUB]", "Project 10 [HUB]", "Syrex [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedFlickOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedFlickOptions) do
            runFlickScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("👆 Race Clicker")
-- Local variables for Race Clicker
local selectedRaceOptions = {}
local function runRaceScript(option)
    if option == "ToraisMe [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraScript/Script/main/RaceClicker"))()

    elseif option == "Clicker V1" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/darraghd493/roblox-scripts/main/loader/loader.lua",true))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Auto Click/Farm]",
    Flag = "RaceDropdown",
    Options = {"ToraisMe [HUB]", "Clicker V1"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedRaceOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedRaceOptions) do
            runRaceScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("👵 Granny Multiplayer")
-- Local variables for Granny Multiplayer
local selectedGrannyOptions = {}
local function runGrannyScript(option)
    if option == "Best Scripts" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/yYQMZUb6"))()

    elseif option == "Veno [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/totallynothimplayz/Jd/refs/heads/main/Veno%20Hub", true))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Get Badge/More]",
    Flag = "GrannyDropdown",
    Options = {"Best Scripts", "Veno [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedGrannyOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedGrannyOptions) do
            runGrannyScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("😶 GEF")
-- Local variables for GEF
local selectedGEFOptions = {}
local function runGEFScript(option)
    if option == "MadbukScripts" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MadbukScripts/Scripts/main/Obfuscated%20Gef.lua"))()

    elseif option == "GEF V1" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://bit.ly/42NBXKe"))()

    elseif option == "GEF V2" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mongusohio/GefMadeBysederYTTv/main/GEFNOSKID", true))()

    elseif option == "Juanko Scripts" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Juanko-Scripts/Roblox-scripts/refs/heads/main/GUFFHP%20%7C%20GEFF%20%7C%20BETA"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [TP items/Esp]",
    Flag = "GEFDropdown",
    Options = {"MadbukScripts", "GEF V1", "GEF V2", "Juanko Scripts"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedGEFOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedGEFOptions) do
            runGEFScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("📦 One Block")
-- Local variables for One Block
local selectedOneBlockOptions = {}
local function runOneBlockScript(option)
    if option == "One Block V1" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VylikGylik/Script/refs/heads/main/ONE%20BLOCK"))()

    elseif option == "ToraIsme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ONEBLOCK"))()

    elseif option == "One Block V2" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/welomenchaina/MainProjects/refs/heads/main/Obfuscated/OneBlockScript.lua", true))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Items Giver/More]",
    Flag = "OneBlockDropdown",
    Options = {"One Block V1", "ToraIsme [HUB]", "One Block V2"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedOneBlockOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedOneBlockOptions) do
            runOneBlockScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("⛺ Survive On a Raft")
-- Local variables for Survive On a Raft
local selectedRaftOptions = {}
local function runRaftScript(option)
    if option == "Sayuri [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/0Nxqrum4"))()

    elseif option == "ToraIsme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SurviveonaRaft"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Collect Box/Esp]",
    Flag = "RaftDropdown",
    Options = {"Sayuri [HUB]", "ToraIsme [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedRaftOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedRaftOptions) do
            runRaftScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("🎲 Aura Craft")
-- Local variables for Aura Craft
local selectedAuraOptions = {}
local function runAuraScript(option)
    if option == "Kaito [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaitofyp/Aura-Craft-V.1/main/Op%20script"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Get All Aura/Craft]",
    Flag = "AuraDropdown",
    Options = {"Kaito [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedAuraOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedAuraOptions) do
            runAuraScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("🦈 Mancing Yuk")
-- Local variables for Mancing Yuk
local selectedMancingOptions = {}
local function runMancingScript(option)
    if option == "Mizukage [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/4dfa8a7c12a07e4e18a2496bf09a9bc8e2a95c1eac5ac03d3e8d5740ce642ebc/download"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Get All Fish]",
    Flag = "MancingDropdown",
    Options = {"Mizukage [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedMancingOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedMancingOptions) do
            runMancingScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("🏹 Paintball 2")
-- Local variables for Paintball 2
local selectedPaintballOptions = {}
local function runPaintballScript(option)
    if option == "Auto Farm" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/LitQ5wwa"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Kill All/Farm]",
    Flag = "PaintballDropdown",
    Options = {"Auto Farm"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedPaintballOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedPaintballOptions) do
            runPaintballScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("🧗 Climb And Jump Tower")
-- Local variables for Climb And Jump Tower
local selectedClimbOptions = {}
local function runClimbScript(option)
    if option == "Auto Farm" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet(('https://pastefy.app/WiQK7IRI/raw'),true))()

    elseif option == "ToraIsme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/ClimbandJump", true))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Auto Climb/Farm]",
    Flag = "ClimbDropdown",
    Options = {"Auto Farm", "ToraIsme [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedClimbOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedClimbOptions) do
            runClimbScript(option)
        end
    end
})


local Section6 = Tab6:CreateSection("💧 Dropper Incremental")
-- Local variables for Dropper Incremental
local selectedDropperOptions = {}
local function runDropperScript(option)
    if option == "Auto Farm" then
        Window:Dialog({
            Title = "Key System",
            Content = "holaxd",
            Buttons = {
                {
                    Title = "Close",
                    Callback = function()
                    end
                },
                {
                    Title = "Execute",
                    Primary = true,
                    Callback = function()
                        loadstring(game:HttpGet('https://pastefy.app/uNzaPtRb/raw'))()
                    end
                }
            }
        })

    elseif option == "Bronze Clicker" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/FPSS0xUv"))()
    end
end

Section6:CreateDropdown({
    Name = "Script [Farm Money/More]",
    Flag = "DropperDropdown",
    Options = {"Auto Farm", "Bronze Clicker"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedDropperOptions = options
    end
})

Section6:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedDropperOptions) do
            runDropperScript(option)
        end
    end
})


local Tab8 = Window:CreateTab({
    Name = "Library [C]",
    Icon = "📘"
})

local Section8 = Tab8:CreateSection("📢 Announcement")
Section8:CreateParagraph({
    Title = "⚠️ Information",
    Content = "- Use Executor 99/100% For Experience\n- Some Scripts can make you get kick or Banned!\n- Fun Fact: This Is Version V3 Main Scripts"
})

local Section8 = Tab8:CreateSection("💪 Muscle Legends")
-- Local variables for Muscle Legends
local selectedMuscleOptions = {}
local function runMuscleScript(option)
    if option == "Vector [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://rawscripts.net/raw/Muscle-Legends-Vector-39321"))()

    elseif option == "Crack [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/iblameaabis/script-crack/refs/heads/main/lurnai%20crack%20again", true))()

    elseif option == "SpeedX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/3HtPwcux"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm/Infinite]",
    Flag = "MuscleDropdown",
    Options = {"Vector [HUB]", "Crack [HUB]", "SpeedX [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedMuscleOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedMuscleOptions) do
            runMuscleScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("😃 Answer Or Die")
-- Local variables for Answer Or Die
local selectedAnswerOptions = {}
local function runAnswerScript(option)
    if option == "S-Ware [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://rawscripts.net/raw/Answer-or-Die-New-12400"))()

    elseif option == "Serverlist [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rndmq/Serverlist/refs/heads/main/Loader"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Answer/More]",
    Flag = "AnswerDropdown",
    Options = {"S-Ware [HUB]", "Serverlist [BY]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedAnswerOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedAnswerOptions) do
            runAnswerScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("🔪 Murder Mystery 2")
-- Local variables for Murder Mystery 2 (Merged)
local selectedMM2Options = {}
local function runMM2Script(option)
    if option == "Script [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Meteaga1aga/Murder-Mystery/refs/heads/main/Mm2script"))()

    elseif option == "Script [V2]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ployprimetime/MM2/refs/heads/main/script.lua",true))()

    elseif option == "Fogoty [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FOGOTY/mm2-piano-reborn/refs/heads/main/scr"))()

    elseif option == "Vertex [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/vertex-peak/vertex/refs/heads/main/loadstring'))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Gun/Kill All]",
    Flag = "MM2Dropdown",
    Options = {"Script [V1]", "Script [V2]", "Fogoty [HUB]", "Vertex [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedMM2Options = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedMM2Options) do
            runMM2Script(option)
        end
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"MM2 [HUB]"}

local function runScript(option)
         if option == "MM2 [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/zdkjaime/MM2/refs/heads/main/MM2HUB'))()

        elseif option == "Nebula [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MM2Nebula/MM2/refs/heads/main/script"))()

        elseif option == "Zap [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CamScripter/ZepHubV2/refs/heads/main/MurderMystery2"))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Trade Scam/Gun Spawner]",
    Flag = "Dropdown2",
    Options = {"MM2 [HUB]", "Nebula [HUB]", "Zap [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section8 = Tab8:CreateSection("🏃‍♂️ Legends Of Speed")
-- Local variables for Legends Of Speed
local selectedSpeedOptions = {}
local function runSpeedScript(option)
    if option == "Script [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://orbitsc.net/los"))()

    elseif option == "Script [V2]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xeric-rblx/LegendsOfSpeed/refs/heads/main/LegendsOfSpeed.lua"))()

    elseif option == "AhmadGamer [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ahmadsgamer2/Script--Game/main/Script%20Game"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "SpeedDropdown",
    Options = {"Script [V1]", "Script [V2]", "AhmadGamer [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedSpeedOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedSpeedOptions) do
            runSpeedScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("🦵 Strongman Simulator")
-- Local variables for Strongman Simulator
local selectedStrongmanOptions = {}
local function runStrongmanScript(option)
    if option == "ToraIsme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/StrongmanSim"))()

    elseif option == "Script [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://github.com/KhSaeed90/Roblox/raw/workspace/6766156863"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "StrongmanDropdown",
    Options = {"ToraIsme [HUB]", "Script [V1]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedStrongmanOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedStrongmanOptions) do
            runStrongmanScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("🐎 Uma Racing")
-- Local variables for Uma Racing
local selectedUmaOptions = {}
local function runUmaScript(option)
    if option == "Synergias [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1132517256/Synergias/refs/heads/main/Synergia"))()

    elseif option == "Gum [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumballasitfinestpeak/Gum-hub/refs/heads/main/MainGumHubLoader"))()

    elseif option == "Script [Overpower]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sigmaboijjk123/racing/refs/heads/main/racer.lua"))()

    elseif option == "Velocity [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/cSyBuYak"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Infinite Stamina]",
    Flag = "UmaDropdown",
    Options = {"Synergias [HUB]", "Gum [HUB]", "Script [Overpower]", "Velocity [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedUmaOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedUmaOptions) do
            runUmaScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("⚔️ Be a Ninja")
-- Local variables for Be a Ninja
local selectedNinjaOptions = {}
local function runNinjaScript(option)
    if option == "Inf-Money [Instant]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet(('https://pastebin.com/raw/JUzpzaNb'), true))()

    elseif option == "Inf-Money [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/xq9Xa6UZ"))()

    elseif option == "ToraIsme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/BeaNinja"))()

    elseif option == "NatsuHX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NatsumeMikuX/Beaninja/refs/heads/main/Main.lua"))()

    elseif option == "Inf-Money [V2]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/checkurasshole/Script/refs/heads/main/IQ"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Inf Money/More]",
    Flag = "NinjaDropdown",
    Options = {"Inf-Money [Instant]", "Inf-Money [V1]", "ToraIsme [HUB]", "NatsuHX [HUB]", "Inf-Money [V2]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedNinjaOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedNinjaOptions) do
            runNinjaScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("🧱 Hitbox Expander")
-- Local variables for Hitbox Expander
local selectedHitboxOptions = {}
local function runHitboxScript(option)
    if option == "Hitbox [UI]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/example-prog/Hitbox-Expander/refs/heads/main/RScripter"))()

    elseif option == "Hitbox [Rayfield]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thesigmacorex/RobloxScripts/main/XHit", true))()

    elseif option == "Hitbox [Overpower]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/HitboxExpander.lua"))()

    elseif option == "Hitbox [Method]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/eZ03VZnF"))()

    elseif option == "Hitbox [HeadSize]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/0D1nFeEy"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Hitbox]",
    Flag = "HitboxDropdown",
    Options = {"Hitbox [UI]", "Hitbox [Rayfield]", "Hitbox [Overpower]", "Hitbox [Method]", "Hitbox [HeadSize]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedHitboxOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedHitboxOptions) do
            runHitboxScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("🦑 Raft 101 Survival")
-- Local variables for Raft 101 Survival
local selectedRaft101Options = {}
local function runRaft101Script(option)
    if option == "Spectravax [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/deedlemcdoodledeedlemcdoodle-creator/SpectravaxHub/refs/heads/main/raftonezeroone.lua"))()

    elseif option == "Script [UI]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScriptsRBXdotCom/scripts/refs/heads/main/raft101"))()

    elseif option == "Dupe Chest [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/osakaTP2/OsakaTP2/main/Raft101alphaOSAKATP2"))()

    elseif option == "Dupe Chest [V2]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/osakaTP2/OsakaTP2/main/Raft101alpha.lua"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Collect/Dupe]",
    Flag = "Raft101Dropdown",
    Options = {"Spectravax [HUB]", "Script [UI]", "Dupe Chest [V1]", "Dupe Chest [V2]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedRaft101Options = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedRaft101Options) do
            runRaft101Script(option)
        end
    end
})


local Section8 = Tab8:CreateSection("🌊 Escape tsunami for brainrot")
-- Local variables for Escape tsunami for brainrot (Merged V1-V4)
local selectedTsunamiOptions = {}
local function runTsunamiScript(option)
    if option == "Ronix [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/fda9babd071d6b536a745774b6bc681c.lua"))()

    elseif option == "DuyVn [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/wl88X3Z8/raw"))()

    elseif option == "Mystrix [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/loader"))()

    elseif option == "Airflows [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://airflowscript.com/loader"))()

    elseif option == "ExistAce7 [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/a1xgANtg/raw"))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm V1]",
    Flag = "TsunamiDropdown",
    Options = {"Ronix [HUB]", "DuyVn [HUB]", "Mystrix [HUB]", "Airflows [HUB]", "ExistAce7 [BY]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedTsunamiOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedTsunamiOptions) do
            runTsunamiScript(option)
        end
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"Ziaan [HUB]"}

local function runScript(option)
        if option == "Ziaan [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://ziaanhub.github.io/main"))()

        elseif option == "FayintX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FayintXhub/FayintExploit/refs/heads/main/Loader"))()

        elseif option == "Ekuve [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ekuve/ekuvehub/main/main.lua"))()

        elseif option == "Luminon [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("http://luminon.top/loader.lua"))() 

        elseif option == "Zypheron [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/rr9qu86Q"))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm V2]",
    Flag = "Dropdown2",
    Options = {"Ziaan [HUB]", "FayintX [HUB]", "Ekuve [HUB]", "Luminon [HUB]", "Zypheron [HUB]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"Apoc [HUB]"}

local function runScript(option)
        if option == "Apoc [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ApocHub/ApocHub/refs/heads/main/ApocHubMain"))()

        elseif option == "Enchanted [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/iblameaabis/Enchanted/refs/heads/main/Enchanted%20Hub%20On%20Top"))()

        elseif option == "Nova [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/7d41b5fe8a8512e5c1d31201617344ed.lua"))()

        elseif option == "ColdTeamX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://rawscripts.net/raw/Escape-Tsunami-For-Brainrots!-OP-84859"))()

        elseif option == "Xephex [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/474ff1d7a1718dd5a1bd9533fca6434f6e8856b65d984515df0bc53f9c64c966/download"))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm V3]",
    Flag = "Dropdown2",
    Options = {"Apoc [HUB]", "Enchanted [HUB]", "Nova [HUB]", "ColdTeamX [HUB]", "Xephex [HUB]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"zReal [HUB]"}

local function runScript(option)
        if option == "zReal [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            pcall(loadstring(game:HttpGet('https://raw.githubusercontent.com/zReal-King/Escape-Tsunami-For-Brainrots/refs/heads/main/Main.lua')))

        elseif option == "Auto Farm [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b9a0b8e031dc3210c2b792caf505b93c.lua"))()

        elseif option == "Auto Farm [V2]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://pastebin.com/raw/mizeQM4i'))()

        elseif option == "God Mode" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/Y5uHKXN5"))()

        elseif option == "Delete Tsunami" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/4e932146866fc52b"))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm V4]",
    Flag = "Dropdown2",
    Options = {"zReal [HUB]", "Auto Farm [V1]", "Auto Farm [V2]", "God Mode", "Delete Tsunami"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section8 = Tab8:CreateSection("👊 Strongest Punch Simulator")
-- Local variables for Strongest Punch Simulator
local selectedPunchOptions = {}
local function runPunchScript(option)
    if option == "Auto Farm [Anti-Ban]" then
        Window:Dialog({
            Title = "Key System",
            Content = "BlubBlub111",
            Buttons = {
                {
                    Title = "Close",
                    Callback = function()
                    end
                },
                {
                    Title = "Execute",
                    Primary = true,
                    Callback = function()                   
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Sicalelak/Sicalelak/refs/heads/main/yeahyeah"))()
                    end
                }
            }
        })
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "PunchDropdown",
    Options = {"Auto Farm [Anti-Ban]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedPunchOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedPunchOptions) do
            runPunchScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("🚣 Build A Boat For Treasure")
-- Local variables for Build A Boat For Treasure (Merged V1 & V2)
local selectedBoatOptions = {}
local function runBoatScript(option)
    if option == "Sus [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/wLLDRqNt"))()

    elseif option == "Floppa [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Floppa1x1/Floppa-Hub/refs/heads/main/lua.lua"))()

    elseif option == "RyomemGu [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/WPQiC8sT"))()

    elseif option == "Fifteen [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ovrexxx/buildaboat_fifteenhub/refs/heads/main/obf_fifteen.lua'))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Build/More]",
    Flag = "BoatDropdown",
    Options = {"Sus [HUB]", "Floppa [HUB]", "RyomemGu [BY]", "Fifteen [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedBoatOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedBoatOptions) do
            runBoatScript(option)
        end
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {""}

local function runScript(option)
        if option == "Auto Farm [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Iluvhaks/build-a-boat-for-treasure-script/refs/heads/main/Script"))()

        elseif option == "SpectreX [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Arhangels-team/SpectreX-Hub/main/babft%20auto%20farm.lua'))()

        elseif option == "Auto Farm [V2]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/jTmpyC37"))()

        elseif option == "BABFT [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet('https://raw.githubusercontent.com/TheRealAsu/BABFT/refs/heads/main/Loader.lua'))()

    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Build/More V2]",
    Flag = "Dropdown2",
    Options = {"Auto Farm [V1]", "SpectreX [HUB]", "Auto Farm [V2]", "BABFT [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section8 = Tab8:CreateSection("💰 Tap To Get Rich")
-- Local variables for Tap To Get Rich
local selectedTapOptions = {}
local function runTapScript(option)
    if option == "Auto Farm [V1]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://gist.githubusercontent.com/gerelyncontiga-dot/a670b91c163cec377a17275a41f1c05d/raw/4ca7c5b9c151aef217c0e7ea81a0cb9b21afb919/Tap%2520dhhshs%2520get%2520richess.lua"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "TapDropdown",
    Options = {"Auto Farm [V1]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedTapOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedTapOptions) do
            runTapScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("💉 Vaccum For Brainrot")
-- Local variables for Vaccum For Brainrot
local selectedVaccumOptions = {}
local function runVaccumScript(option)
    if option == "Toraisme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/VacuumForBrainrots"))()

    elseif option == "ByteNB [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Noah-BytesNB/Vacuum-For-brainrot-/refs/heads/main/Noah%20BytesNB"))()

    elseif option == "Captain Manjiro [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet('https://pastefy.app/wuuT3Tup/raw'))()

    elseif option == "Zaporium [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/VaccumforBrainrots'))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "VaccumDropdown",
    Options = {"Toraisme [HUB]", "ByteNB [HUB]", "Captain Manjiro [BY]", "Zaporium [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedVaccumOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedVaccumOptions) do
            runVaccumScript(option)
        end
    end
})


local Section8 = Tab8:CreateSection("✨ Aura Ascension")
-- Local variables for Aura Ascension
local selectedAuraAscOptions = {}
local function runAuraAscScript(option)
    if option == "Rans [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YTRANSBLOX/RANSBLOX-SCRIPT/refs/heads/main/AuraAscension.lua"))()

    elseif option == "AhmedMode [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/27-n1ght/Boron/refs/heads/main/Sailor%20piece"))()

    elseif option == "LH101 [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/ULaWpxKm/raw"))()

    elseif option == "4479 [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/4479cantcode/4479Hub/refs/heads/main/Script.lua"))()
    end
end

Section8:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "AuraAscDropdown",
    Options = {"Rans [HUB]", "AhmedMode [BY]", "LH101 [BY]", "4479 [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedAuraAscOptions = options
    end
})

Section8:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedAuraAscOptions) do
            runAuraAscScript(option)
        end
    end
})

local Tab9 = Window:CreateTab({
    Name = "Library [D]",
    Icon = "📗"
})

local Section9 = Tab9:CreateSection("📢 Announcement")
Section9:CreateParagraph({
    Title = "✨ Change Logs [Small-Update]",
    Content = "- 🔆 Shoot LASERS For Brainrots\n- 🔫 +1 Gun Evolution\n- ☢️ Nuke Your City\n- 🔥 Roller for Brainrots\n- ☢️ Nuke for Brainrot"
})

local Section9 = Tab9:CreateSection("🧟‍♂️ Survive the Apocalypse")
-- Local variables for Survive the Apocalypse (Merged V1 & V2)
local selectedSurviveOptions = {}
local function runSurviveScript(option)
    if option == "Ronix [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/fda9babd071d6b536a745774b6bc681c.lua"))()

    elseif option == "Zexn [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zidandz09/silit/refs/heads/main/58b7df18.txt"))()

    elseif option == "Yoshin [V80]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/LVr32Q3X"))()

    elseif option == "ZXC [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4b11c259bd6c83ee90ee87880e7cc7a7d3ed4f0f3845cd150bea27d6b8bde6cc/download"))()

    elseif option == "OAT [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://rawscripts.net/raw/Survive-the-Apocalypse-Best-Script-OAT-148372"))()

    end
end

Section9:CreateDropdown({
    Name = "Script [Farm/Esp]",
    Flag = "SurviveDropdown",
    Options = {"Ronix [HUB]", "Zexn [HUB]", "Yoshin [V80]", "ZXC [HUB]", "OAT [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedSurviveOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedSurviveOptions) do
            runSurviveScript(option)
        end
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {""}

local function runScript(option)
        if option == "Heiper [HUB]" then
            Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/f111c80158b72ca44fa59e09415ed454f984677895789bb426243f7205ab4cf7/download"))()

        elseif option == "SPYMM [V82]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/HxnryLSD/SPYMM-rblx/refs/heads/main/SPYMM-STA-Latest.lua"))()

    end
end

Section9:CreateDropdown({
    Name = "Script [Farm/Esp V2]",
    Flag = "Dropdown2",
    Options = {"Heiper [HUB]", "SPYMM [V82]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section9 = Tab9:CreateSection("🔆 Shoot LASERS For Brainrots")
-- Local variables for Shoot LASERS For Brainrots
local selectedLasersOptions = {}
local function runLasersScript(option)
    if option == "KhSaeed90 [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://github.com/KhSaeed90/Roblox/raw/refs/heads/workspace/134374139747297"))()

    elseif option == "GS1 [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/csZx1xtt"))()

    elseif option == "Toraisme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/ShootLASERSForBrainrots"))()
    end
end

Section9:CreateDropdown({
    Name = "Script [Auto Exotic]",
    Flag = "LasersDropdown",
    Options = {"KhSaeed90 [BY]", "GS1 [BY]", "Toraisme [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedLasersOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedLasersOptions) do
            runLasersScript(option)
        end
    end
})


local Section9 = Tab9:CreateSection("🔫 +1 Gun Evolution")
-- Local variables for +1 Gun Evolution
local selectedGunEvoOptions = {}
local function runGunEvoScript(option)
    if option == "Toraisme [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/1GunEvolution"))()
    end
end

Section9:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "GunEvoDropdown",
    Options = {"Toraisme [HUB]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedGunEvoOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedGunEvoOptions) do
            runGunEvoScript(option)
        end
    end
})


local Section9 = Tab9:CreateSection("☢️ Nuke Your City")
-- Local variables for Nuke Your City
local selectedNukeCityOptions = {}
local function runNukeCityScript(option)
    if option == "SCHUB [N/A]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastefy.app/gQQk2ZdH/raw"))()

    elseif option == "Inf [Nuke]" then
        Window:Dialog({
            Title = "Key System",
            Content = "password32",
            Buttons = {
                {
                    Title = "❌ Close",
                    Callback = function()
                    end
                },
                {
                    Title = "⚔️ Execute",
                    Primary = true,
                    Callback = function()                   
                    loadstring(game:HttpGet("https://pastebin.com/raw/JeQVYB7D"))()
                    end
                }
            }
        })
    end
end

Section9:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "NukeCityDropdown",
    Options = {"SCHUB [N/A]", "Inf [Nuke]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedNukeCityOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedNukeCityOptions) do
            runNukeCityScript(option)
        end
    end
})


local Section9 = Tab9:CreateSection("🔥 Roller for Brainrots")
-- Local variables for Roller for Brainrots (Merged V1 & V2)
local selectedRollerOptions = {}
local function runRollerScript(option)
    if option == "Jake [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/jakeeypoop-max/Roller-For-brainrots/refs/heads/main/Key.lua"))()

    elseif option == "Useless [N/A]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://rawscripts.net/raw/Roller-for-Brainrots!-Useless-script-209272"))()

    elseif option == "EZ [HUB]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fartez127-design/FARTEZHUB/refs/heads/main/FARTEZHUBXRollerforBrainrots"))()

    elseif option == "KhSaeed90 [BY]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://github.com/KhSaeed90/Roblox/raw/refs/heads/workspace/110334393584385"))()

    elseif option == "A-Farm [N/A]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/9hw44Ffc"))()

    end
end

Section9:CreateDropdown({
    Name = "Script [Auto Farm]",
    Flag = "RollerDropdown",
    Options = {"Jake [HUB]", "Useless [N/A]", "EZ [HUB]", "KhSaeed90 [BY]", "A-Farm [N/A]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedRollerOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedRollerOptions) do
            runRollerScript(option)
        end
    end
})

-- Initialize with because the CurrentOption default
local selectedOptions = {"GS1 [HUB]"}

local function runScript(option)
        if option == "GS1 [HUB]" then
            Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
            loadstring(game:HttpGet("https://pastebin.com/raw/qvwtfcm0"))()
    end
end

Section9:CreateDropdown({
    Name = "Script [Auto Farm V2]",
    Flag = "Dropdown2",
    Options = {"GS1 [HUB]"},
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        -- Update the storage variable with the latest selection
        selectedOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        -- Loop through every item in selectedOptions
        for _, option in pairs(selectedOptions) do
            -- Call the function we created above
            runScript(option)
        end
        
    end
})

local Section9 = Tab9:CreateSection("☢️ Nuke for Brainrot")
-- Local variables for Nuke for Brainrot
local selectedNukeBrainrotOptions = {}
local function runNukeBrainrotScript(option)
    if option == "SCHUB [N/A]" then
        Window:Notify({
            Title = "Executed Scripts",
            Content = "Scripts Successfully Executed!",
            Duration = 3,
            Type = "Success"
        })
        wait(0)
        loadstring(game:HttpGet("https://pastebin.com/raw/e7NDNsdm"))()
    end
end

Section9:CreateDropdown({
    Name = "Script [Auto Ethereal]",
    Flag = "NukeBrainrotDropdown",
    Options = {"SCHUB [N/A]"}, 
    CurrentOption = {"None"},
    MultiSelect = true,
    Callback = function(options)
        selectedNukeBrainrotOptions = options
    end
})

Section9:CreateButton({
    Name = "Execute Selected Scripts",
    Callback = function()
        for _, option in pairs(selectedNukeBrainrotOptions) do
            runNukeBrainrotScript(option)
        end
    end
})

-- Tab: Information
local Tab8 = Window:CreateTab({
    Name = "Guide/Tips",
    Icon = "📖"
})

local Section11 = Tab8:CreateSection("💡 BASIC TIPS - MORE TIPS COMING SOON")

Section11:CreateParagraph({
    Title = "How to Use Multi Section?",
    Content = "1. Select the script you want to use\n2. After that, click the [Execute Selected Scripts] button to run the script."
})

Section11:CreateParagraph({
    Title = "How to Check Script Working Or Not?",
    Content = "1. Click F9 on the keyboard and you will be directed to the console\n2. If there is writing in red, it means the script you are running is not working (not always)"
})

Section11:CreateParagraph({
    Title = "How to Check Good or Not Your Executor?",
    Content = "1. Check the universal script on home then look for the one named [Sunc/Unc] then run the script\n2. Click test unc then check your console by click F9 on your keyboard\n3. In general, if your executor is good, the value will be above 90 - 100%, if it is below that, there are some scripts that don't work."
})

local Section11 = Tab8:CreateSection("💭 TRANSLATE TO INDONESIA")

Section11:CreateParagraph({
    Title = "Bagaimana Cara Menggunakan Multi Section?",
    Content = "1. Pilih script yang ingin Anda gunakan\n2. Setelah itu, klik tombol [Jalankan Script yang Dipilih] untuk menjalankan script"
})

Section11:CreateParagraph({
    Title = "Bagaimana cara memeriksa apakah script berfungsi\natau tidak?",
    Content = "\n1. Tekan F9 pada keyboard dan Anda akan diarahkan ke console\n2. Jika terdapat tulisan berwarna merah, itu berarti script yang Anda jalankan tidak berfungsi (tidak selalu)."
})

Section11:CreateParagraph({
    Title = "Bagaimana Cara Memeriksa Apakah Executor Anda\nBaik atau Tidak?",
    Content = "\n1. Periksa script universal di beranda/home, lalu cari yang bernama [Sunc/Unc], kemudian jalankan script tersebut.\n2. Klik test unc lalu periksa Console Anda dengan menekan F9 pada keyboard Anda.\n3. Secara umum, jika Executor Anda bagus, nilainya akan di atas 90 - 100%, jika di bawah itu, ada beberapa script yang tidak berfungsi."
})

-- Tab: Themes
local Tab9 = Window:CreateTab({
    Name = "Themes",
    Icon = "🎭"
})

local Section10 = Tab9:CreateSection("🎨 Theme And More")

Section10:CreateColorPicker({
    Name = "Color Picker",
    Flag = "ColorPicker1",
    Color = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
    end
})

Section10:CreateDropdown({
    Name = "Select Theme",
    Flag = "Theme",
    Options = Window:GetThemes(),
    CurrentOption = Window:GetTheme(),
    Callback = function(theme)
        Window:SetTheme(theme)
    end
})

Section10:CreateParagraph({
    Title = "⌨️ Keybinds",
    Content = "Press [K] on the keyboard to hide the script"
})

-- Welcome notification
Window:Notify({
    Title = "✉️ Zeutron Message",
    Content = "😊 Thank You For Using This Scripts 🙂",
    Duration = 7,
    Type = "Success"
})
wait(1)
Window:Notify({
    Title = "🔗 Link Scripts",
    Content = "- Check pastebin.com/u/Zyptrue\n- Check https://github.com/Zyptrue",
    Duration = 12,
    Type = "Info"
})
