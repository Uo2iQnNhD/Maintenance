-- =========================================================
-- SERVICES
-- =========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =========================================================
-- LOAD LIBRARY
-- =========================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

if type(Library) ~= "table" then
    error("[ZethHub] Library failed to load.", 0)
end

-- =========================================================
-- NOTIFICATION HELPER (Rayfield Style)
-- =========================================================
local function notificationText(value)
    if type(value) == "table" then
        return table.concat(value, "\n")
    end
    return tostring(value or "")
end

local function notify(title, content, duration, icon, color)
    if type(Library) ~= "table" or type(Library.Notify) ~= "function" then
        return
    end

    title = notificationText(title)
    content = notificationText(content)
    duration = tonumber(duration) or 5

    if duration < 0.1 then
        duration = 0.1
    end

    local cfg = {
        Title = title,
        Content = content,
        Duration = duration,
        Image = icon,
    }

    if color and typeof(color) == "Color3" then
        cfg.Color = color
    end

    local ok = pcall(function()
        Library:Notify(cfg)
    end)

    -- Fallback to old style if library doesn't support table yet
    if not ok then
        task.spawn(function()
            pcall(function()
                Library:Notify(content, duration, title, icon)
            end)
        end)
    end
end

-- =========================================================
-- REMOTE SCRIPT EXECUTOR HELPER
-- =========================================================
local function executeScript(url, scriptName)
    if not url or url == "" then
        notify("Error", "Script URL not found for: " .. tostring(scriptName), 5, "x-circle")
        return
    end

    notify("Executed Scripts", "Scripts Successfully Executed!", 6, "check-circle")
    task.wait(0.5)

    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    if not ok then
        notify(
            "Execution Error",
            "Failed to run " .. tostring(scriptName) .. "\n" .. tostring(err),
            6,
            "x-circle"
        )
    end
end

-- =========================================================
-- WINDOW SETUP
-- =========================================================
local InitialAccent = Color3.fromRGB(255, 0, 0)

if type(Library.SetAccent) == "function" then
    Library:SetAccent(InitialAccent)
end

if type(Library.SetRainbow) == "function" then
    Library:SetRainbow(false)
end

Library.ToggleKey = Enum.KeyCode.K

local Window = Library:CreateWindow({
    Title = "Super Zeutron",
    Subtitle = "By Exterminate0 & Zeutron Team",
    Accent = InitialAccent,

    -- Warna close button / confirm modal
    CloseColor = Color3.fromRGB(255, 80, 80),
    CloseHoverColor = Color3.fromRGB(255, 120, 120),
    ClosePressedColor = Color3.fromRGB(190, 50, 50),
    CloseTextColor = Color3.fromRGB(255, 255, 255), -- opsional
        
    Tags = {
        {
            Text = "Steal An Egg",
            Color = Color3.fromRGB(255, 204, 0),
            TextColor = Color3.fromRGB(0, 0, 0),
        },
        {
            Text = "V-vVaLjCVc",
            Color = Color3.fromRGB(46, 230, 110),
            TextColor = Color3.fromRGB(0, 0, 0),
        },
    },
})

if not Window then
    error("[ZethHub] Failed to create Window.", 0)
end

-- =========================================================
-- THEME PRESETS & HELPER
-- =========================================================
local THEME_PRESETS = {
    Default = { Accent = Color3.fromRGB(50, 138, 220), Rainbow = false },
    AmberGlow = { Accent = Color3.fromRGB(255, 170, 85), Rainbow = false },
    Bloom = { Accent = Color3.fromRGB(255, 140, 170), Rainbow = false },
    Amethyst = { Accent = Color3.fromRGB(150, 100, 200), Rainbow = false },
    DarkBlue = { Accent = Color3.fromRGB(0, 150, 240), Rainbow = false },
    Green = { Accent = Color3.fromRGB(100, 180, 100), Rainbow = false },
    Light = { Accent = Color3.fromRGB(255, 255, 255), Rainbow = false },
    Ocean = { Accent = Color3.fromRGB(0, 160, 160), Rainbow = false },
}

