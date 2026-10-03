local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

-- ============ HAPUS UI LAMA ============
for _, gui in ipairs(playerGui:GetChildren()) do
    if gui:IsA("ScreenGui") and gui.Name == "ZethubESPSystem" then
        gui:Destroy()
    end
end

-- ============ CONFIG ============
local espEnabled = false
local espObjects = {}
local espConnections = {}
local watchConnections = {}

-- ============ COLORS ============
local COLOR_MAIN_BG = Color3.fromRGB(10, 10, 14)
local COLOR_PANEL_BG = Color3.fromRGB(18, 18, 24)
local COLOR_PANEL_HOVER = Color3.fromRGB(28, 28, 36)
local COLOR_INPUT_BG = Color3.fromRGB(14, 14, 20)

local COLOR_TEXT = Color3.fromRGB(225, 225, 255)
local COLOR_TEXT_DIM = Color3.fromRGB(130, 130, 150)
local COLOR_TEXT_HINT = Color3.fromRGB(90, 90, 110)
local COLOR_WHITE = Color3.fromRGB(255, 255, 255)

local COLOR_GREEN = Color3.fromRGB(72, 220, 130)
local COLOR_RED = Color3.fromRGB(255, 85, 100)
local COLOR_ORANGE = Color3.fromRGB(255, 170, 70)

local COLOR_ESP_OUTLINE = Color3.fromRGB(0, 240, 220)
local COLOR_ESP_FILL = Color3.fromRGB(255, 40, 150)
local COLOR_ESP_NEAR = Color3.fromRGB(255, 80, 90)
local COLOR_ESP_MID = Color3.fromRGB(255, 215, 80)
local COLOR_ESP_FAR = Color3.fromRGB(90, 200, 255)

-- ============ SIZE ============
local BASE_WIDTH = 440
local BASE_HEIGHT = 420
local MINI_SIZE = 50

local OPEN_SIZE = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
local CLOSED_SIZE = UDim2.new(0, 0, 0, 0)

-- ============ UTILITIES ============
local function getSafeViewportSize()
    local ok, size = pcall(function() return ScreenGui.AbsoluteSize end)
    if ok and typeof(size) == "Vector2" and size.X > 0 and size.Y > 0 then
        return size
    end
    local cam = workspace.CurrentCamera
    if cam then
        local ok2, vp = pcall(function() return cam.ViewportSize end)
        if ok2 then return vp end
    end
    return Vector2.new(1280, 720)
end

local function clampNumber(v, min, max)
    return math.clamp(v, min, max)
end

local function trim(text)
    return (string.gsub(text or "", "^%s*(.-)%s*$", "%1"))
end

local function getTableCount(t)
    local c = 0
    for _ in pairs(t) do c = c + 1 end
    return c
end

-- ============ SMART PATH PARSER ============
local function normalizePath(inputPath)
    local path = trim(inputPath or "")
    if path == "" then return "" end
    
    path = path:gsub("%s+", "")
    path = path:gsub('game:GetService%(["\']%s*[Ww]orkspace%s*["\']%)', 'Workspace')
    path = path:gsub('^game%.[Ww]orkspace', 'Workspace')
    
    if path:sub(1, 9):lower() == "workspace" then
        path = "Workspace" .. path:sub(10)
    end
    
    return path
end

local function getPathObject(path)
    if not path or path == "" then return nil end
    
    local normalized = normalizePath(path)
    if normalized == "" then return nil end
    
    local parts = {}
    for part in string.gmatch(normalized, "[^.]+") do
        table.insert(parts, part)
    end
    
    local current = game
    for _, part in ipairs(parts) do
        local ok, found = pcall(function()
            return current:FindFirstChild(part)
        end)
        if ok and found then
            current = found
        else
            return nil
        end
    end
    
    return current
end

-- ============ MONSTER DETECTION ============
local function isMonsterCandidate(inst)
    if not inst then return false end
    
    if inst:IsA("Model") then
        if inst:FindFirstChildOfClass("Humanoid") then return true end
        if inst:FindFirstChild("HumanoidRootPart") then return true end
        if inst.PrimaryPart then return true end
    end
    
    if inst:IsA("BasePart") then
        local size = inst.Size
        if size.Magnitude > 2.5 then return true end
    end
    
    return false
end

local function getMonsterPosition(monster)
    if monster:IsA("BasePart") then
        return monster.Position
    end
    
    if monster:IsA("Model") then
        local hrp = monster:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:IsA("BasePart") then return hrp.Position end
        
        local primary = monster.PrimaryPart
        if primary then return primary.Position end
        
        local torso = monster:FindFirstChild("Torso") or monster:FindFirstChild("UpperTorso")
        if torso and torso:IsA("BasePart") then return torso.Position end
        
        for _, child in ipairs(monster:GetDescendants()) do
            if child:IsA("BasePart") then return child.Position end
        end
    end
    
    return nil
