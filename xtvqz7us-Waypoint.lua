local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============ CONFIG & DATA ============
local SAVE_FILE = "WaypointData_Zyx.json"
local waypoints = {}

local function loadWaypoints()
    if isfile and readfile and isfile(SAVE_FILE) then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(SAVE_FILE))
        end)
        if success and type(data) == "table" then
            waypoints = data
        end
    end
end

local function saveWaypoints()
    if writefile then
        pcall(function()
            writefile(SAVE_FILE, HttpService:JSONEncode(waypoints))
        end)
    end
end

loadWaypoints()

-- ============ UI CREATION ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WaypointSystemUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- Main Frame (Tinggi disesuaikan agar notifikasi muat di bawah)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 500) -- Diperbesar dari 480 ke 500
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(45, 45, 45)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Title & Subtitle
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 0, 28)
Title.Position = UDim2.new(0, 20, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "Waypoint Manager"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 300, 0, 16)
Subtitle.Position = UDim2.new(0, 20, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Save, manage, and move to your favorite locations"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 25)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(90, 45, 45)
CloseStroke.Thickness = 1
CloseStroke.Parent = CloseBtn

-- ============ INPUT SECTION ============
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(1, -40, 0, 36)
InputFrame.Position = UDim2.new(0, 20, 0, 70)
InputFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
InputFrame.BorderSizePixel = 0
InputFrame.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 7)
InputCorner.Parent = InputFrame

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(55, 55, 55)
InputStroke.Thickness = 1
InputStroke.Parent = InputFrame

-- FIX: Menambahkan "TextBox" pada Instance.new()
local NameInput = Instance.new("TextBox") 
NameInput.Size = UDim2.new(1, -90, 1, 0)
NameInput.Position = UDim2.new(0, 10, 0, 0)
NameInput.BackgroundTransparency = 1
NameInput.PlaceholderText = "Waypoint Name..."
NameInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
NameInput.TextColor3 = Color3.fromRGB(220, 220, 220)
NameInput.TextSize = 13
NameInput.Font = Enum.Font.Gotham
NameInput.TextXAlignment = Enum.TextXAlignment.Left
NameInput.Parent = InputFrame

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(0, 70, 1, -4)
SaveBtn.Position = UDim2.new(1, -75, 0, 2)
SaveBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 45)
SaveBtn.Text = "💾 Save"
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.TextSize = 12
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.BorderSizePixel = 0
SaveBtn.Parent = InputFrame

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 5)
SaveCorner.Parent = SaveBtn

-- ============ SEARCH SECTION ============
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -40, 0, 32)
SearchFrame.Position = UDim2.new(0, 20, 0, 115)
SearchFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = MainFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 7)
SearchCorner.Parent = SearchFrame

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = Color3.fromRGB(55, 55, 55)
SearchStroke.Thickness = 1
SearchStroke.Parent = SearchFrame

-- FIX: Icon search dibuat terpisah agar tidak hilang saat mengetik
local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 20, 1, 0)
SearchIcon.Position = UDim2.new(0, 8, 0, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Color3.fromRGB(120, 120, 120)
SearchIcon.TextSize = 14
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.Parent = SearchFrame

local SearchInput = Instance.new("TextBox")
SearchInput.Size = UDim2.new(1, -35, 1, 0) -- Disesuaikan agar tidak menabrak icon
SearchInput.Position = UDim2.new(0, 30, 0, 0) -- Geser ke kanan sedikit
SearchInput.BackgroundTransparency = 1
SearchInput.PlaceholderText = "Search Waypoint..." -- Emoji dihapus dari placeholder
SearchInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
SearchInput.TextColor3 = Color3.fromRGB(220, 220, 220)
SearchInput.TextSize = 12
SearchInput.Font = Enum.Font.Gotham
SearchInput.TextXAlignment = Enum.TextXAlignment.Left
SearchInput.Parent = SearchFrame

-- ============ LIST SECTION (Scroll) ============
local ListFrame = Instance.new("Frame")
ListFrame.Size = UDim2.new(1, -40, 0, 245) -- Diperbesar untuk mengisi ruang
ListFrame.Position = UDim2.new(0, 20, 0, 158)
ListFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
ListFrame.BorderSizePixel = 0
ListFrame.Parent = MainFrame

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 7)
ListCorner.Parent = ListFrame

local ListStroke = Instance.new("UIStroke")
ListStroke.Color = Color3.fromRGB(40, 40, 40)
ListStroke.Thickness = 1
ListStroke.Parent = ListFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -10)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
ScrollingFrame.Parent = ListFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

-- ============ SELECTED WAYPOINT DISPLAY ============
local SelectedFrame = Instance.new("Frame")
SelectedFrame.Size = UDim2.new(1, -40, 0, 36)
SelectedFrame.Position = UDim2.new(0, 20, 0, 413) -- Posisi disesuaikan
SelectedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SelectedFrame.BorderSizePixel = 0
SelectedFrame.Parent = MainFrame

