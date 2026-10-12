local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

-- =========================================================
-- 2. GLOBAL LIBRARY SETTINGS
-- =========================================================
Library:SetAccent(Color3.fromRGB(130, 90, 255))
Library:SetRainbow(false)
Library.ToggleKey = Enum.KeyCode.RightShift

-- =========================================================
-- 3. CREATE WINDOW
-- =========================================================
local Window = Library:CreateWindow({
    Title = "ZETHUB EXAMPLE",
    Subtitle = "All Elements Demo",
    Tags = {
        {Text = "V5", Color = Color3.fromRGB(255, 204, 0), TextColor = Color3.fromRGB(0, 0, 0)},
        {Text = "Demo", Color = Color3.fromRGB(46, 230, 110), TextColor = Color3.fromRGB(0, 0, 0)},
        {Text = "All Elements", FollowAccent = true},
    },
})

if not Window then
    error("[ZethHub Example] Gagal membuat window.")
end

-- Helper: ubah accent library + window sekaligus
-- Ini penting karena Library:SetAccent() tidak otomatis mengubah accent window yang sudah dibuat.
local function SetAppAccent(color)
    Library:SetAccent(color)

    if Window and not Window._destroyed then
        Window:SetAccent(color)
    end
end

SetAppAccent(Color3.fromRGB(130, 90, 255))

-- Contoh tambah tag manual setelah window dibuat
Window:AddTag({
    Text = "Manual Tag",
    Color = Color3.fromRGB(255, 80, 180),
    TextColor = Color3.fromRGB(255, 255, 255),
})

-- =========================================================
-- 4. CREATE TABS
-- =========================================================
local MainTab = Window:CreateTab("Main", "home")
local PlayerTab = Window:CreateTab("Player", "user")
local VisualTab = Window:CreateTab("Visual", "palette")
local InputTab = Window:CreateTab("Inputs", "type")
local SettingsTab = Window:CreateTab("Settings", "settings")
local DebugTab = Window:CreateTab("Debug", "activity")

-- =========================================================
-- 5. MAIN TAB
-- Elemen: Section, Label, Paragraph, Button, Notify, Window Control
-- =========================================================
MainTab:CreateSection("Information")

local StatusLabel = MainTab:CreateLabel("Status: Ready")

local GuideParagraph = MainTab:CreateParagraph({
    Title = "Guide",
    Content = {
        "Script ini menampilkan hampir semua element library.",
        "Setiap bagian diberi komentar agar mudah diperbaiki.",
        "Cek tab Debug untuk melihat Flags dan accent.",
    },
    Icon = "book-open",
})

MainTab:CreateSection("Buttons & Actions")

MainTab:CreateButton({
    Name = "Send Notification",
    Icon = "bell",
    Tooltip = "Contoh Library:Notify()",
    Callback = function()
        Library:Notify("Halo dari button!", 4, "Notify", "check-circle")
    end,
})

MainTab:CreateButton({
    Name = "Random Accent",
    Icon = "palette",
    Tooltip = "Mengubah accent library dan window",
    Callback = function()
        SetAppAccent(Color3.fromHSV(math.random(), 1, 1))
    end,
})

MainTab:CreateButton({
    Name = "Custom Icon Asset ID",
    Icon = 7733960981,
    Tooltip = "Icon bisa pakai asset ID number",
    Callback = function()
        Library:Notify("Button ini memakai custom asset ID icon", 3, "Icon", "image")
    end,
})

MainTab:CreateButton({
    Name = "Toggle UI",
    Icon = "power",
    Tooltip = "Buka/tutup window",
    Callback = function()
        Window:Toggle()
    end,
})

MainTab:CreateButton({
    Name = "Hide UI",
    Icon = "eye-off",
    Callback = function()
        Window:Toggle(false)
    end,
})

MainTab:CreateButton({
    Name = "Show UI",
    Icon = "eye",
    Callback = function()
        Window:Toggle(true)
    end,
})

MainTab:CreateButton({
    Name = "Show Info Card",
    Icon = "info",
    Callback = function()
        Window:SetInfoCard(true)
    end,
})

MainTab:CreateButton({
    Name = "Hide Info Card",
    Icon = "x-circle",
    Callback = function()
        Window:SetInfoCard(false)
    end,
})