end

local function getMonsterHeight(monster)
    local pos = getMonsterPosition(monster)
    if not pos then return 3 end
    
    if monster:IsA("BasePart") then
        return monster.Size.Y
    end
    
    local minY, maxY = pos.Y, pos.Y
    for _, child in ipairs(monster:GetDescendants()) do
        if child:IsA("BasePart") then
            local top = child.Position.Y + child.Size.Y / 2
            local bottom = child.Position.Y - child.Size.Y / 2
            if top > maxY then maxY = top end
            if bottom < minY then minY = bottom end
        end
    end
    
    return math.max(maxY - minY, 2)
end

-- ============ SCREEN GUI ============
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZethubESPSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = playerGui

-- ============ MINI TOGGLE (DRAGGABLE) ============
local MiniToggle = Instance.new("TextButton")
MiniToggle.Name = "MiniToggle"
MiniToggle.Size = UDim2.new(0, MINI_SIZE, 0, MINI_SIZE)
MiniToggle.AnchorPoint = Vector2.new(0.5, 0.5)
MiniToggle.Position = UDim2.new(0, 40, 0.5, 0)
MiniToggle.BackgroundColor3 = COLOR_MAIN_BG
MiniToggle.BackgroundTransparency = 0.1
MiniToggle.Text = ""
MiniToggle.BorderSizePixel = 0
MiniToggle.AutoButtonColor = false
MiniToggle.Active = true
MiniToggle.ZIndex = 50
MiniToggle.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 12)
MiniCorner.Parent = MiniToggle

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = COLOR_ESP_OUTLINE
MiniStroke.Thickness = 2
MiniStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MiniStroke.Parent = MiniToggle

local IconEye = Instance.new("TextLabel")
IconEye.AnchorPoint = Vector2.new(0.5, 0.5)
IconEye.Position = UDim2.new(0.5, 0, 0.5, 0)
IconEye.Size = UDim2.new(1, 0, 1, 0)
IconEye.BackgroundTransparency = 1
IconEye.Text = "👁"
IconEye.TextSize = 24
IconEye.Font = Enum.Font.GothamMedium
IconEye.TextColor3 = COLOR_ESP_OUTLINE
IconEye.ZIndex = 51
IconEye.Parent = MiniToggle

local function clampMiniPos(centerX, centerY)
    local viewport = getSafeViewportSize()
    local halfX = MINI_SIZE / 2
    local halfY = MINI_SIZE / 2
    
    return UDim2.new(
        0, clampNumber(centerX, halfX + 4, math.max(halfX + 4, viewport.X - halfX - 4)),
        0, clampNumber(centerY, halfY + 4, math.max(halfY + 4, viewport.Y - halfY - 4))
    )
end

MiniToggle.Position = clampMiniPos(40, getSafeViewportSize().Y * 0.5)

-- ============ MAIN FRAME ============
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = CLOSED_SIZE
MainFrame.BackgroundColor3 = COLOR_MAIN_BG
MainFrame.BackgroundTransparency = 0.02
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.ZIndex = 40
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = COLOR_ESP_OUTLINE
MainStroke.Thickness = 1.8
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local MainScale = Instance.new("UIScale")
MainScale.Parent = MainFrame

local function updateResponsiveScale()
    local viewport = getSafeViewportSize()
    local scaleX = viewport.X / (BASE_WIDTH + 100)
    local scaleY = viewport.Y / (BASE_HEIGHT + 120)
    MainScale.Scale = clampNumber(math.min(scaleX, scaleY), 0.55, 1.15)
    
    MiniToggle.Position = clampMiniPos(
        MiniToggle.Position.X.Offset,
        MiniToggle.Position.Y.Offset
    )
end

updateResponsiveScale()

local cam = workspace.CurrentCamera
if cam then
    cam:GetPropertyChangedSignal("ViewportSize"):Connect(updateResponsiveScale)
end

-- ============ HEADER ============
local DragHandle = Instance.new("Frame")
DragHandle.Size = UDim2.new(1, -50, 0, 62)
DragHandle.BackgroundTransparency = 1
DragHandle.Active = true
DragHandle.ZIndex = 5
DragHandle.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 24)
Title.Position = UDim2.new(0, 20, 0, 14)
Title.BackgroundTransparency = 1
Title.Text = "ESP Monster V4"
Title.TextColor3 = COLOR_TEXT
Title.TextSize = 19
Title.Font = Enum.Font.GothamMedium
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 6
Title.Parent = DragHandle

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -20, 0, 15)
Subtitle.Position = UDim2.new(0, 20, 0, 38)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Smart monster tracker by Exterminate0"
Subtitle.TextColor3 = COLOR_TEXT_DIM
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.ZIndex = 6
Subtitle.Parent = DragHandle

