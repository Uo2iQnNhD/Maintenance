-- =========================================================
-- SERVICES
-- =========================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- =========================================================
-- LOAD LIBRARY
-- =========================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

if type(Library) ~= "table" then
    warn("Library ZethHub Failed Loaded!", 0)
end

-- =========================================================
-- NOTIFICATION LAYOUT SETTINGS
-- =========================================================
-- Ini dipakai kalau library kamu sudah memakai patch notification Rayfield-style.
-- Kalau belum, tidak masalah, hanya tidak berpengaruh.
Library.NotificationWidth = Library.NotificationWidth or 320
Library.NotificationTopOffset = Library.NotificationTopOffset or 56
Library.NotificationRightOffset = Library.NotificationRightOffset or 16
Library.MiniSafeMargin = Library.MiniSafeMargin or 12

-- =========================================================
-- NOTIFICATION HELPER
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

    -- Coba pakai gaya Rayfield/table dulu.
    local ok = pcall(function()
        Library:Notify(cfg)
    end)

    -- Fallback ke gaya lama kalau library belum support table notification.
    -- Gaya lama: Library:Notify(content, duration, title, icon)
    if not ok then
        task.spawn(function()
            pcall(function()
                Library:Notify(content, duration, title, icon)
            end)
        end)
    end
end

-- =========================================================
-- REMOTE SCRIPT EXECUTOR
-- =========================================================
local function executeRemoteScript(url, sourceName)
    if not url or url == "" then
        notify(
            "Error",
            "Script URL not found for: " .. tostring(sourceName),
            5,
            "x-circle"
        )
        return
    end

    notify(
        "Executed Scripts",
        "Scripts Successfully Executed, Please wait 2 second!",
        4,
        "check-circle"
    )

    task.wait(2)

    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    if not ok then
        notify(
            "Execution Error",
            "Failed to run " .. tostring(sourceName) .. "\n" .. tostring(err),
            6,
            "x-circle"
        )
    end
end

-- =========================================================
-- WINDOW SETUP
-- =========================================================
local InitialAccent = Color3.fromRGB(0, 12, 255)

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
            Text = "Universal",
            Color = Color3.fromRGB(255, 204, 0),
            TextColor = Color3.fromRGB(0, 0, 0),
        },
        {
            Text = "V-sTi2Br5D",
            Color = Color3.fromRGB(46, 230, 110),
            TextColor = Color3.fromRGB(0, 0, 0),
        },
    },
})

if not Window then
    warn("Failed to create a Window!", 0)
end

local function SetAppAccent(color)
    if type(Library.SetAccent) == "function" then
        Library:SetAccent(color)
    end

    if Window and not Window._destroyed and type(Window.SetAccent) == "function" then
        Window:SetAccent(color)
    end
end

-- =========================================================
-- THEME PRESETS
-- =========================================================
-- ZethHub saat ini belum punya ModifyTheme penuh seperti Rayfield.
-- Jadi theme di sini mengubah Accent + Rainbow/YinYang border.
local THEME_PRESETS = {
    Default = {
        Accent = Color3.fromRGB(50, 138, 220),
        Rainbow = false,
    },
    AmberGlow = {
        Accent = Color3.fromRGB(255, 170, 85),
        Rainbow = false,
    },
    Bloom = {
        Accent = Color3.fromRGB(255, 140, 170),
        Rainbow = false,
    },
    Amethyst = {
        Accent = Color3.fromRGB(150, 100, 200),
        Rainbow = false,
    },
    DarkBlue = {
        Accent = Color3.fromRGB(0, 150, 240),
        Rainbow = false,
    },
    Green = {
        Accent = Color3.fromRGB(100, 180, 100),
        Rainbow = false,
    },
    Light = {
        Accent = Color3.fromRGB(255, 255, 255),
        Rainbow = false,
    },
    Ocean = {
        Accent = Color3.fromRGB(0, 160, 160),
        Rainbow = false,
    },
    YinYang = {
        Accent = Color3.fromRGB(255, 255, 255),
        Rainbow = true,
    },
    Rainbow = {
        Accent = Color3.fromRGB(255, 255, 255),
        Rainbow = true,
    },
}

local function applyTheme(themeName)
    local preset = THEME_PRESETS[themeName]

    if not preset then
        notify(
            "Theme Error",
            "Theme not found: " .. tostring(themeName),
            5,
            "x-circle"
        )
        return
    end

    if type(Library.SetRainbow) == "function" then
        Library:SetRainbow(preset.Rainbow == true)
    end

    SetAppAccent(preset.Accent or InitialAccent)

    notify(
        "Theme",
        "Theme applied: " .. tostring(themeName),
        4,
        "check-circle"
    )
end