local SelectedCorner = Instance.new("UICorner")
SelectedCorner.CornerRadius = UDim.new(0, 7)
SelectedCorner.Parent = SelectedFrame

local SelectedStroke = Instance.new("UIStroke")
SelectedStroke.Color = Color3.fromRGB(120, 60, 220)
SelectedStroke.Thickness = 1
SelectedStroke.Parent = SelectedFrame

local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Size = UDim2.new(1, -20, 1, 0)
SelectedLabel.Position = UDim2.new(0, 10, 0, 0)
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.Text = "Selected: None"
SelectedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SelectedLabel.TextSize = 13
SelectedLabel.Font = Enum.Font.GothamBold
SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
SelectedLabel.Parent = SelectedFrame

-- ============ ACTION BUTTONS ============
local ActionFrame = Instance.new("Frame")
ActionFrame.Size = UDim2.new(1, -40, 0, 36)
ActionFrame.Position = UDim2.new(0, 20, 0, 455) -- Posisi disesuaikan
ActionFrame.BackgroundTransparency = 1
ActionFrame.Parent = MainFrame

local GotoBtn = Instance.new("TextButton")
GotoBtn.Size = UDim2.new(0.32, 0, 1, 0)
GotoBtn.Position = UDim2.new(0, 0, 0, 0)
GotoBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
GotoBtn.Text = "🚀 Goto"
GotoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GotoBtn.TextSize = 12
GotoBtn.Font = Enum.Font.GothamBold
GotoBtn.BorderSizePixel = 0
GotoBtn.Parent = ActionFrame
Instance.new("UICorner", GotoBtn).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", GotoBtn).Color = Color3.fromRGB(60, 60, 60)

local TweenBtn = Instance.new("TextButton")
TweenBtn.Size = UDim2.new(0.32, 0, 1, 0)
TweenBtn.Position = UDim2.new(0.34, 0, 0, 0)
TweenBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
TweenBtn.Text = "🌊 Tween"
TweenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TweenBtn.TextSize = 12
TweenBtn.Font = Enum.Font.GothamBold
TweenBtn.BorderSizePixel = 0
TweenBtn.Parent = ActionFrame
Instance.new("UICorner", TweenBtn).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", TweenBtn).Color = Color3.fromRGB(60, 60, 60)

local WalkBtn = Instance.new("TextButton")
WalkBtn.Size = UDim2.new(0.32, 0, 1, 0)
WalkBtn.Position = UDim2.new(0.68, 0, 0, 0)
WalkBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
WalkBtn.Text = "🚶 Walk"
WalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkBtn.TextSize = 12
WalkBtn.Font = Enum.Font.GothamBold
WalkBtn.BorderSizePixel = 0
WalkBtn.Parent = ActionFrame
Instance.new("UICorner", WalkBtn).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", WalkBtn).Color = Color3.fromRGB(60, 60, 60)

-- ============ STATUS LABEL (NOTIFIKASI DI BAWAH UI) ============
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 16)
StatusLabel.Position = UDim2.new(0, 20, 1, -15) -- Posisi tepat di bawah tanpa menabrak tombol
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- ============ VARIABLES ============
local currentWaypoint = nil

-- ============ FUNCTIONS ============
local function showStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color or Color3.fromRGB(100, 255, 100)
    task.delay(2.5, function()
        if StatusLabel.Text == text then
            StatusLabel.Text = ""
        end
    end)
end

local function getHRP()
    return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

-- Render daftar waypoint
local function refreshList(filterText)
    filterText = string.lower(filterText or "")

    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local count = 0
    for name, data in pairs(waypoints) do
        if string.find(string.lower(name), filterText) then
            count += 1

            local ItemFrame = Instance.new("Frame")
            ItemFrame.Size = UDim2.new(1, -10, 0, 32)
            ItemFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ItemFrame.BorderSizePixel = 0
            ItemFrame.Parent = ScrollingFrame
            Instance.new("UICorner", ItemFrame).CornerRadius = UDim.new(0, 5)

            local NameLabel = Instance.new("TextLabel")
            NameLabel.Size = UDim2.new(1, -40, 1, 0)
            NameLabel.Position = UDim2.new(0, 8, 0, 0)
            NameLabel.BackgroundTransparency = 1
            NameLabel.Text = name
            NameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            NameLabel.TextSize = 12
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Parent = ItemFrame

            local DeleteBtn = Instance.new("TextButton")
            DeleteBtn.Size = UDim2.new(0, 28, 0, 28)
            DeleteBtn.Position = UDim2.new(1, -32, 0, 2)
            DeleteBtn.BackgroundColor3 = Color3.fromRGB(90, 30, 30)
            DeleteBtn.Text = "🗑️"
            DeleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            DeleteBtn.TextSize = 12
            DeleteBtn.Font = Enum.Font.GothamBold
            DeleteBtn.BorderSizePixel = 0
            DeleteBtn.Parent = ItemFrame
            Instance.new("UICorner", DeleteBtn).CornerRadius = UDim.new(0, 4)

            ItemFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    currentWaypoint = name
                    SelectedLabel.Text = "Selected: " .. name
                end
            end)

            DeleteBtn.MouseButton1Click:Connect(function()
                waypoints[name] = nil
                saveWaypoints()
                refreshList(SearchInput.Text)
                if currentWaypoint == name then
                    currentWaypoint = nil
                    SelectedLabel.Text = "Selected: None"
                end
            end)

            ItemFrame.MouseEnter:Connect(function()
                TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end)
            ItemFrame.MouseLeave:Connect(function()
                TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end)
        end
    end

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, count * 37 + 5)
end