local AccentLine = Instance.new("Frame")
AccentLine.Size = UDim2.new(1, -40, 0, 1.5)
AccentLine.Position = UDim2.new(0, 20, 0, 64)
AccentLine.BackgroundColor3 = COLOR_ESP_OUTLINE
AccentLine.BorderSizePixel = 0
AccentLine.ZIndex = 4
AccentLine.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -42, 0, 16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = COLOR_RED
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamMedium
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 7
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- ============ MONSTER ESP SECTION ============
local MonsterSection = Instance.new("Frame")
MonsterSection.Size = UDim2.new(1, -40, 0, 158)
MonsterSection.Position = UDim2.new(0, 20, 0, 76)
MonsterSection.BackgroundColor3 = COLOR_PANEL_BG
MonsterSection.BorderSizePixel = 0
MonsterSection.ZIndex = 4
MonsterSection.Parent = MainFrame

local MonsterCorner = Instance.new("UICorner")
MonsterCorner.CornerRadius = UDim.new(0, 10)
MonsterCorner.Parent = MonsterSection

local MonsterStroke = Instance.new("UIStroke")
MonsterStroke.Color = Color3.fromRGB(40, 40, 55)
MonsterStroke.Thickness = 1
MonsterStroke.Parent = MonsterSection

local MonsterLabel = Instance.new("TextLabel")
MonsterLabel.Size = UDim2.new(1, -24, 0, 16)
MonsterLabel.Position = UDim2.new(0, 12, 0, 10)
MonsterLabel.BackgroundTransparency = 1
MonsterLabel.Text = "👾 MONSTER ESP"
MonsterLabel.TextColor3 = COLOR_TEXT_DIM
MonsterLabel.TextSize = 10
MonsterLabel.Font = Enum.Font.GothamMedium
MonsterLabel.TextXAlignment = Enum.TextXAlignment.Left
MonsterLabel.ZIndex = 5
MonsterLabel.Parent = MonsterSection

-- Path Input
local PathInput = Instance.new("TextBox")
PathInput.Size = UDim2.new(1, -24, 0, 32)
PathInput.Position = UDim2.new(0, 12, 0, 32)
PathInput.BackgroundColor3 = COLOR_INPUT_BG
PathInput.BorderSizePixel = 0
PathInput.Text = ""
PathInput.PlaceholderText = ""
PathInput.PlaceholderColor3 = COLOR_TEXT_HINT
PathInput.TextColor3 = COLOR_WHITE
PathInput.TextSize = 12
PathInput.Font = Enum.Font.Code
PathInput.TextXAlignment = Enum.TextXAlignment.Left
PathInput.ClearTextOnFocus = false
PathInput.ZIndex = 5
PathInput.Parent = MonsterSection

local PathCorner = Instance.new("UICorner")
PathCorner.CornerRadius = UDim.new(0, 7)
PathCorner.Parent = PathInput

local PathStroke = Instance.new("UIStroke")
PathStroke.Color = Color3.fromRGB(70, 70, 95)
PathStroke.Thickness = 1
PathStroke.Parent = PathInput

PathInput.Focused:Connect(function()
    TweenService:Create(PathStroke, TweenInfo.new(0.2), {
        Color = COLOR_ESP_OUTLINE,
        Thickness = 1.5
    }):Play()
end)

PathInput.FocusLost:Connect(function(enterPressed)
    TweenService:Create(PathStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(70, 70, 95),
        Thickness = 1
    }):Play()
    if enterPressed then
        RefreshBtn.MouseButton1Click:Fire()
    end
end)

local PathHint = Instance.new("TextLabel")
PathHint.Size = UDim2.new(1, -24, 0, 12)
PathHint.Position = UDim2.new(0, 12, 0, 68)
PathHint.BackgroundTransparency = 1
PathHint.Text = "Support: Workspace · game.Workspace · GetService"
PathHint.TextColor3 = COLOR_TEXT_HINT
PathHint.TextSize = 9
PathHint.Font = Enum.Font.Gotham
PathHint.TextXAlignment = Enum.TextXAlignment.Left
PathHint.ZIndex = 5
PathHint.Parent = MonsterSection

-- Monster Controls Row (Toggle + Refresh)
local MonsterControlsRow = Instance.new("Frame")
MonsterControlsRow.Size = UDim2.new(1, -24, 0, 40)
MonsterControlsRow.Position = UDim2.new(0, 12, 0, 88)
MonsterControlsRow.BackgroundTransparency = 1
MonsterControlsRow.ZIndex = 5
MonsterControlsRow.Parent = MonsterSection