MainTab:CreateButton({
    Name = "Toggle Keybind List",
    Icon = "key",
    Callback = function()
        Window:ToggleKeybindList()
    end,
})

MainTab:CreateButton({
    Name = "Update Label & Paragraph",
    Icon = "refresh-cw",
    Callback = function()
        StatusLabel:Set("Status: Updated at " .. os.date("%X"))

        GuideParagraph:Set({
            Title = "Updated",
            Content = "Paragraph ini diubah lewat button.",
        })

        Library:Notify("Label dan paragraph berhasil di-update", 3, "Action", "check")
    end,
})

-- =========================================================
-- 6. PLAYER TAB
-- Elemen: Toggle, Slider, Dropdown, Keybind, ColorPicker
-- =========================================================
PlayerTab:CreateSection("Combat")

local AimbotToggle = PlayerTab:CreateToggle({
    Name = "Aimbot",
    Icon = "crosshair",
    Default = false,
    Flag = "Aimbot",
    Tooltip = "Contoh toggle dengan flag",
    Callback = function(state)
        print("[ZethHub] Aimbot =", state)
    end,
})

-- Contoh mengubah toggle dari script
AimbotToggle:Set(true)

PlayerTab:CreateToggle({
    Name = "Triggerbot",
    Icon = "target",
    Default = false,
    Flag = "Triggerbot",
    Callback = function(state)
        print("[ZethHub] Triggerbot =", state)
    end,
})

local FOVSlider = PlayerTab:CreateSlider({
    Name = "FOV",
    Min = 1,
    Max = 360,
    Default = 90,
    Flag = "FOV",
    Icon = "target",
    Callback = function(value)
        print("[ZethHub] FOV =", value)
    end,
})

-- Contoh mengubah slider dari script
FOVSlider:Set(120)

PlayerTab:CreateSlider({
    Name = "Smoothness",
    Min = 1,
    Max = 20,
    Default = 5,
    Flag = "Smoothness",
    Icon = "sliders",
    Callback = function(value)
        print("[ZethHub] Smoothness =", value)
    end,
})

local HitPartDropdown = PlayerTab:CreateDropdown({
    Name = "Hitpart",
    Options = {"Head", "Torso", "HumanoidRootPart", "Random"},
    Default = "Head",
    Flag = "HitPart",
    Icon = "target",
    Callback = function(value)
        print("[ZethHub] Hitpart =", value)
    end,
})

-- Contoh refresh option dropdown
HitPartDropdown:Refresh({
    "Head",
    "Torso",
    "HumanoidRootPart",
    "LowerTorso",
    "Random",
})

PlayerTab:CreateDropdown({
    Name = "Target",
    Options = {"Nearest", "Lowest Health", "Visible"},
    Default = "Nearest",
    Flag = "Target",
    Icon = "users",
    Callback = function(value)
        print("[ZethHub] Target =", value)
    end,
})

local AimKeybind = PlayerTab:CreateKeybind({
    Name = "Aim Key",
    CurrentKeybind = Enum.KeyCode.Q,
    HoldToInteract = true,
    Flag = "AimKey",
    Icon = "key",
    Tooltip = "Hold keybind example",
    Callback = function(value)
        -- Kalau HoldToInteract = true, callback bisa menerima boolean true/false
        -- Kalau HoldToInteract = false, callback menerima KeyCode
        if value == true or value == false then
            print("[ZethHub] Aim key hold =", value)
        else
            print("[ZethHub] Aim key pressed =", value.Name)
        end
    end,
})

-- Contoh mengganti keybind dari script
AimKeybind:SetKey(Enum.KeyCode.E)

PlayerTab:CreateKeybind({
    Name = "Trigger Key",
    CurrentKeybind = Enum.KeyCode.T,
    HoldToInteract = false,
    Flag = "TriggerKey",
    Icon = "activity",
    Callback = function(value)
        if value == true or value == false then
            print("[ZethHub] Trigger key state =", value)
        else
            print("[ZethHub] Trigger key pressed =", value.Name)
        end
    end,
})

local ESPColorPicker = PlayerTab:CreateColorPicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(255, 60, 60),
    Flag = "ESPColor",
    Icon = "palette",
    Callback = function(color)
        print("[ZethHub] ESP color =", color)
    end,
})

-- Contoh mengubah color picker dari script
ESPColorPicker:Set(Color3.fromRGB(0, 255, 120))