local function applyTheme(themeName)
    local preset = THEME_PRESETS[themeName]
    if not preset then
        notify("Theme Error", "Theme not found: " .. tostring(themeName), 5, "x-circle")
        return
    end

    if type(Library.SetRainbow) == "function" then
        Library:SetRainbow(preset.Rainbow)
    end

    if type(Library.SetAccent) == "function" then
        Library:SetAccent(preset.Accent)
    end

    if Window and not Window._destroyed and type(Window.SetAccent) == "function" then
        Window:SetAccent(preset.Accent)
    end

    notify("Theme", "Successfully changed theme to " .. themeName, 4, "check-circle")
end

-- =========================================================
-- INITIAL NOTIFY
-- =========================================================
notify("Notification Alert", "Thank you for using this scripts", 6, "bell")

-- =========================================================
-- TABS
-- =========================================================
local ChangelogTab = Window:CreateTab("Changelog", "newspaper")
local MainTab = Window:CreateTab("Main Scripts", "sword")
local ThemeTab = Window:CreateTab("Theme & Settings", "palette")

-- =========================================================
-- CHANGELOG TAB
-- =========================================================
ChangelogTab:CreateSection("Information & Version")

ChangelogTab:CreateParagraph({
    Title = "🔁 V-A9ESKII",
    Content = {
        "- [+] Added Scripts GUI And Auto farm",
        "- [+] Add Changelog",
        "- [+] Add Theme and Destroy",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "🔁 V-8A9ESKII",
    Content = {
        "- [+] Added Scripts Sena [HUB]",
        "- [+] Added More Details",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "🔁 V-vVaLjCVc",
    Content = {
        "- [+] Added Scripts AXON [HUB]",
        "- [+] Added Pet Spawner [1],[2],[3]",
        "- [+] Fixed Some Bugs",
        "- [+] Added Gifter Gamepass & Pet Spawner 4",
    },
    Icon = "file-text",
})

ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
    Title = "❌ V-DdP4bugv",
    Content = "Unknown, Coming Soon!",
    Icon = "clock",
})

-- =========================================================
-- MAIN SCRIPTS TAB
-- =========================================================
MainTab:CreateSection("Main Menu")

MainTab:CreateParagraph({
    Title = "🛡️ System Information",
    Content = {
        "This Scripts Is safe and has been tested",
        "- All these scripts are not mine",
    },
    Icon = "shield",
})

-- Main Scripts Dropdown
local MAIN_SCRIPTS_OPTIONS = {
    "None",
    "NIGHT [HUB & KEYLESS]",
    "LENNON [HUB & KEYLESS]",
    "MIRANDA [HUB & KEYLESS]",
    "Chilli [HUB & FREE]",
    "Sena [HUB & V5]",
    "AXON [HUB & KEYLESS]",
    "LIMBO [FREE]",
}

local MAIN_SCRIPTS_URLS = {
    ["NIGHT [HUB & KEYLESS]"] = "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealEggOnly.luau",
    ["LENNON [HUB & KEYLESS]"] = "https://flowauth.net/v1/ui/584e23b68f5f361081321954763ab5e5.lua",
    ["MIRANDA [HUB & KEYLESS]"] = "https://flowauth.net/v1/ui/5f7a6b969f81332d7994e3b5eb71c686.lua",
    ["Chilli [HUB & FREE]"] = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua",
    ["Sena [HUB & V5]"] = "https://senahub.xyz/raw/loader",
    ["AXON [HUB & KEYLESS]"] = "https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua",
    ["LIMBO [FREE]"] = "https://limbohub.my.id/loader.lua",
}

local selectedMainScript = "None"

MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = MAIN_SCRIPTS_OPTIONS,
    Default = "None",
    Flag = "MainScriptDropdown",
    Icon = "chevron-down",
    Tooltip = "Select the main script to execute",
    Callback = function(value)
        selectedMainScript = value
    end,
})

MainTab:CreateButton({
    Name = "Execute Selected Scripts",
    Icon = "play",
    Tooltip = "Execute the selected script",
    Callback = function()
        if not selectedMainScript or selectedMainScript == "None" then
            notify("Error", "Please select a script first!", 5, "x-circle")
            return
        end
        executeScript(MAIN_SCRIPTS_URLS[selectedMainScript], selectedMainScript)
    end,
})

-- Pet Spawner Section
MainTab:CreateSection("Pet Spawner & More")