-- ============ BUTTON CONNECTIONS ============
SaveBtn.MouseButton1Click:Connect(function()
    local name = string.gsub(NameInput.Text, "^%s*(.-)%s*$", "%1")
    if name == "" then
        return
    end

    local hrp = getHRP()
    if not hrp then
        return
    end

    waypoints[name] = {
        Position = {X = hrp.Position.X, Y = hrp.Position.Y, Z = hrp.Position.Z},
        Time = os.time()
    }
    saveWaypoints()
    NameInput.Text = ""
    refreshList(SearchInput.Text)
end)

SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
    refreshList(SearchInput.Text)
end)

GotoBtn.MouseButton1Click:Connect(function()
    if not currentWaypoint or not waypoints[currentWaypoint] then
        return
    end
    local hrp = getHRP()
    if not hrp then return end

    local pos = waypoints[currentWaypoint].Position
    hrp.CFrame = CFrame.new(Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(0, 3, 0))
end)

TweenBtn.MouseButton1Click:Connect(function()
    if not currentWaypoint or not waypoints[currentWaypoint] then
        return
    end
    local hrp = getHRP()
    if not hrp then return end

    local pos = waypoints[currentWaypoint].Position
    local targetCFrame = CFrame.new(Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(0, 3, 0))

    TweenService:Create(hrp, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = targetCFrame
    }):Play()
end)

WalkBtn.MouseButton1Click:Connect(function()
    if not currentWaypoint or not waypoints[currentWaypoint] then
        return
    end
    local hrp = getHRP()
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if not hrp or not humanoid then return end

    local pos = waypoints[currentWaypoint].Position
    humanoid:MoveTo(Vector3.new(pos.X, pos.Y, pos.Z))
end)

-- ============ ANIMATIONS & EFFECTS ============
local function destroyUI()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()

    for _, child in pairs(MainFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            pcall(function()
                TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1,
                    TextTransparency = 1,
                    ImageTransparency = 1
                }):Play()
            end)
        end
    end

    task.wait(0.4)
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
end

CloseBtn.MouseButton1Click:Connect(destroyUI)

local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
    end)
end

local function addClickEffect(button)
    button.MouseButton1Click:Connect(function()
        local originalSize = button.Size
        TweenService:Create(button, TweenInfo.new(0.08), {
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 4, originalSize.Y.Scale, originalSize.Y.Offset - 4)
        }):Play()
        task.wait(0.08)
        TweenService:Create(button, TweenInfo.new(0.08), {Size = originalSize}):Play()
    end)
end

addHoverEffect(SaveBtn, Color3.fromRGB(55, 120, 55), Color3.fromRGB(45, 100, 45))
addHoverEffect(CloseBtn, Color3.fromRGB(70, 35, 35), Color3.fromRGB(45, 25, 25))
addHoverEffect(GotoBtn, Color3.fromRGB(55, 55, 55), Color3.fromRGB(38, 38, 38))
addHoverEffect(TweenBtn, Color3.fromRGB(55, 55, 55), Color3.fromRGB(38, 38, 38))
addHoverEffect(WalkBtn, Color3.fromRGB(55, 55, 55), Color3.fromRGB(38, 38, 38))

local allButtons = {SaveBtn, CloseBtn, GotoBtn, TweenBtn, WalkBtn}
for _, btn in ipairs(allButtons) do
    addClickEffect(btn)
end

NameInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(120, 60, 220)}):Play()
end)
NameInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(55, 55, 55)}):Play()
end)

SearchInput.Focused:Connect(function()
    TweenService:Create(SearchStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(120, 60, 220)}):Play()
end)
SearchInput.FocusLost:Connect(function()
    TweenService:Create(SearchStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(55, 55, 55)}):Play()
end)

-- ============ DRAGGABLE SYSTEM ============
local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ============ ENTRANCE ANIMATION ============
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -290)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -210, 0.5, -250),
    BackgroundTransparency = 0
}):Play()

-- Initial Render
refreshList()