-- Toggle Container (kiri)
local ToggleContainer = Instance.new("Frame")
ToggleContainer.Size = UDim2.new(0.5, -4, 1, 0)
ToggleContainer.Position = UDim2.new(0, 0, 0, 0)
ToggleContainer.BackgroundColor3 = COLOR_INPUT_BG
ToggleContainer.BorderSizePixel = 0
ToggleContainer.ZIndex = 5
ToggleContainer.Parent = MonsterControlsRow

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleContainer

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = COLOR_RED
ToggleStroke.Thickness = 1
ToggleStroke.Parent = ToggleContainer

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""
ToggleBtn.AutoButtonColor = false
ToggleBtn.ZIndex = 6
ToggleBtn.Parent = ToggleContainer

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(1, -52, 1, 0)
ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Enable"
ToggleLabel.TextColor3 = COLOR_TEXT
ToggleLabel.TextSize = 12
ToggleLabel.Font = Enum.Font.GothamMedium
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.ZIndex = 6
ToggleLabel.Parent = ToggleContainer

-- Switch Track (pill shape)
local SwitchTrack = Instance.new("Frame")
SwitchTrack.Size = UDim2.new(0, 38, 0, 20)
SwitchTrack.Position = UDim2.new(1, -46, 0.5, -10)
SwitchTrack.BackgroundColor3 = Color3.fromRGB(60, 35, 40)
SwitchTrack.BorderSizePixel = 0
SwitchTrack.ZIndex = 6
SwitchTrack.Parent = ToggleContainer

local SwitchTrackCorner = Instance.new("UICorner")
SwitchTrackCorner.CornerRadius = UDim.new(0, 10)
SwitchTrackCorner.Parent = SwitchTrack

-- Switch Knob (circle)
local SwitchKnob = Instance.new("Frame")
SwitchKnob.Size = UDim2.new(0, 16, 0, 16)
SwitchKnob.Position = UDim2.new(0, 2, 0, 2)
SwitchKnob.BackgroundColor3 = COLOR_RED
SwitchKnob.BorderSizePixel = 0
SwitchKnob.ZIndex = 7
SwitchKnob.Parent = SwitchTrack

local SwitchKnobCorner = Instance.new("UICorner")
SwitchKnobCorner.CornerRadius = UDim.new(0, 8)
SwitchKnobCorner.Parent = SwitchKnob

local SwitchStatus = Instance.new("TextLabel")
SwitchStatus.Size = UDim2.new(0, 30, 0, 10)
SwitchStatus.Position = UDim2.new(0, 10, 1, 2)
SwitchStatus.BackgroundTransparency = 1
SwitchStatus.Text = ""
SwitchStatus.TextColor3 = COLOR_RED
SwitchStatus.TextSize = 9
SwitchStatus.Font = Enum.Font.GothamMedium
SwitchStatus.TextXAlignment = Enum.TextXAlignment.Left
SwitchStatus.ZIndex = 6
SwitchStatus.Parent = ToggleContainer

-- Refresh Button (kanan)
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0.5, -4, 1, 0)
RefreshBtn.Position = UDim2.new(0.5, 4, 0, 0)
RefreshBtn.BackgroundColor3 = COLOR_INPUT_BG
RefreshBtn.Text = ""
RefreshBtn.BorderSizePixel = 0
RefreshBtn.AutoButtonColor = false
RefreshBtn.ZIndex = 5
RefreshBtn.Parent = MonsterControlsRow

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 8)
RefreshCorner.Parent = RefreshBtn

local RefreshStroke = Instance.new("UIStroke")
RefreshStroke.Color = COLOR_ESP_OUTLINE
RefreshStroke.Thickness = 1
RefreshStroke.Transparency = 0.3
RefreshStroke.Parent = RefreshBtn

local RefreshIcon = Instance.new("TextLabel")
RefreshIcon.Size = UDim2.new(1, 0, 0, 18)
RefreshIcon.Position = UDim2.new(0, 0, 0, 4)
RefreshIcon.BackgroundTransparency = 1
RefreshIcon.Text = "🔁"
RefreshIcon.TextColor3 = COLOR_ESP_OUTLINE
RefreshIcon.TextSize = 18
RefreshIcon.Font = Enum.Font.GothamMedium
RefreshIcon.ZIndex = 6
RefreshIcon.Parent = RefreshBtn

local RefreshLabel = Instance.new("TextLabel")
RefreshLabel.Size = UDim2.new(1, 0, 0, 12)
RefreshLabel.Position = UDim2.new(0, 0, 0, 22)
RefreshLabel.BackgroundTransparency = 1
RefreshLabel.Text = "Refresh"
RefreshLabel.TextColor3 = COLOR_TEXT
RefreshLabel.TextSize = 10
RefreshLabel.Font = Enum.Font.Gotham
RefreshLabel.ZIndex = 6
RefreshLabel.Parent = RefreshBtn

