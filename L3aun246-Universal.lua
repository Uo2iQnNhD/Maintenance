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
local InitialAccent = Color3.fromRGB(50, 138, 220)

if type(Library.SetAccent) == "function" then
    Library:SetAccent(InitialAccent)
end

if type(Library.SetRainbow) == "function" then
    Library:SetRainbow(false)
end

Library.ToggleKey = Enum.KeyCode.RightShift

local Window = Library:CreateWindow({
    Title = "Supreme-XYZ",
    Subtitle = "By Exterminate0 & Zeutron Team",
    Accent = InitialAccent,
    Tags = {
        {
            Text = "Universal",
            Color = Color3.fromRGB(255, 204, 0),
            TextColor = Color3.fromRGB(0, 0, 0),
        },
        {
            Text = "V-xicochfh",
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
local SettingsTab = Window:CreateTab("Theme & Settings", "settings")

-- =========================================================
-- CHANGELOG TAB
-- =========================================================
ChangelogTab:CreateSection("Information & Version")

ChangelogTab:CreateParagraph({
    Title = "V-LLQCH3DC",
    Content = {
        "- [+] Added Script & Fixed Some Bugs",
        "- [+] Updated Key System UI & Key Generator",
        "- [+] Added 🥚 Steal an Egg",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "V-7H4RXYE5",
    Content = {
        "- [!!] Deleted 🎮 Automatic [Picker]",
        "- [+] Buffer Wait scripts 3 sec >> 2 sec",
        "- [!!] Deleted Key System & Key Generator",
        "- [!!] Deleted Checking User/players",
        "- [+] Updated 🥚 Steal an Egg",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "V-EESpz2Xk",
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
    Title = "V-xicochfh",
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

ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
    Title = "V-sTi2Br5D",
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

-- =========================================================
-- TOOLS TAB - MOVEMENT
-- =========================================================
ToolsTab:CreateSection("Movement")

_G.infinjump = false

local function getHumanoid()
    local char = LocalPlayer.Character
    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

ToolsTab:CreateToggle({
    Name = "Infinite Jump",
    Default = false,
    Flag = "InfiniteJumpToggle",
    Icon = "activity",
    Tooltip = "Turn ON/OFF Inf Jump",
    Callback = function(value)
        _G.infinjump = value

        if value then
            notify(
                "System Information",
                "Infinite Jump Has Been Activated",
                5,
                "info"
            )
        else
            notify(
                "System Information",
                "Infinite Jump Has Been Disabled",
                5,
                "info"
            )
        end
    end,
})

UserInputService.JumpRequest:Connect(function()
    if not _G.infinjump then
        return
    end

    local char = LocalPlayer.Character
    if not char then
        return
    end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)

-- WalkSpeed
_G.walkspeedValue = 16
_G.walkspeedActive = false

ToolsTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 0,
    Max = 5000,
    Default = 16,
    Flag = "WalkSpeedSlider",
    Icon = "gauge",
    Tooltip = "Value WalkSpeed",
    Callback = function(value)
        _G.walkspeedValue = value

        if _G.walkspeedActive then
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end,
})

ToolsTab:CreateToggle({
    Name = "Turn ON/OFF WalkSpeed",
    Default = false,
    Flag = "WalkSpeedToggle",
    Icon = "toggle-right",
    Tooltip = "Turn ON/OFF WalkSpeed",
    Callback = function(value)
        _G.walkspeedActive = value
        local humanoid = getHumanoid()

        if value then
            if humanoid then
                humanoid.WalkSpeed = _G.walkspeedValue
            end

            notify(
                "WalkSpeed ON",
                "WalkSpeed on with value " .. tostring(_G.walkspeedValue),
                5,
                "check-circle"
            )
        else
            if humanoid then
                humanoid.WalkSpeed = 16
            end

            notify(
                "WalkSpeed OFF",
                "WalkSpeed disable (reset to 16)",
                5,
                "x-circle"
            )
        end
    end,
})

-- JumpPower
_G.jumppowerValue = 50
_G.jumppowerActive = false

ToolsTab:CreateSlider({
    Name = "JumpPower",
    Min = 0,
    Max = 5000,
    Default = 50,
    Flag = "JumpPowerSlider",
    Icon = "chevron-up",
    Tooltip = "Value JumpPower",
    Callback = function(value)
        _G.jumppowerValue = value

        if _G.jumppowerActive then
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = value
            end
        end
    end,
})

ToolsTab:CreateToggle({
    Name = "Turn ON/OFF JumpPower",
    Default = false,
    Flag = "JumpPowerToggle",
    Icon = "toggle-right",
    Tooltip = "Turn ON/OFFJumpPower",
    Callback = function(value)
        _G.jumppowerActive = value
        local humanoid = getHumanoid()

        if value then
            if humanoid then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = _G.jumppowerValue
            end

            notify(
                "JumpPower ON",
                "JumpPower on with value " .. tostring(_G.jumppowerValue),
                5,
                "check-circle"
            )
        else
            if humanoid then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = 50
            end

            notify(
                "JumpPower OFF",
                "JumpPower disable (reset to 50)",
                5,
                "x-circle"
            )
        end
    end,
})

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)

    local humanoid = char:WaitForChild("Humanoid", 5)
    if not humanoid then
        return
    end

    if _G.walkspeedActive then
        humanoid.WalkSpeed = _G.walkspeedValue
    end

    if _G.jumppowerActive then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = _G.jumppowerValue
    end
end)

-- =========================================================
-- TOOLS TAB - EXTERNAL SCRIPTS
-- =========================================================
ToolsTab:CreateSection("External Scripts")

ToolsTab:CreateParagraph({
    Title = "System Information",
    Content = "All these scripts work with all games",
    Icon = "shield",
})

local TOOL_SCRIPT_OPTIONS = {
    "None",
    "♾️ Infinite Yield",
    "🖥️ Executor Editor [BETA]",
    "📌 Waypoint Manager [S.W.P]",
    "🛡️ Anti-Fling [Protection]",
    "🎭 Animation Roblox [Working]",
    "👁️ Esp Monster [Beta]",
}

local TOOL_SCRIPT_URLS = {
    ["♾️ Infinite Yield"] = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    ["🖥️ Executor Editor [BETA]"] = "https://raw.githubusercontent.com/zeutronxsite/nf5guunQd-exec/refs/heads/main/executor.luau",
    ["📌 Waypoint Manager [S.W.P]"] = "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/xtvqz7us-Waypoint.lua",
    ["🛡️ Anti-Fling [Protection]"] = "https://pastebin.com/raw/MhJDcWjR",
    ["🎭 Animation Roblox [Working]"] = "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/BundleAnimations.lua",
    ["👁️ Esp Monster [Beta]"] = "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/aXXcS4rE-Esp%20Monster.lua",
}

local selectedToolScript = "None"

ToolsTab:CreateDropdown({
    Name = "Select Scripts",
    Options = TOOL_SCRIPT_OPTIONS,
    Default = "None",
    Flag = "ToolScriptDropdown",
    Icon = "chevron-down",
    Tooltip = "Choose external script",
    Callback = function(value)
        selectedToolScript = value
    end,
})

ToolsTab:CreateButton({
    Name = "Execute Selected Scripts",
    Icon = "play",
    Tooltip = "Run the selected external script",
    Callback = function()
        if not selectedToolScript or selectedToolScript == "None" then
            notify(
                "Error",
                "Please select a script first!",
                5,
                "x-circle"
            )
            return
        end

        executeRemoteScript(TOOL_SCRIPT_URLS[selectedToolScript], selectedToolScript)
    end,
})

-- =========================================================
-- TOOLS TAB - ESP PLAYER
-- =========================================================
ToolsTab:CreateSection("Visual / ESP")

local espEnabled = false
local espObjects = {}
local espCharacterConnections = {}
local updateConnection = nil

local function collectKeys(tbl)
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

local function getTeamColor(player)
    local team = nil
    pcall(function()
        team = player.Team
    end)

    local teamName = (team and team.Name) or ""

    local teamColorMap = {
        ["Fugitive"] = Color3.fromRGB(255, 50, 50),
        ["Prison"] = Color3.fromRGB(255, 150, 0),
        ["Police"] = Color3.fromRGB(0, 100, 255),
        ["Civilian"] = Color3.fromRGB(50, 255, 50),

        ["Hostage"] = Color3.fromRGB(255, 0, 255),
        ["Choosing"] = Color3.fromRGB(0, 255, 255),
        ["ADMIN"] = Color3.fromRGB(255, 215, 0),

        ["Red"] = Color3.fromRGB(255, 50, 50),
        ["Blue"] = Color3.fromRGB(50, 100, 255),
        ["Green"] = Color3.fromRGB(50, 255, 50),
        ["Yellow"] = Color3.fromRGB(255, 255, 50),
        ["Purple"] = Color3.fromRGB(200, 50, 255),
        ["White"] = Color3.fromRGB(255, 255, 255),
        ["Black"] = Color3.fromRGB(50, 50, 50),
    }

    for name, color in pairs(teamColorMap) do
        if string.lower(teamName) == string.lower(name) then
            return color
        end
    end

    local teamColor = nil
    pcall(function()
        teamColor = team and team.TeamColor and team.TeamColor.Color
    end)

    return teamColor or Color3.fromRGB(255, 255, 255)
end

local function clearPlayerESP(player)
    local data = espObjects[player]
    if data then
        pcall(function()
            if data.billboard then
                data.billboard:Destroy()
            end
        end)

        pcall(function()
            if data.highlight then
                data.highlight:Destroy()
            end
        end)

        espObjects[player] = nil
    end

    local conn = espCharacterConnections[player]
    if conn then
        pcall(function()
            conn:Disconnect()
        end)

        espCharacterConnections[player] = nil
    end
end

local function clearAllESP()
    for _, player in ipairs(collectKeys(espObjects)) do
        clearPlayerESP(player)
    end

    for _, player in ipairs(collectKeys(espCharacterConnections)) do
        clearPlayerESP(player)
    end

    espObjects = {}
end

local function createESP(targetPlayer)
    if targetPlayer == LocalPlayer then
        return
    end

    local function setupESP(char)
        if not char then
            return
        end

        local head = char:WaitForChild("Head", 5)
        local hum = char:WaitForChild("Humanoid", 5)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)

        if not head or not hum or not hrp then
            return
        end

        local teamColor = getTeamColor(targetPlayer)

        if head:FindFirstChild("PlayerESP_GUI") then
            head.PlayerESP_GUI:Destroy()
        end

        if char:FindFirstChild("PlayerESP_HL") then
            char.PlayerESP_HL:Destroy()
        end

        -- Highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerESP_HL"

        pcall(function()
            highlight.FillColor = teamColor
            highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        end)

        highlight.Adornee = char
        highlight.Parent = char

        -- Billboard
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "PlayerESP_GUI"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 140, 0, 60)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.ResetOnSpawn = false
        billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        billboard.Parent = head

        -- Name
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

        -- Distance
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

        -- HP Background
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

        -- HP Fill
        local hpFill = Instance.new("Frame")
        hpFill.Name = "HealthFill"
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        hpFill.BorderSizePixel = 0
        hpFill.Parent = hpBg

        local hpCornerFill = Instance.new("UICorner")
        hpCornerFill.CornerRadius = UDim.new(0, 3)
        hpCornerFill.Parent = hpFill

        -- HP Label
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

        -- Team Label
        local teamLabel = Instance.new("TextLabel")
        teamLabel.Name = "TeamLabel"
        teamLabel.Size = UDim2.new(1, 0, 0, 10)
        teamLabel.Position = UDim2.new(0, 0, 0, 46)
        teamLabel.BackgroundTransparency = 1
        teamLabel.Text = "[" .. ((targetPlayer.Team and targetPlayer.Team.Name) or "No Team") .. "]"
        teamLabel.TextColor3 = teamColor
        teamLabel.TextStrokeTransparency = 0
        teamLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        teamLabel.Font = Enum.Font.Gotham
        teamLabel.TextSize = 10
        teamLabel.Parent = billboard

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
            character = char,
        }
    end

    if targetPlayer.Character then
        setupESP(targetPlayer.Character)
    end

    if not espCharacterConnections[targetPlayer] then
        espCharacterConnections[targetPlayer] = targetPlayer.CharacterAdded:Connect(function(char)
            if espEnabled then
                task.wait(0.5)
                setupESP(char)
            end
        end)
    end
end

local function startUpdateLoop()
    if updateConnection then
        updateConnection:Disconnect()
        updateConnection = nil
    end

    updateConnection = RunService.RenderStepped:Connect(function()
        local myChar = LocalPlayer.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")

        for player, data in pairs(espObjects) do
            pcall(function()
                local hum = data.humanoid
                local hrp = data.hrp
                local fill = data.hpFill
                local hpLabel = data.hpLabel
                local distLabel = data.distanceLabel

                -- HP
                if hum and fill and hpLabel and hum.Parent then
                    local currentHP = math.floor(hum.Health)
                    local maxHP = math.floor(hum.MaxHealth)
                    local percent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)

                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    hpLabel.Text = string.format("HP: %d/%d", currentHP, maxHP)

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

                -- Distance
                if myHRP and hrp and hrp.Parent and distLabel then
                    local distance = (myHRP.Position - hrp.Position).Magnitude
                    distLabel.Text = string.format("[%dm]", math.floor(distance))

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

local function toggleESP(state)
    espEnabled = state

    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
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

Players.PlayerAdded:Connect(function(player)
    if espEnabled and player ~= LocalPlayer then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    clearPlayerESP(player)
end)

ToolsTab:CreateToggle({
    Name = "ESP Player",
    Default = false,
    Flag = "ESPPlayerToggle",
    Icon = "eye",
    Tooltip = "Activate ESP players with HP, distance, and team",
    Callback = function(value)
        toggleESP(value)
    end,
})

-- =========================================================
-- TOOLS TAB - PLAYER JOIN/LEAVE NOTIFICATION
-- =========================================================
ToolsTab:CreateSection("Server Notifications")

_G.JoinLeaveEnabled = false

-- Bersihkan GUI lama jika script dijalankan ulang
local function removeOldJoinLeaveGui()
    local parents = { PlayerGui }

    if typeof(gethui) == "function" then
        local ok, hui = pcall(gethui)
        if ok and hui then
            table.insert(parents, hui)
        end
    end

    local okCore, CoreGui = pcall(function()
        return game:GetService("CoreGui")
    end)

    if okCore and CoreGui then
        table.insert(parents, CoreGui)
    end

    for _, parent in ipairs(parents) do
        if parent then
            for _, child in ipairs(parent:GetChildren()) do
                if child:IsA("ScreenGui") and child.Name == "JoinLeaveNotificationGui" then
                    pcall(function()
                        child:Destroy()
                    end)
                end
            end
        end
    end
end

removeOldJoinLeaveGui()

local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "JoinLeaveNotificationGui"
NotificationGui.ResetOnSpawn = false
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotificationGui.IgnoreGuiInset = true
NotificationGui.DisplayOrder = 999999

local notifParent = PlayerGui

if typeof(gethui) == "function" then
    local ok, hui = pcall(gethui)
    if ok and hui then
        notifParent = hui
    end
end

NotificationGui.Parent = notifParent

local activeNotifications = {}
local notificationQueue = {}
local isProcessingQueue = false

local processNotificationQueue
local showPlayerNotification

local function getAvatarUrl(userId)
    if not userId or userId == 0 then
        return "rbxasset://textures/ui/GuiImagePlaceholder.png"
    end

    return "https://www.roblox.com/headshot-thumbnail/image?userId="
        .. userId
        .. "&width=150&height=150&format=png"
end

local function getCurrentTime()
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

            TweenService:Create(
                frame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { Position = targetPosition }
            ):Play()
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

    local currentPlayers = #Players:GetPlayers()
    if not isJoining then
        currentPlayers = math.max(0, currentPlayers - 1)
    end

    local maxPlayers = 99
    local success, result = pcall(function()
        return game.MaxPlayers
    end)

    if success and type(result) == "number" and result > 0 then
        maxPlayers = result
    end

    local infoText = string.format(
        "Players: %d/%d | Time: %s",
        currentPlayers,
        maxPlayers,
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
        if not notifFrame.Parent then
            return
        end

        TweenService:Create(
            notifFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {
                Position = UDim2.new(1, 20, 1, 20),
                BackgroundTransparency = 1,
            }
        ):Play()

        TweenService:Create(avatarImage, TweenInfo.new(0.5), { ImageTransparency = 1 }):Play()
        TweenService:Create(titleLabel, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
        TweenService:Create(nameLabel, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
        TweenService:Create(infoLabel, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()

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

processNotificationQueue = function()
    if isProcessingQueue or #notificationQueue == 0 then
        return
    end

    isProcessingQueue = true

    local data = table.remove(notificationQueue, 1)

    if type(showPlayerNotification) == "function" then
        showPlayerNotification(data.playerName, data.userId, data.isJoining)
    end

    task.delay(0.5, function()
        isProcessingQueue = false

        if type(processNotificationQueue) == "function" then
            processNotificationQueue()
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    if not _G.JoinLeaveEnabled then
        return
    end

    table.insert(notificationQueue, {
        playerName = player.Name,
        userId = player.UserId,
        isJoining = true,
    })

    if type(processNotificationQueue) == "function" then
        processNotificationQueue()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if not _G.JoinLeaveEnabled then
        return
    end

    table.insert(notificationQueue, {
        playerName = player.Name,
        userId = player.UserId,
        isJoining = false,
    })

    if type(processNotificationQueue) == "function" then
        processNotificationQueue()
    end
end)

ToolsTab:CreateToggle({
    Name = "Player Notification",
    Default = false,
    Flag = "JoinLeaveNotifToggle",
    Icon = "users",
    Tooltip = "Show player join/leave notifications",
    Callback = function(value)
        _G.JoinLeaveEnabled = value

        if value then
            local pName = (LocalPlayer and LocalPlayer.Name) or "Unknown"
            local pId = (LocalPlayer and LocalPlayer.UserId) or 0

            table.insert(notificationQueue, {
                playerName = pName .. " (You)",
                userId = pId,
                isJoining = true,
            })

            if type(processNotificationQueue) == "function" then
                processNotificationQueue()
            else
                warn("[Zeutron Hub] processNotificationQueue is nil!")
            end
        end
    end,
})

-- =========================================================
-- SETTINGS TAB - THEME
-- =========================================================
SettingsTab:CreateSection("Theme")

SettingsTab:CreateParagraph({
    Title = "Guide Information",
    Content = "Select a theme to change accent/rainbow. ZethHub saat ini belum memiliki sistem theme penuh seperti Rayfield.",
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
    "YinYang",
}

local selectedTheme = "Default"

SettingsTab:CreateDropdown({
    Name = "Select Theme",
    Options = THEME_OPTIONS,
    Default = "Default",
    Flag = "ThemeDropdown",
    Icon = "chevron-down",
    Tooltip = "Choose theme preset",
    Callback = function(value)
        selectedTheme = value
    end,
})

SettingsTab:CreateButton({
    Name = "Apply Selected Theme",
    Icon = "check",
    Tooltip = "Apply the selected theme",
    Callback = function()
        if not selectedTheme or selectedTheme == "" then
            notify(
                "Error",
                "Please select a theme first!",
                5,
                "x-circle"
            )
            return
        end

        applyTheme(selectedTheme)
    end,
})

-- =========================================================
-- SETTINGS TAB - MORE SETTINGS
-- =========================================================
SettingsTab:CreateSection("More Settings")

SettingsTab:CreateButton({
    Name = "Korblox & Headless",
    Icon = "gem",
    Tooltip = "This script is client only And Not real",
    Callback = function()
        executeRemoteScript(
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/SYtg4g76-Korblox%20%26%20Headless.lua",
            "Korblox & Headless"
        )
    end,
})

SettingsTab:CreateButton({
    Name = "Destroy Interface",
    Icon = "trash-2",
    Tooltip = "Destroyed Library",
    Callback = function()
        notify(
            "Warning Detected",
            "The script will self-destruct in 7 seconds!",
            7,
            "info"
        )

        task.wait(7)

        if Window and not Window._destroyed and type(Window.Destroy) == "function" then
            Window:Destroy()
        end
    end,
})

-- =========================================================
-- FINAL NOTIFY
-- =========================================================
notify(
    "Maintenance",
    "Library loaded successfully!",
    4,
    "badge-check"
)