MainTab:CreateParagraph({
    Title = "📚 Guide Information",
    Content = {
        "This Scripts Is safe and has been tested",
        "- All these scripts are not mine",
        "- This script is client-side only and not the real thing, so don't get your hopes up too high",
    },
    Icon = "book-open",
})

local PET_SPAWNER_OPTIONS = {
    "None",
    "PET SPAWNER [FREE & CLIENT]",
    "PET SPAWNER 2 [FREE & CLIENT]",
    "PET SPAWNER 3 [KEYLESS & CLIENT]",
    "PET SPAWNER 4 [KEYLESS & CLIENT]",
    "GIFTER GAMEPASS [KEYLESS & CLIENT]",
}

local PET_SPAWNER_URLS = {
    ["PET SPAWNER [FREE & CLIENT]"] = "https://raw.githubusercontent.com/zenvex4/StealAnEgg/refs/heads/main/Loader.lua",
    ["PET SPAWNER 2 [FREE & CLIENT]"] = "https://raw.githubusercontent.com/INF-Hub-PL/StealAEggScript/refs/heads/main/Pet_SpawnerV1",
    ["PET SPAWNER 3 [KEYLESS & CLIENT]"] = "https://scriptversekey.xyz/s/steal-an-egg-pet-spawner",
    ["PET SPAWNER 4 [KEYLESS & CLIENT]"] = "https://pastefy.app/t06eyyrw/raw",
    ["GIFTER GAMEPASS [KEYLESS & CLIENT]"] = "https://pastefy.app/CkaV7ET8/raw",
}

local selectedPetScript = "None"

MainTab:CreateDropdown({
    Name = "Select Scripts",
    Options = PET_SPAWNER_OPTIONS,
    Default = "None",
    Flag = "PetScriptDropdown",
    Icon = "chevron-down",
    Tooltip = "Select pet spawner / extra script",
    Callback = function(value)
        selectedPetScript = value
    end,
})

MainTab:CreateButton({
    Name = "Execute Selected Scripts",
    Icon = "play",
    Tooltip = "Execute the selected pet spawner script",
    Callback = function()
        if not selectedPetScript or selectedPetScript == "None" then
            notify("Error", "Please select a script first!", 5, "x-circle")
            return
        end
        executeScript(PET_SPAWNER_URLS[selectedPetScript], selectedPetScript)
    end,
})

-- =========================================================
-- THEME & SETTINGS TAB
-- =========================================================
ThemeTab:CreateSection("Select Theme")

ThemeTab:CreateParagraph({
    Title = "📚 Guide Information",
    Content = "Select a color to change the Scripts accent and style.",
    Icon = "palette",
})

local THEME_OPTIONS = {
    "Default",
    "AmberGlow",
    "Bloom",
    "Amethyst",
    "DarkBlue",
    "Green",
    "Light",
    "Ocean",
}

local selectedTheme = "Default"

ThemeTab:CreateDropdown({
    Name = "Select Theme",
    Options = THEME_OPTIONS,
    Default = "Default",
    Flag = "ThemeDropdown",
    Icon = "chevron-down",
    Tooltip = "Select color theme",
    Callback = function(value)
        selectedTheme = value
    end,
})

ThemeTab:CreateButton({
    Name = "Execute Selected Theme",
    Icon = "check",
    Tooltip = "Apply the selected theme",
    Callback = function()
        if not selectedTheme or selectedTheme == "" then
            notify("Error", "Please select a Theme first!", 5, "x-circle")
            return
        end
        applyTheme(selectedTheme)
    end,
})

ThemeTab:CreateSection("More Settings")

ThemeTab:CreateButton({
    Name = "Zeutron [HUB]",
    Icon = "crown",
    Tooltip = "Load Zeutron Universal Hub",
    Callback = function()
        executeScript(
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/L3aun246-Universal.lua",
            "Zeutron [HUB]"
        )
    end,
})

ThemeTab:CreateButton({
    Name = "Destroy UI/Interface",
    Icon = "trash-2",
    Tooltip = "Destroy ZethHub UI",
    Callback = function()
        notify(
            "Warning Detected",
            "The script will self-destruct in 7 seconds!",
            7,
            "shield-alert"
        )
        task.wait(7)
        
        if Window and not Window._destroyed and type(Window.Destroy) == "function" then
            Window:Destroy()
        end
    end,
})