-- ============ INFO SECTION ============
local InfoSection = Instance.new("Frame")
InfoSection.Size = UDim2.new(1, -40, 0, 128)
InfoSection.Position = UDim2.new(0, 20, 0, 244)
InfoSection.BackgroundColor3 = COLOR_PANEL_BG
InfoSection.BorderSizePixel = 0
InfoSection.ZIndex = 4
InfoSection.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 10)
InfoCorner.Parent = InfoSection

local InfoStroke = Instance.new("UIStroke")
InfoStroke.Color = Color3.fromRGB(40, 40, 55)
InfoStroke.Thickness = 1
InfoStroke.Parent = InfoSection

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -24, 0, 16)
InfoLabel.Position = UDim2.new(0, 12, 0, 10)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Information/Status"
InfoLabel.TextColor3 = COLOR_TEXT_DIM
InfoLabel.TextSize = 10
InfoLabel.Font = Enum.Font.GothamMedium
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.ZIndex = 5
InfoLabel.Parent = InfoSection

local function createInfoRow(labelText, yPos, valueText, valueColor)
    local rowLabel = Instance.new("TextLabel")
    rowLabel.Size = UDim2.new(0, 110, 0, 18)
    rowLabel.Position = UDim2.new(0, 12, 0, yPos)
    rowLabel.BackgroundTransparency = 1
    rowLabel.Text = labelText
    rowLabel.TextColor3 = COLOR_TEXT_DIM
    rowLabel.TextSize = 11
    rowLabel.Font = Enum.Font.Gotham
    rowLabel.TextXAlignment = Enum.TextXAlignment.Left
    rowLabel.ZIndex = 5
    rowLabel.Parent = InfoSection
    
    local rowValue = Instance.new("TextLabel")
    rowValue.Size = UDim2.new(1, -130, 0, 18)
    rowValue.Position = UDim2.new(0, 124, 0, yPos)
    rowValue.BackgroundTransparency = 1
    rowValue.Text = valueText
    rowValue.TextColor3 = valueColor or COLOR_TEXT
    rowValue.TextSize = 11
    rowValue.Font = Enum.Font.GothamMedium
    rowValue.TextXAlignment = Enum.TextXAlignment.Left
    rowValue.TextTruncate = Enum.TextTruncate.AtEnd
    rowValue.ZIndex = 5
    rowValue.Parent = InfoSection
    
    return rowValue
end

local EspStatusValue = createInfoRow("ESP Status", 32, "Disabled", COLOR_RED)
local MonsterCountValue = createInfoRow("Monsters", 54, "0", COLOR_TEXT)
local PathValue = createInfoRow("Path", 76, "Not set", COLOR_TEXT_HINT)
local TargetValue = createInfoRow("Target", 98, "-", COLOR_TEXT_DIM)

-- ============ STATUS LABEL ============
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 18)
StatusLabel.Position = UDim2.new(0, 20, 0, 384)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = COLOR_GREEN
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.ZIndex = 5
StatusLabel.Parent = MainFrame

-- ============ VARIABLES ============
local isOpen = false
local statusToken = 0
local hue = 0

-- ============ FUNCTIONS ============
local function showStatus(text, color)
    statusToken = statusToken + 1
    local token = statusToken
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color or COLOR_GREEN
    
    task.delay(3.5, function()
        if token == statusToken then
            StatusLabel.Text = ""
        end
    end)
end

local function getHRP()
    return lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
end