-- =========================================================
-- 7. VISUAL TAB
-- Elemen tambahan: Toggle, Slider, Dropdown, ColorPicker, Button
-- =========================================================
VisualTab:CreateSection("Effects")

VisualTab:CreateToggle({
    Name = "ESP",
    Icon = "eye",
    Default = true,
    Flag = "ESP",
    Callback = function(state)
        print("[ZethHub] ESP =", state)
    end,
})

VisualTab:CreateToggle({
    Name = "Chams",
    Icon = "box",
    Default = false,
    Flag = "Chams",
    Callback = function(state)
        print("[ZethHub] Chams =", state)
    end,
})

VisualTab:CreateToggle({
    Name = "Tracers",
    Icon = "navigation",
    Default = false,
    Flag = "Tracers",
    Callback = function(state)
        print("[ZethHub] Tracers =", state)
    end,
})

VisualTab:CreateToggle({
    Name = "Fullbright",
    Icon = "sun",
    Default = false,
    Flag = "Fullbright",
    Callback = function(state)
        print("[ZethHub] Fullbright =", state)
    end,
})

VisualTab:CreateSlider({
    Name = "ESP Thickness",
    Min = 1,
    Max = 10,
    Default = 2,
    Flag = "ESPThickness",
    Icon = "pencil",
    Callback = function(value)
        print("[ZethHub] ESP thickness =", value)
    end,
})

VisualTab:CreateSlider({
    Name = "Chams Transparency",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "ChamsTransparency",
    Icon = "eye",
    Callback = function(value)
        print("[ZethHub] Chams transparency =", value)
    end,
})

VisualTab:CreateDropdown({
    Name = "ESP Style",
    Options = {"Box", "Corner", "Outline", "Skeleton"},
    Default = "Box",
    Flag = "ESPStyle",
    Icon = "grid",
    Callback = function(value)
        print("[ZethHub] ESP style =", value)
    end,
})

VisualTab:CreateColorPicker({
    Name = "Chams Color",
    Default = Color3.fromRGB(120, 0, 255),
    Flag = "ChamsColor",
    Icon = "palette",
    Callback = function(color)
        print("[ZethHub] Chams color =", color)
    end,
})

VisualTab:CreateButton({
    Name = "Apply Visual Settings",
    Icon = "check",
    Callback = function()
        Library:Notify("Visual settings applied", 3, "Visual", "check-circle")
    end,
})

-- =========================================================
-- 8. INPUT TAB
-- Elemen: Textbox, Input, Get/Set, Button
-- =========================================================
InputTab:CreateSection("Textbox")

local CommandTextbox = InputTab:CreateTextbox({
    Name = "Command",
    Placeholder = "Type command...",
    Icon = "terminal",
    Flag = "Command",
    Tooltip = "Textbox callback jalan setiap teks berubah",
    Callback = function(text)
        print("[ZethHub] Textbox =", text)
    end,
})

-- Contoh mengisi textbox dari script
CommandTextbox:Set("/example")

InputTab:CreateSection("Input")

local NameInput = InputTab:CreateInput({
    Name = "Username",
    CurrentValue = "Player",
    PlaceholderText = "Enter username",
    Icon = "user",
    Flag = "Username",
    Callback = function(text)
        print("[ZethHub] Input =", text)
    end,
})

-- Contoh mengisi input dari script
NameInput:Set("Exterminate0")

InputTab:CreateInput({
    Name = "Search Auto Clear",
    PlaceholderText = "Search...",
    Icon = "search",
    Flag = "Search",
    RemoveTextAfterFocusLost = true,
    Callback = function(text)
        print("[ZethHub] Search =", text)
    end,
})

InputTab:CreateButton({
    Name = "Print Username Input",
    Icon = "clipboard",
    Callback = function()
        local username = NameInput:Get()
        Library:Notify("Username: " .. tostring(username), 4, "Input", "user")
    end,
})

-- =========================================================
-- 9. SETTINGS TAB
-- Elemen: Toggle, ColorPicker, Dropdown, Button, Config Demo
-- =========================================================
SettingsTab:CreateSection("Interface")

SettingsTab:CreateToggle({
    Name = "Show Keybind List",
    Icon = "key",
    Default = true,
    Flag = "ShowKeybinds",
    Callback = function(state)
        Window:ToggleKeybindList(state)
    end,
})