-- =========================================================
-- TABS
-- =========================================================
local ChangelogTab = Window:CreateTab("Changelog", "mail")
local MainMenuTab = Window:CreateTab("Main Menu", "gamepad-2")
local ToolsTab = Window:CreateTab("Tools", "wrench")
-- =========================================================
-- CHANGELOG TAB
-- =========================================================
ChangelogTab:CreateSection("Information & Version")

ChangelogTab:CreateParagraph({
    Title = "RBX-V25",
    Content = {
        "- [+] Added Select Script in Visual Player",
        "- [+] Added Script Headless & Korblox",
        "- [+] Added Script Animation Roblox",
        "- [+] Added More Icon & Detail",
        "- [!!] Fixed Bugs Loading Screen",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "RBX-V28",
    Content = {
        "- [+] Release New Library",
        "- [+] Fixed Notification Bug",
        "- [+] Fixed Mini-Box Limit",
        "- [+] Added Change Theme",
        "- [+] Added Action On Close Button",
        "- [+] Deleted Icon Default >> Lucide",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "RBX-V31",
    Content = {
        "- [+] Added More Theme",
        "- [+] Added Multi-Dropdown",
        "- [+] Added Global Tab",
    },
    Icon = "file-text",
})

ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
    Title = "RBX-V32",
    Content = "Unknown, Coming Soon!",
    Icon = "timer",
})

-- =========================================================
-- MAIN MENU TAB
-- =========================================================
MainMenuTab:CreateSection("Game Support")

MainMenuTab:CreateParagraph({
    Title = "System Information",
    Content = {
        "- Choose Your Script and execute that script",
        "- This scripts Not my Own",
    },
    Icon = "shield",
})

MainMenuTab:CreateParagraph({
    Title = "Guide Information",
    Content = "When executed, the automatic picker selects and runs the appropriate script based on the game being played. if the game is supported, it uses a different script than it would for an unsupported game",
    Icon = "book-open",
})

local MAIN_SCRIPT_OPTIONS = {
    "None",
    "👑 Zeutron [HUB]",
    "🛠️ TLK Prison",
    "🎯 Area 51 Remake",
    "🚗 Jailbreak",
    "🔪 Violence District",
    "🔥 Power Incremental",
    "🥚 Steal an Egg",
    "🚀 Untitled Upgrade Tree",
    "🎃 The Hollow: Roblox",
    "🔫 Murderer Vs Shiriff Duels",
}

local MAIN_SCRIPT_URLS = {
    ["👑 Zeutron [HUB]"] = "https://raw.githubusercontent.com/Zyptrue/Release/refs/heads/main/New%20Interface",
    ["🛠️ TLK Prison"] = "https://raw.githubusercontent.com/IOERHUB/CheckingV2/refs/heads/main/Protection",
    ["🎯 Area 51 Remake"] = "https://raw.githubusercontent.com/zeutronxsite/Area-51-Remake/refs/heads/main/Latest%20Version",
    ["🚗 Jailbreak"] = "https://raw.githubusercontent.com/zeutronxsite/M6txEKBDBreak/refs/heads/main/Working",
    ["🔪 Violence District"] = "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/XptC65ba-MainVD.lua",
    ["🔥 Power Incremental"] = "https://raw.githubusercontent.com/IOERHUB/Power-Incremental/refs/heads/main/Working",
    ["🥚 Steal an Egg"] = "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/sAcfzDLt-Steal%20An%20Egg.lua",
    ["🚀 Untitled Upgrade Tree"] = "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/XoDBQiPs-Untitled%20Upg%20Tree",
    ["🎃 The Hollow: Roblox"] = "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/The%20Hollow%3A%20Roblox.lua",
    ["🔫 Murderer Vs Shiriff Duels"] = "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/eyPSrASq-MVSD.lua",
}

local selectedMainScript = "None"

MainMenuTab:CreateDropdown({
    Name = "Select Scripts",
    Options = MAIN_SCRIPT_OPTIONS,
    Default = "None",
    Flag = "MainScriptDropdown",
    Icon = "chevron-down",
    Tooltip = "Select the game script you want to run",
    Callback = function(value)
        selectedMainScript = value
    end,
})

MainMenuTab:CreateButton({
    Name = "Execute Selected Scripts",
    Icon = "play",
    Tooltip = "Run the selected script",
    Callback = function()
        if not selectedMainScript or selectedMainScript == "None" then
            notify(
                "Error",
                "Please select a script first!",
                5,
                "x-circle"
            )
            return
        end

        executeRemoteScript(MAIN_SCRIPT_URLS[selectedMainScript], selectedMainScript)
    end,
})

MainMenuTab:CreateSection("???-Locked")

MainMenuTab:CreateParagraph({
    Title = "Information",
    Content = "More Stuff Is coming Soon",
    Icon = "megaphone",
})