-- ============ MONSTER ESP CREATION ============
local function createESPForMonster(monster)
    if espObjects[monster] then
        return espObjects[monster]
    end
    
    local espData = {
        monster = monster,
        highlight = nil,
        billboard = nil,
        ancestryConn = nil,
        healthConn = nil,
    }
    
    -- HIGHLIGHT
    pcall(function()
        local highlight = Instance.new("Highlight")
        highlight.FillColor = COLOR_ESP_FILL
        highlight.OutlineColor = COLOR_ESP_OUTLINE
        highlight.FillTransparency = 0.65
        highlight.OutlineTransparency = 0
        highlight.Adornee = monster
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = monster
        espData.highlight = highlight
    end)
    
    -- BILLBOARD GUI
    local attachPart = nil
    if monster:IsA("BasePart") then
        attachPart = monster
    elseif monster:IsA("Model") then
        attachPart = monster:FindFirstChild("HumanoidRootPart") 
            or monster.PrimaryPart 
            or monster:FindFirstChild("Head")
            or monster:FindFirstChild("Torso")
        
        if not attachPart then
            for _, child in ipairs(monster:GetDescendants()) do
                if child:IsA("BasePart") then
                    attachPart = child
                    break
                end
            end
        end
    end
    
    if attachPart then
        local height = getMonsterHeight(monster)
        
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 180, 0, 52)
        billboard.StudsOffset = Vector3.new(0, height / 2 + 1.5, 0)
        billboard.AlwaysOnTop = true
        billboard.LightInfluence = 0
        billboard.ResetOnSpawn = false
        billboard.Adornee = attachPart
        billboard.Parent = monster
        espData.billboard = billboard
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 22)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = monster.Name
        nameLabel.TextColor3 = COLOR_WHITE
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.TextStrokeTransparency = 0.2
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamMedium
        nameLabel.Parent = billboard
        espData.nameLabel = nameLabel
        
        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Size = UDim2.new(1, 0, 0, 16)
        distanceLabel.Position = UDim2.new(0, 0, 0, 22)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = "..."
        distanceLabel.TextColor3 = COLOR_ESP_FAR
        distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distanceLabel.TextStrokeTransparency = 0.2
        distanceLabel.TextSize = 11
        distanceLabel.Font = Enum.Font.GothamMedium
        distanceLabel.Parent = billboard
        espData.distanceLabel = distanceLabel
        
        -- HEALTH BAR
        local humanoid = monster:IsA("Model") and monster:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local healthBar = Instance.new("Frame")
            healthBar.Size = UDim2.new(0.7, 0, 0, 5)
            healthBar.Position = UDim2.new(0.15, 0, 0, 40)
            healthBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
            healthBar.BorderSizePixel = 0
            healthBar.Parent = billboard
            
            local hbCorner = Instance.new("UICorner")
            hbCorner.CornerRadius = UDim.new(0, 3)
            hbCorner.Parent = healthBar
            
            local healthFill = Instance.new("Frame")
            healthFill.Size = UDim2.new(math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1), 0, 1, 0)
            healthFill.BackgroundColor3 = COLOR_GREEN
            healthFill.BorderSizePixel = 0
            healthFill.Parent = healthBar
            
            local hfCorner = Instance.new("UICorner")
            hfCorner.CornerRadius = UDim.new(0, 3)
            hfCorner.Parent = healthFill
            
            espData.healthBar = healthBar
            espData.healthFill = healthFill
            
            espData.healthConn = humanoid.HealthChanged:Connect(function(newHealth)
                if espData.healthFill and humanoid.MaxHealth > 0 then
                    local ratio = math.clamp(newHealth / humanoid.MaxHealth, 0, 1)
                    espData.healthFill.Size = UDim2.new(ratio, 0, 1, 0)
                    
                    if ratio > 0.6 then
                        espData.healthFill.BackgroundColor3 = COLOR_GREEN
                    elseif ratio > 0.3 then
                        espData.healthFill.BackgroundColor3 = COLOR_ORANGE
                    else
                        espData.healthFill.BackgroundColor3 = COLOR_RED
                    end
                end
            end)
        end
    end
    
    -- Track removal
    espData.ancestryConn = monster.AncestryChanged:Connect(function()
        if not monster.Parent and espObjects[monster] then
            destroyESPForMonster(espObjects[monster])
            espObjects[monster] = nil
        end
    end)
    
    espObjects[monster] = espData
    return espData
end

function destroyESPForMonster(espData)
    if not espData then return end
    if espData.highlight then pcall(function() espData.highlight:Destroy() end) end
    if espData.billboard then pcall(function() espData.billboard:Destroy() end) end
    if espData.healthConn then pcall(function() espData.healthConn:Disconnect() end) end
    if espData.ancestryConn then pcall(function() espData.ancestryConn:Disconnect() end) end
end

local function clearAllESP()
    for _, espData in pairs(espObjects) do
        destroyESPForMonster(espData)
    end
    espObjects = {}
    
    for _, conn in ipairs(espConnections) do
        pcall(function() conn:Disconnect() end)
    end
    espConnections = {}
    
    for _, conn in ipairs(watchConnections) do
        pcall(function() conn:Disconnect() end)
    end
    watchConnections = {}
end

-- ============ SCAN & WATCH ============
local function scanAndApplyESP(rootObject)
    local foundMonsters = {}
    
    if isMonsterCandidate(rootObject) then
        foundMonsters[rootObject] = true
    end
    
    local function scanContainer(container, depth)
        depth = depth or 0
        if depth > 8 then return end
        
        for _, child in ipairs(container:GetChildren()) do
            if isMonsterCandidate(child) then
                foundMonsters[child] = true
            elseif child:IsA("Model") or child:IsA("Folder") then
                scanContainer(child, depth + 1)
            end
        end
    end
    
    if rootObject:IsA("Model") or rootObject:IsA("Folder") then
        scanContainer(rootObject, 0)
    end
    
    for monster, _ in pairs(foundMonsters) do
        createESPForMonster(monster)
    end
    
    local c = 0
    for _ in pairs(foundMonsters) do c = c + 1 end
    return c