SettingsTab:CreateToggle({
    Name = "Rainbow Border",
    Icon = "flame",
    Default = false,
    Flag = "Rainbow",
    Callback = function(state)
        Library:SetRainbow(state)
    end,
})

local AccentPicker = SettingsTab:CreateColorPicker({
    Name = "Accent Color",
    Default = Color3.fromRGB(130, 90, 255),
    Flag = "Accent",
    Icon = "palette",
    Callback = function(color)
        SetAppAccent(color)
    end,
})

SettingsTab:CreateDropdown({
    Name = "Accent Preset",
    Options = {"Purple", "Blue", "Green", "Red", "Yellow", "White"},
    Default = "Purple",
    Flag = "AccentPreset",
    Icon = "star",
    Callback = function(preset)
        local presets = {
            Purple = Color3.fromRGB(130, 90, 255),
            Blue = Color3.fromRGB(60, 140, 255),
            Green = Color3.fromRGB(60, 220, 120),
            Red = Color3.fromRGB(255, 70, 70),
            Yellow = Color3.fromRGB(255, 200, 60),
            White = Color3.fromRGB(255, 255, 255),
        }

        local color = presets[preset] or Color3.fromRGB(255, 255, 255)
        SetAppAccent(color)
        AccentPicker:Set(color)
    end,
})

SettingsTab:CreateSection("Actions")

SettingsTab:CreateButton({
    Name = "Save Config Demo",
    Icon = "download",
    Callback = function()
        Library:Notify("Config saved (demo only)", 3, "Settings", "check-circle")
    end,
})

SettingsTab:CreateButton({
    Name = "Load Config Demo",
    Icon = "upload",
    Callback = function()
        Library:Notify("Config loaded (demo only)", 3, "Settings", "refresh-cw")
    end,
})

SettingsTab:CreateButton({
    Name = "Reset Flags",
    Icon = "trash-2",
    Callback = function()
        if type(table.clear) == "function" then
            table.clear(Library.Flags)
        else
            for key in pairs(Library.Flags) do
                Library.Flags[key] = nil
            end
        end

        Library:Notify("Flags reset", 3, "Debug", "x-circle")
    end,
})

SettingsTab:CreateButton({
    Name = "Close Window",
    Icon = "x",
    Callback = function()
        Window:Destroy()
    end,
})

-- =========================================================
-- 10. DEBUG TAB
-- Elemen: Label live update, Flags, Notify examples
-- =========================================================
DebugTab:CreateSection("Live Info")

local AccentLabel = DebugTab:CreateLabel("Accent: loading...")
local FlagLabel = DebugTab:CreateLabel("Flags: 0")

Window:onAccent(function(color)
    AccentLabel:Set("Accent: " .. tostring(color))
end)

DebugTab:CreateButton({
    Name = "Print All Flags",
    Icon = "terminal",
    Callback = function()
        print("---- ZETHUB FLAGS ----")

        for key, value in pairs(Library.Flags) do
            print(key, value)
        end

        Library:Notify("Cek output/console untuk daftar flags", 4, "Debug", "info")
    end,
})

DebugTab:CreateButton({
    Name = "Get Flag: Aimbot",
    Icon = "help-circle",
    Callback = function()
        local state = Library:GetFlag("Aimbot")
        Library:Notify("Aimbot flag: " .. tostring(state), 4, "Debug", "info")
    end,
})

DebugTab:CreateButton({
    Name = "Notify Examples",
    Icon = "bell",
    Callback = function()
        Library:Notify("Ini notification info", 3, "Info", "info")
        task.wait(0.2)
        Library:Notify("Ini notification success", 3, "Success", "check-circle")
        task.wait(0.2)
        Library:Notify("Ini notification error", 3, "Error", "x-circle")
    end,
})

task.spawn(function()
    while Window and not Window._destroyed do
        task.wait(1)

        local count = 0
        for _ in pairs(Library.Flags) do
            count = count + 1
        end

        pcall(function()
            FlagLabel:Set("Flags: " .. count)
        end)
    end
end)

-- =========================================================
-- 11. FINAL MESSAGE
-- =========================================================
Library:Notify("Example script loaded successfully", 5, "ZethHub", "badge-check")
print("[ZethHub Example] Loaded successfully")