end

local function setupAutoWatch(rootObject)
    local function watchContainer(container, depth)
        if depth > 5 then return end
        
        local conn = container.ChildAdded:Connect(function(child)
            if not espEnabled then return end
            
            task.delay(0.5, function()
                if not espEnabled or not child.Parent then return end
                
                if isMonsterCandidate(child) then
                    createESPForMonster(child)
                    MonsterCountValue.Text = tostring(getTableCount(espObjects))
                elseif child:IsA("Model") or child:IsA("Folder") then
                    watchContainer(child, depth + 1)
                    task.delay(0.3, function()
                        if espEnabled and child.Parent then
                            scanAndApplyESP(child)
                            MonsterCountValue.Text = tostring(getTableCount(espObjects))
                        end
                    end)
                end
            end)
        end)
        
        table.insert(watchConnections, conn)
        
        for _, child in ipairs(container:GetChildren()) do
            if (child:IsA("Model") or child:IsA("Folder")) and not isMonsterCandidate(child) then
                watchContainer(child, depth + 1)
            end
        end
    end
    
    if rootObject:IsA("Model") or rootObject:IsA("Folder") then
        watchContainer(rootObject, 0)
    end
end

-- ============ REFRESH ESP ============
local function refreshESP()
    clearAllESP()
    
    if not espEnabled then
        EspStatusValue.Text = "Disabled"
        EspStatusValue.TextColor3 = COLOR_RED
        MonsterCountValue.Text = "0"
        TargetValue.Text = "-"
        return
    end
    
    local rawPath = trim(PathInput.Text)
    
    if rawPath == "" then
        EspStatusValue.Text = "Path Empty"
        EspStatusValue.TextColor3 = COLOR_ORANGE
        return
    end
    
    local normalizedPath = normalizePath(rawPath)
    local targetObject = getPathObject(rawPath)
    
    if not targetObject then
        EspStatusValue.Text = "Invalid Path"
        EspStatusValue.TextColor3 = COLOR_RED
        PathValue.Text = normalizedPath
        PathValue.TextColor3 = COLOR_RED
        MonsterCountValue.Text = "0"
        TargetValue.Text = "-"
        return
    end
    
    PathValue.Text = normalizedPath
    PathValue.TextColor3 = COLOR_GREEN
    TargetValue.Text = targetObject.ClassName .. ": " .. targetObject.Name
    TargetValue.TextColor3 = COLOR_TEXT
    
    EspStatusValue.Text = "Scanning..."
    EspStatusValue.TextColor3 = COLOR_ORANGE
    
    local monsterCount = scanAndApplyESP(targetObject)
    setupAutoWatch(targetObject)
    
    MonsterCountValue.Text = tostring(monsterCount)
    
    if monsterCount > 0 then
        EspStatusValue.Text = "Active"
        EspStatusValue.TextColor3 = COLOR_GREEN
    else
        EspStatusValue.Text = "No Monsters"
        EspStatusValue.TextColor3 = COLOR_ORANGE
    end
    
    -- Update distance loop
    local updateConn = RunService.RenderStepped:Connect(function()
        if not espEnabled then return end
        
        local hrp = getHRP()
        if not hrp then return end
        
        for monster, espData in pairs(espObjects) do
            if monster and monster.Parent and espData.distanceLabel then
                local monsterPos = getMonsterPosition(monster)
                if monsterPos then
                    local distance = (hrp.Position - monsterPos).Magnitude
                    espData.distanceLabel.Text = string.format("%.0f studs", distance)
                    
                    if distance < 50 then
                        espData.distanceLabel.TextColor3 = COLOR_ESP_NEAR
                    elseif distance < 150 then
                        espData.distanceLabel.TextColor3 = COLOR_ESP_MID
                    else
                        espData.distanceLabel.TextColor3 = COLOR_ESP_FAR
                    end
                end
            end
        end
    end)
    
    table.insert(espConnections, updateConn)
end

-- ============ TOGGLE ESP ============
local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        TweenService:Create(SwitchKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 20, 0, 2),
            BackgroundColor3 = COLOR_GREEN
        }):Play()
        TweenService:Create(SwitchTrack, TweenInfo.new(0.25), {
            BackgroundColor3 = Color3.fromRGB(25, 60, 40)
        }):Play()
        TweenService:Create(ToggleStroke, TweenInfo.new(0.25), {
            Color = COLOR_GREEN
        }):Play()
        
        SwitchStatus.Text = ""
        SwitchStatus.TextColor3 = COLOR_GREEN
        
        
        if trim(PathInput.Text) ~= "" then
            task.delay(0.3, refreshESP)
        else
            EspStatusValue.Text = "Enabled (no path)"
            EspStatusValue.TextColor3 = COLOR_ORANGE
        end
    else
        TweenService:Create(SwitchKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 2, 0, 2),
            BackgroundColor3 = COLOR_RED
        }):Play()
        TweenService:Create(SwitchTrack, TweenInfo.new(0.25), {
            BackgroundColor3 = Color3.fromRGB(60, 35, 40)
        }):Play()
        TweenService:Create(ToggleStroke, TweenInfo.new(0.25), {
            Color = COLOR_RED
        }):Play()
        
        SwitchStatus.Text = ""
        SwitchStatus.TextColor3 = COLOR_RED
        
        clearAllESP()
        EspStatusValue.Text = "Disabled"
        EspStatusValue.TextColor3 = COLOR_RED
        MonsterCountValue.Text = "0"
        TargetValue.Text = "-"
    end
end

-- ============ OPEN/CLOSE ============
local function setOpen(state)
    if state == isOpen then return end
    isOpen = state
    
    if state then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = OPEN_SIZE
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = CLOSED_SIZE
        }):Play()
        task.delay(0.3, function()
            if not isOpen then MainFrame.Visible = false end
        end)
    end
end

-- ============ CONNECTIONS ============
CloseBtn.MouseButton1Click:Connect(function()
    setOpen(false)
end)

-- ⚠️ FIX: HAPUS MiniToggle.MouseButton1Click karena bentrok dengan drag system
-- Drag system (InputBegan + InputEnded) sudah handle click-to-toggle via miniMoved check
-- Jadi hapus baris ini agar tidak dipanggil dua kali dalam satu klik!

ToggleBtn.MouseButton1Click:Connect(toggleESP)
RefreshBtn.MouseButton1Click:Connect(refreshESP)

-- Hover effects
local function addHover(btn, hoverColor, normalColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
    end)
end

addHover(CloseBtn, Color3.fromRGB(60, 35, 40), Color3.fromRGB(40, 25, 30))
addHover(ToggleContainer, COLOR_PANEL_HOVER, COLOR_INPUT_BG)
addHover(RefreshBtn, COLOR_PANEL_HOVER, COLOR_INPUT_BG)

-- Click effect
local function addClickEffect(btn)
    btn.MouseButton1Click:Connect(function()
        local orig = btn.Size
        TweenService:Create(btn, TweenInfo.new(0.06), {
            Size = UDim2.new(orig.X.Scale, orig.X.Offset - 2, orig.Y.Scale, orig.Y.Offset - 2)
        }):Play()
        task.delay(0.06, function()
            TweenService:Create(btn, TweenInfo.new(0.06), {Size = orig}):Play()
        end)
    end)
end

addClickEffect(CloseBtn)
addClickEffect(RefreshBtn)

-- ============ RGB ANIMATION (STROKE ONLY) ============
RunService.RenderStepped:Connect(function(dt)
    hue = (hue + dt * 0.2) % 1
    local rgb = Color3.fromHSV(hue, 0.85, 1)
    
    MainStroke.Color = rgb
    MiniStroke.Color = rgb
    AccentLine.BackgroundColor3 = rgb
end)

-- ============ DRAG SYSTEM ============
local draggingTarget = nil
local dragStart = nil
local dragStartPos = nil
local miniMoved = false
local DRAG_THRESHOLD = 6

local function isPress(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
end

local function isMove(input)
    return input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
end

DragHandle.InputBegan:Connect(function(input)
    if isPress(input) and not draggingTarget then
        draggingTarget = "main"
        dragStart = input.Position
        dragStartPos = MainFrame.Position
    end
end)

MiniToggle.InputBegan:Connect(function(input)
    if isPress(input) and not draggingTarget then
        draggingTarget = "mini"
        miniMoved = false
        dragStart = input.Position
        dragStartPos = MiniToggle.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not isMove(input) or not draggingTarget then return end
    
    if draggingTarget == "main" then
        local delta = input.Position - dragStart
        local scale = math.max(MainScale.Scale, 0.1)
        MainFrame.Position = UDim2.new(
            dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X / scale,
            dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y / scale
        )
    elseif draggingTarget == "mini" then
        local delta = input.Position - dragStart
        if math.abs(delta.X) + math.abs(delta.Y) > DRAG_THRESHOLD then
            miniMoved = true
        end
        MiniToggle.Position = clampMiniPos(
            dragStartPos.X.Offset + delta.X,
            dragStartPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not isPress(input) then return end
    
    -- ✅ FIX: Hanya trigger setOpen jika ini KLIK (bukan drag) pada mini toggle
    if draggingTarget == "mini" and not miniMoved then
        setOpen(not isOpen)
    end
    
    draggingTarget = nil
    miniMoved = false
end)

-- ============ CLEANUP ============
ScreenGui.Destroying:Connect(function()
    clearAllESP()
end)

-- ============ INIT ============
setOpen(true)
