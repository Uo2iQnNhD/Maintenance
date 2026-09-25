-- LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============ HAPUS UI LAMA JIKA ADA ============
for _, gui in ipairs(playerGui:GetChildren()) do
	if gui:IsA("ScreenGui") and gui.Name == "WaypointSystemUI" then
		gui:Destroy()
	end
end

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

			local invalidNames = {}

			for name, info in pairs(waypoints) do
				if type(info) ~= "table" or type(info.Position) ~= "table" then
					table.insert(invalidNames, name)
				end
			end

			for _, name in ipairs(invalidNames) do
				waypoints[name] = nil
			end
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

-- ============ UTIL ============
local function clampNumber(value, minValue, maxValue)
	if value < minValue then
		return minValue
	elseif value > maxValue then
		return maxValue
	end
	return value
end

local function trim(text)
	return (string.gsub(text or "", "^%s*(.-)%s*$", "%1"))
end

local function getViewportSize()
	local cam = workspace.CurrentCamera
	if cam then
		local ok, size = pcall(function()
			return cam.ViewportSize
		end)

		if ok and typeof(size) == "Vector2" then
			return size
		end
	end

	return Vector2.new(1280, 720)
end

-- ============ COLORS ============
local COLOR_MAIN_BG = Color3.fromRGB(18, 18, 18)
local COLOR_PANEL_BG = Color3.fromRGB(25, 25, 25)
local COLOR_LIST_BG = Color3.fromRGB(22, 22, 22)

local COLOR_ITEM_NORMAL = Color3.fromRGB(35, 35, 35)
local COLOR_ITEM_HOVER = Color3.fromRGB(48, 48, 48)
local COLOR_ITEM_SELECTED = Color3.fromRGB(0, 92, 38)

local COLOR_ITEM_NORMAL_STROKE = Color3.fromRGB(55, 55, 55)
local COLOR_ITEM_SELECTED_STROKE = Color3.fromRGB(0, 255, 120)

local COLOR_TEXT = Color3.fromRGB(220, 220, 220)
local COLOR_TEXT_SELECTED = Color3.fromRGB(225, 255, 235)

local COLOR_GREEN = Color3.fromRGB(100, 255, 100)
local COLOR_RED = Color3.fromRGB(255, 90, 90)
local COLOR_ORANGE = Color3.fromRGB(255, 180, 80)

local COLOR_EDIT_NORMAL = Color3.fromRGB(35, 65, 95)
local COLOR_EDIT_HOVER = Color3.fromRGB(45, 85, 125)

local COLOR_DELETE_NORMAL = Color3.fromRGB(90, 30, 30)
local COLOR_DELETE_HOVER = Color3.fromRGB(120, 40, 40)

local COLOR_ICON = Color3.fromRGB(255, 255, 255)

-- Ukuran dasar UI. Nanti di-scale otomatis untuk mobile.
local BASE_WIDTH = 420
local BASE_HEIGHT = 480

local OPEN_SIZE = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
local CLOSED_SIZE = UDim2.new(0, 0, 0, 0)

-- ============ SCREEN GUI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WaypointSystemUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true -- PENTING: biar koordinat drag = layar penuh (batas hilang)
ScreenGui.DisplayOrder = 9999   -- PENTING: biar tidak tertimpa script lain
ScreenGui.Parent = playerGui

local function getSafeViewportSize()
	local ok, size = pcall(function()
		return ScreenGui.AbsoluteSize
	end)

	if ok and typeof(size) == "Vector2" and size.X > 0 and size.Y > 0 then
		return size
	end

	return getViewportSize()
end

-- ============ MINI SHOW/HIDE BUTTON ============
local MiniToggle = Instance.new("TextButton")
MiniToggle.Name = "MiniToggle"
MiniToggle.Size = UDim2.new(0, 54, 0, 54)
MiniToggle.AnchorPoint = Vector2.new(0.5, 0.5)
MiniToggle.Position = UDim2.new(0, 42, 0, 360)
MiniToggle.BackgroundColor3 = COLOR_MAIN_BG
MiniToggle.BackgroundTransparency = 0
MiniToggle.Text = "" -- teks dihapus, diganti ikon gambar
MiniToggle.BorderSizePixel = 0
MiniToggle.AutoButtonColor = false
MiniToggle.Active = true
MiniToggle.Visible = true
MiniToggle.ZIndex = 50
MiniToggle.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 10)
MiniCorner.Parent = MiniToggle

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Color3.fromRGB(255, 0, 0)
MiniStroke.Thickness = 2
MiniStroke.Transparency = 0
MiniStroke.Parent = MiniToggle

-- Helper: buat satu garis ikon
local function makeIconLine(parent, width, height, rotation, yOffset)
	local line = Instance.new("Frame")
	line.AnchorPoint = Vector2.new(0.5, 0.5)
	line.Position = UDim2.new(0.5, 0, 0.5, yOffset or 0)
	line.Size = UDim2.new(0, width, 0, height)
	line.Rotation = rotation or 0
	line.BackgroundColor3 = COLOR_ICON
	line.BorderSizePixel = 0
	line.Active = false
	line.ZIndex = 52
	line.Parent = parent
	return line
end

-- Container ikon MENU (hamburger) -> tampil saat closed
local IconMenu = Instance.new("Frame")
IconMenu.Name = "IconMenu"
IconMenu.AnchorPoint = Vector2.new(0.5, 0.5)
IconMenu.Position = UDim2.new(0.5, 0, 0.5, 0)
IconMenu.Size = UDim2.new(1, 0, 1, 0)
IconMenu.BackgroundTransparency = 1
IconMenu.BorderSizePixel = 0
IconMenu.Active = false
IconMenu.ZIndex = 51
IconMenu.Visible = true
IconMenu.Parent = MiniToggle

makeIconLine(IconMenu, 26, 3, 0, -9)
makeIconLine(IconMenu, 26, 3, 0, 0)
makeIconLine(IconMenu, 26, 3, 0, 9)

-- Container ikon CLOSE (X) -> tampil saat open
local IconClose = Instance.new("Frame")
IconClose.Name = "IconClose"
IconClose.AnchorPoint = Vector2.new(0.5, 0.5)
IconClose.Position = UDim2.new(0.5, 0, 0.5, 0)
IconClose.Size = UDim2.new(1, 0, 1, 0)
IconClose.BackgroundTransparency = 1
IconClose.BorderSizePixel = 0
IconClose.Active = false
IconClose.ZIndex = 51
IconClose.Visible = false
IconClose.Parent = MiniToggle

makeIconLine(IconClose, 28, 3, 45, 0)
makeIconLine(IconClose, 28, 3, -45, 0)

-- Clamp posisi CENTER mini box ke tepi layar sejati (bebas, tapi tidak hilang)
local function clampMiniCenterPos(centerX, centerY)
	local viewport = getSafeViewportSize()

	local sizeX = MiniToggle.AbsoluteSize.X
	local sizeY = MiniToggle.AbsoluteSize.Y

	if sizeX <= 0 then
		sizeX = MiniToggle.Size.X.Offset
	end

	if sizeY <= 0 then
		sizeY = MiniToggle.Size.Y.Offset
	end

	local halfX = sizeX / 2
	local halfY = sizeY / 2

	local minX = halfX
	local maxX = math.max(minX, viewport.X - halfX)

	local minY = halfY
	local maxY = math.max(minY, viewport.Y - halfY)

	return UDim2.new(
		0,
		clampNumber(centerX, minX, maxX),
		0,
		clampNumber(centerY, minY, maxY)
	)
end

-- Posisi awal mini box
MiniToggle.Position = clampMiniCenterPos(42, getSafeViewportSize().Y * 0.5)

-- ============ MAIN FRAME ============
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = CLOSED_SIZE
MainFrame.BackgroundColor3 = COLOR_MAIN_BG
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Active = false
MainFrame.ZIndex = 40
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 0, 0)
MainStroke.Thickness = 2
MainStroke.Transparency = 0
MainStroke.Parent = MainFrame

-- Responsive scale untuk mobile
local MainScale = Instance.new("UIScale")
MainScale.Parent = MainFrame

local function updateResponsiveScale()
	local viewport = getSafeViewportSize()

	local scaleX = viewport.X / (BASE_WIDTH + 80)
	local scaleY = viewport.Y / (BASE_HEIGHT + 100)
	local newScale = clampNumber(math.min(scaleX, scaleY), 0.5, 1)

	MainScale.Scale = newScale

	-- Jaga mini box tetap di dalam layar saat resize
	MiniToggle.Position = clampMiniCenterPos(
		MiniToggle.Position.X.Offset,
		MiniToggle.Position.Y.Offset
	)
end

updateResponsiveScale()

local cam = workspace.CurrentCamera
if cam then
	cam:GetPropertyChangedSignal("ViewportSize"):Connect(updateResponsiveScale)
end

pcall(function()
	ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateResponsiveScale)
end)

-- ============ DRAG HANDLE ============
local DragHandle = Instance.new("Frame")
DragHandle.Name = "DragHandle"
DragHandle.Size = UDim2.new(1, -58, 0, 58)
DragHandle.BackgroundTransparency = 1
DragHandle.Active = true
DragHandle.ZIndex = 3
DragHandle.Parent = MainFrame

-- Title & Subtitle
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 26)
Title.Position = UDim2.new(0, 20, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "Waypoint Manager"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Active = false
Title.ZIndex = 4
Title.Parent = DragHandle

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -20, 0, 16)
Subtitle.Position = UDim2.new(0, 20, 0, 36)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Save, manage, and move to your favorite locations"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Active = false
Subtitle.ZIndex = 4
Subtitle.Parent = DragHandle

-- RGB Accent Line
local AccentLine = Instance.new("Frame")
AccentLine.Size = UDim2.new(1, -40, 0, 2)
AccentLine.Position = UDim2.new(0, 20, 0, 62)
AccentLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
AccentLine.BorderSizePixel = 0
AccentLine.Active = false
AccentLine.ZIndex = 3
AccentLine.Parent = MainFrame

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 25)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false
CloseBtn.Active = true
CloseBtn.ZIndex = 5
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(90, 45, 45)
CloseStroke.Thickness = 1
CloseStroke.Parent = CloseBtn

-- ============ SAVE SECTION ============
local SaveFrame = Instance.new("Frame")
SaveFrame.Size = UDim2.new(1, -40, 0, 38)
SaveFrame.Position = UDim2.new(0, 20, 0, 68)
SaveFrame.BackgroundColor3 = COLOR_PANEL_BG
SaveFrame.BorderSizePixel = 0
SaveFrame.Active = false
SaveFrame.ZIndex = 3
SaveFrame.Parent = MainFrame

local SaveFrameCorner = Instance.new("UICorner")
SaveFrameCorner.CornerRadius = UDim.new(0, 8)
SaveFrameCorner.Parent = SaveFrame

local SaveFrameStroke = Instance.new("UIStroke")
SaveFrameStroke.Color = COLOR_ITEM_NORMAL_STROKE
SaveFrameStroke.Thickness = 1
SaveFrameStroke.Parent = SaveFrame

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1, -4, 1, -4)
SaveBtn.Position = UDim2.new(0, 2, 0, 2)
SaveBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 45)
SaveBtn.Text = "SAVE POSITION"
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.TextSize = 13
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.BorderSizePixel = 0
SaveBtn.AutoButtonColor = false
SaveBtn.Active = true
SaveBtn.ZIndex = 4
SaveBtn.Parent = SaveFrame

local SaveBtnCorner = Instance.new("UICorner")
SaveBtnCorner.CornerRadius = UDim.new(0, 6)
SaveBtnCorner.Parent = SaveBtn

-- ============ LIST SECTION ============
local ListFrame = Instance.new("Frame")
ListFrame.Size = UDim2.new(1, -40, 0, 238)
ListFrame.Position = UDim2.new(0, 20, 0, 116)
ListFrame.BackgroundColor3 = COLOR_LIST_BG
ListFrame.BorderSizePixel = 0
ListFrame.Active = false
ListFrame.ZIndex = 3
ListFrame.Parent = MainFrame

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
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
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ScrollingFrame.Active = true
ScrollingFrame.ZIndex = 4
ScrollingFrame.Parent = ListFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

-- ============ SELECTED WAYPOINT DISPLAY ============
local SelectedFrame = Instance.new("Frame")
SelectedFrame.Size = UDim2.new(1, -40, 0, 34)
SelectedFrame.Position = UDim2.new(0, 20, 0, 364)
SelectedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SelectedFrame.BorderSizePixel = 0
SelectedFrame.Active = false
SelectedFrame.ZIndex = 3
SelectedFrame.Parent = MainFrame

local SelectedCorner = Instance.new("UICorner")
SelectedCorner.CornerRadius = UDim.new(0, 8)
SelectedCorner.Parent = SelectedFrame

local SelectedStroke = Instance.new("UIStroke")
SelectedStroke.Color = Color3.fromRGB(120, 60, 220)
SelectedStroke.Thickness = 1.5
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
SelectedLabel.Active = false
SelectedLabel.ZIndex = 4
SelectedLabel.Parent = SelectedFrame

-- ============ ACTION BUTTONS ============
local ActionFrame = Instance.new("Frame")
ActionFrame.Size = UDim2.new(1, -40, 0, 36)
ActionFrame.Position = UDim2.new(0, 20, 0, 408)
ActionFrame.BackgroundTransparency = 1
ActionFrame.Active = false
ActionFrame.ZIndex = 3
ActionFrame.Parent = MainFrame

local GotoBtn = Instance.new("TextButton")
GotoBtn.Size = UDim2.new(0.32, 0, 1, 0)
GotoBtn.Position = UDim2.new(0, 0, 0, 0)
GotoBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
GotoBtn.Text = "🚀 GOTO"
GotoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GotoBtn.TextSize = 12
GotoBtn.Font = Enum.Font.GothamBold
GotoBtn.BorderSizePixel = 0
GotoBtn.AutoButtonColor = false
GotoBtn.Active = true
GotoBtn.ZIndex = 4
GotoBtn.Parent = ActionFrame

Instance.new("UICorner", GotoBtn).CornerRadius = UDim.new(0, 6)

local GotoStroke = Instance.new("UIStroke")
GotoStroke.Color = Color3.fromRGB(60, 60, 60)
GotoStroke.Thickness = 1
GotoStroke.Parent = GotoBtn

local TweenBtn = Instance.new("TextButton")
TweenBtn.Size = UDim2.new(0.32, 0, 1, 0)
TweenBtn.Position = UDim2.new(0.34, 0, 0, 0)
TweenBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
TweenBtn.Text = "🌊 TWEEN"
TweenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TweenBtn.TextSize = 12
TweenBtn.Font = Enum.Font.GothamBold
TweenBtn.BorderSizePixel = 0
TweenBtn.AutoButtonColor = false
TweenBtn.Active = true
TweenBtn.ZIndex = 4
TweenBtn.Parent = ActionFrame

Instance.new("UICorner", TweenBtn).CornerRadius = UDim.new(0, 6)

local TweenStroke = Instance.new("UIStroke")
TweenStroke.Color = Color3.fromRGB(60, 60, 60)
TweenStroke.Thickness = 1
TweenStroke.Parent = TweenBtn

local WalkBtn = Instance.new("TextButton")
WalkBtn.Size = UDim2.new(0.32, 0, 1, 0)
WalkBtn.Position = UDim2.new(0.68, 0, 0, 0)
WalkBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
WalkBtn.Text = "🚶 WALK"
WalkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkBtn.TextSize = 12
WalkBtn.Font = Enum.Font.GothamBold
WalkBtn.BorderSizePixel = 0
WalkBtn.AutoButtonColor = false
WalkBtn.Active = true
WalkBtn.ZIndex = 4
WalkBtn.Parent = ActionFrame

Instance.new("UICorner", WalkBtn).CornerRadius = UDim.new(0, 6)

local WalkStroke = Instance.new("UIStroke")
WalkStroke.Color = Color3.fromRGB(60, 60, 60)
WalkStroke.Thickness = 1
WalkStroke.Parent = WalkBtn

-- ============ STATUS LABEL ============
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 16)
StatusLabel.Position = UDim2.new(0, 20, 0, 452)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = COLOR_GREEN
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Active = false
StatusLabel.ZIndex = 4
StatusLabel.Parent = MainFrame

-- ============ RENAME POPUP ============
local RenameOverlay = Instance.new("Frame")
RenameOverlay.Name = "RenameOverlay"
RenameOverlay.Size = UDim2.new(1, 0, 1, 0)
RenameOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RenameOverlay.BackgroundTransparency = 0.55
RenameOverlay.BorderSizePixel = 0
RenameOverlay.Visible = false
RenameOverlay.Active = true
RenameOverlay.ZIndex = 20
RenameOverlay.Parent = MainFrame

local RenameBox = Instance.new("Frame")
RenameBox.Name = "RenameBox"
RenameBox.AnchorPoint = Vector2.new(0.5, 0.5)
RenameBox.Position = UDim2.new(0.5, 0, 0.5, 0)
RenameBox.Size = UDim2.new(0, 320, 0, 176)
RenameBox.BackgroundColor3 = COLOR_PANEL_BG
RenameBox.BorderSizePixel = 0
RenameBox.ZIndex = 21
RenameBox.Parent = RenameOverlay

local RenameScale = Instance.new("UIScale")
RenameScale.Scale = 0.92
RenameScale.Parent = RenameBox

local RenameCorner = Instance.new("UICorner")
RenameCorner.CornerRadius = UDim.new(0, 10)
RenameCorner.Parent = RenameBox

local RenameStroke = Instance.new("UIStroke")
RenameStroke.Color = Color3.fromRGB(120, 60, 220)
RenameStroke.Thickness = 2
RenameStroke.Parent = RenameBox

local RenameTitle = Instance.new("TextLabel")
RenameTitle.Size = UDim2.new(1, -30, 0, 24)
RenameTitle.Position = UDim2.new(0, 15, 0, 14)
RenameTitle.BackgroundTransparency = 1
RenameTitle.Text = "Rename Waypoint"
RenameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
RenameTitle.TextSize = 16
RenameTitle.Font = Enum.Font.GothamBold
RenameTitle.TextXAlignment = Enum.TextXAlignment.Left
RenameTitle.Active = false
RenameTitle.ZIndex = 22
RenameTitle.Parent = RenameBox

local RenameCurrentLabel = Instance.new("TextLabel")
RenameCurrentLabel.Size = UDim2.new(1, -30, 0, 16)
RenameCurrentLabel.Position = UDim2.new(0, 15, 0, 42)
RenameCurrentLabel.BackgroundTransparency = 1
RenameCurrentLabel.Text = "Current: None"
RenameCurrentLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
RenameCurrentLabel.TextSize = 11
RenameCurrentLabel.Font = Enum.Font.Gotham
RenameCurrentLabel.TextXAlignment = Enum.TextXAlignment.Left
RenameCurrentLabel.Active = false
RenameCurrentLabel.ZIndex = 22
RenameCurrentLabel.Parent = RenameBox

local RenameInput = Instance.new("TextBox")
RenameInput.Name = "RenameInput"
RenameInput.Size = UDim2.new(1, -30, 0, 34)
RenameInput.Position = UDim2.new(0, 15, 0, 70)
RenameInput.BackgroundColor3 = COLOR_LIST_BG
RenameInput.BorderSizePixel = 0
RenameInput.Text = ""
RenameInput.PlaceholderText = "New waypoint name..."
RenameInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
RenameInput.TextColor3 = COLOR_TEXT
RenameInput.TextSize = 13
RenameInput.Font = Enum.Font.Gotham
RenameInput.TextXAlignment = Enum.TextXAlignment.Left
RenameInput.ClearTextOnFocus = false
RenameInput.Active = true
RenameInput.ZIndex = 23
RenameInput.Parent = RenameBox

local RenameInputCorner = Instance.new("UICorner")
RenameInputCorner.CornerRadius = UDim.new(0, 6)
RenameInputCorner.Parent = RenameInput

local RenameInputStroke = Instance.new("UIStroke")
RenameInputStroke.Color = COLOR_ITEM_NORMAL_STROKE
RenameInputStroke.Thickness = 1
RenameInputStroke.Parent = RenameInput

local RenameCancelBtn = Instance.new("TextButton")
RenameCancelBtn.Size = UDim2.new(0, 130, 0, 34)
RenameCancelBtn.Position = UDim2.new(0, 15, 0, 124)
RenameCancelBtn.BackgroundColor3 = Color3.fromRGB(55, 35, 35)
RenameCancelBtn.Text = "CANCEL"
RenameCancelBtn.TextColor3 = Color3.fromRGB(255, 180, 180)
RenameCancelBtn.TextSize = 12
RenameCancelBtn.Font = Enum.Font.GothamBold
RenameCancelBtn.BorderSizePixel = 0
RenameCancelBtn.AutoButtonColor = false
RenameCancelBtn.Active = true
RenameCancelBtn.ZIndex = 23
RenameCancelBtn.Parent = RenameBox

Instance.new("UICorner", RenameCancelBtn).CornerRadius = UDim.new(0, 6)

local RenameSaveBtn = Instance.new("TextButton")
RenameSaveBtn.Size = UDim2.new(0, 130, 0, 34)
RenameSaveBtn.Position = UDim2.new(0, 175, 0, 124)
RenameSaveBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 45)
RenameSaveBtn.Text = "SAVE"
RenameSaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RenameSaveBtn.TextSize = 12
RenameSaveBtn.Font = Enum.Font.GothamBold
RenameSaveBtn.BorderSizePixel = 0
RenameSaveBtn.AutoButtonColor = false
RenameSaveBtn.Active = true
RenameSaveBtn.ZIndex = 23
RenameSaveBtn.Parent = RenameBox

Instance.new("UICorner", RenameSaveBtn).CornerRadius = UDim.new(0, 6)

-- ============ VARIABLES ============
local currentWaypoint = nil
local itemRefs = {}
local isOpen = false
local statusToken = 0
local renamingWaypoint = nil

-- ============ FUNCTIONS ============
local function showStatus(text, color)
	statusToken = statusToken + 1
	local token = statusToken

	StatusLabel.Text = text
	StatusLabel.TextColor3 = color or COLOR_GREEN

	task.delay(2.5, function()
		if token == statusToken then
			StatusLabel.Text = ""
		end
	end)
end

local function getHRP()
	return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
end

local function generateWaypointName()
	local i = 1
	while waypoints["Waypoint " .. i] do
		i = i + 1
	end
	return "Waypoint " .. i
end

local function applyItemStyle(name)
	local ref = itemRefs[name]
	if not ref then return end

	if currentWaypoint == name then
		ref.Frame.BackgroundColor3 = COLOR_ITEM_SELECTED
		ref.Stroke.Color = COLOR_ITEM_SELECTED_STROKE
		ref.Label.TextColor3 = COLOR_TEXT_SELECTED
	else
		ref.Frame.BackgroundColor3 = COLOR_ITEM_NORMAL
		ref.Stroke.Color = COLOR_ITEM_NORMAL_STROKE
		ref.Label.TextColor3 = COLOR_TEXT
	end
end

local function selectWaypoint(name)
	if name and not waypoints[name] then
		name = nil
	end

	local oldWaypoint = currentWaypoint
	currentWaypoint = name

	if oldWaypoint then
		applyItemStyle(oldWaypoint)
	end

	if currentWaypoint then
		applyItemStyle(currentWaypoint)
		SelectedLabel.Text = "Selected: " .. currentWaypoint
		SelectedLabel.TextColor3 = Color3.fromRGB(190, 255, 210)
		SelectedStroke.Color = COLOR_ITEM_SELECTED_STROKE
	else
		SelectedLabel.Text = "Selected: None"
		SelectedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		SelectedStroke.Color = Color3.fromRGB(120, 60, 220)
	end
end

local function closeRename()
	renamingWaypoint = nil
	RenameInput.Text = ""
	RenameOverlay.Visible = false
end

local function openRename(name)
	if not waypoints[name] then
		return
	end

	renamingWaypoint = name
	RenameCurrentLabel.Text = "Current: " .. name
	RenameInput.Text = name
	RenameOverlay.Visible = true

	RenameScale.Scale = 0.92
	TweenService:Create(
		RenameScale,
		TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Scale = 1}
	):Play()
end

local function refreshList()
	itemRefs = {}

	for _, child in ipairs(ScrollingFrame:GetChildren()) do
		if child ~= UIListLayout then
			child:Destroy()
		end
	end

	local names = {}
	for name in pairs(waypoints) do
		table.insert(names, name)
	end

	table.sort(names, function(a, b)
		local timeA = type(waypoints[a]) == "table" and waypoints[a].Time or 0
		local timeB = type(waypoints[b]) == "table" and waypoints[b].Time or 0

		if timeA ~= timeB then
			return timeA < timeB
		end

		return a < b
	end)

	if #names == 0 then
		local EmptyLabel = Instance.new("TextLabel")
		EmptyLabel.Size = UDim2.new(1, -10, 0, 36)
		EmptyLabel.BackgroundTransparency = 1
		EmptyLabel.Text = "No waypoints saved yet"
		EmptyLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
		EmptyLabel.TextSize = 12
		EmptyLabel.Font = Enum.Font.Gotham
		EmptyLabel.Active = false
		EmptyLabel.ZIndex = 5
		EmptyLabel.Parent = ScrollingFrame
		return
	end

	for index, name in ipairs(names) do
		local data = waypoints[name]

		if type(data) == "table" and type(data.Position) == "table" then
			local ItemFrame = Instance.new("Frame")
			ItemFrame.Size = UDim2.new(1, -10, 0, 34)
			ItemFrame.LayoutOrder = index
			ItemFrame.BackgroundColor3 = COLOR_ITEM_NORMAL
			ItemFrame.BorderSizePixel = 0
			ItemFrame.Active = false
			ItemFrame.ZIndex = 5
			ItemFrame.Parent = ScrollingFrame

			local ItemCorner = Instance.new("UICorner")
			ItemCorner.CornerRadius = UDim.new(0, 6)
			ItemCorner.Parent = ItemFrame

			local ItemStroke = Instance.new("UIStroke")
			ItemStroke.Color = COLOR_ITEM_NORMAL_STROKE
			ItemStroke.Thickness = 1
			ItemStroke.Parent = ItemFrame

			local NameLabel = Instance.new("TextLabel")
			NameLabel.Size = UDim2.new(1, -86, 1, 0)
			NameLabel.Position = UDim2.new(0, 10, 0, 0)
			NameLabel.BackgroundTransparency = 1
			NameLabel.Text = name
			NameLabel.TextColor3 = COLOR_TEXT
			NameLabel.TextSize = 12
			NameLabel.Font = Enum.Font.GothamBold
			NameLabel.TextXAlignment = Enum.TextXAlignment.Left
			NameLabel.Active = false
			NameLabel.ZIndex = 6
			NameLabel.Parent = ItemFrame

			local SelectBtn = Instance.new("TextButton")
			SelectBtn.Size = UDim2.new(1, -82, 1, 0)
			SelectBtn.Position = UDim2.new(0, 0, 0, 0)
			SelectBtn.BackgroundTransparency = 1
			SelectBtn.Text = ""
			SelectBtn.AutoButtonColor = false
			SelectBtn.Active = true
			SelectBtn.ZIndex = 7
			SelectBtn.Parent = ItemFrame

			local EditBtn = Instance.new("TextButton")
			EditBtn.Size = UDim2.new(0, 34, 0, 28)
			EditBtn.Position = UDim2.new(1, -76, 0, 3)
			EditBtn.BackgroundColor3 = COLOR_EDIT_NORMAL
			EditBtn.Text = "EDIT"
			EditBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			EditBtn.TextSize = 9
			EditBtn.Font = Enum.Font.GothamBold
			EditBtn.BorderSizePixel = 0
			EditBtn.AutoButtonColor = false
			EditBtn.Active = true
			EditBtn.ZIndex = 9
			EditBtn.Parent = ItemFrame

			Instance.new("UICorner", EditBtn).CornerRadius = UDim.new(0, 5)

			local DeleteBtn = Instance.new("TextButton")
			DeleteBtn.Size = UDim2.new(0, 34, 0, 28)
			DeleteBtn.Position = UDim2.new(1, -38, 0, 3)
			DeleteBtn.BackgroundColor3 = COLOR_DELETE_NORMAL
			DeleteBtn.Text = "DEL"
			DeleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			DeleteBtn.TextSize = 9
			DeleteBtn.Font = Enum.Font.GothamBold
			DeleteBtn.BorderSizePixel = 0
			DeleteBtn.AutoButtonColor = false
			DeleteBtn.Active = true
			DeleteBtn.ZIndex = 8
			DeleteBtn.Parent = ItemFrame

			Instance.new("UICorner", DeleteBtn).CornerRadius = UDim.new(0, 5)

			itemRefs[name] = {
				Frame = ItemFrame,
				Stroke = ItemStroke,
				Label = NameLabel
			}

			applyItemStyle(name)

			SelectBtn.MouseEnter:Connect(function()
				if currentWaypoint ~= name then
					ItemFrame.BackgroundColor3 = COLOR_ITEM_HOVER
				end
			end)

			SelectBtn.MouseLeave:Connect(function()
				if currentWaypoint ~= name then
					ItemFrame.BackgroundColor3 = COLOR_ITEM_NORMAL
				end
			end)

			SelectBtn.MouseButton1Click:Connect(function()
				selectWaypoint(name)
			end)

			EditBtn.MouseEnter:Connect(function()
				EditBtn.BackgroundColor3 = COLOR_EDIT_HOVER
			end)

			EditBtn.MouseLeave:Connect(function()
				EditBtn.BackgroundColor3 = COLOR_EDIT_NORMAL
			end)

			EditBtn.MouseButton1Click:Connect(function()
				openRename(name)
			end)

			DeleteBtn.MouseEnter:Connect(function()
				DeleteBtn.BackgroundColor3 = COLOR_DELETE_HOVER
			end)

			DeleteBtn.MouseLeave:Connect(function()
				DeleteBtn.BackgroundColor3 = COLOR_DELETE_NORMAL
			end)

			DeleteBtn.MouseButton1Click:Connect(function()
				if currentWaypoint == name then
					currentWaypoint = nil
					SelectedLabel.Text = "Selected: None"
					SelectedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
					SelectedStroke.Color = Color3.fromRGB(120, 60, 220)
				end

				waypoints[name] = nil
				saveWaypoints()
				refreshList()
				showStatus("Deleted: " .. name, COLOR_RED)
			end)
		end
	end
end

local function setOpen(state)
	if state == isOpen then
		return
	end

	isOpen = state

	if state then
		-- ganti ikon: menu -> close
		IconMenu.Visible = false
		IconClose.Visible = true
		MainFrame.Visible = true

		TweenService:Create(
			MainFrame,
			TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{Size = OPEN_SIZE}
		):Play()
	else
		closeRename()
		-- ganti ikon: close -> menu
		IconClose.Visible = false
		IconMenu.Visible = true

		TweenService:Create(
			MainFrame,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			{Size = CLOSED_SIZE}
		):Play()

		task.delay(0.3, function()
			if not isOpen then
				MainFrame.Visible = false
			end
		end)
	end
end

local function performRename()
	if not renamingWaypoint then
		return
	end

	local oldName = renamingWaypoint
	local newName = trim(RenameInput.Text)

	if newName == "" then
		showStatus("The name cannot be left blank!", COLOR_RED)
		return
	end

	if newName == oldName then
		closeRename()
		return
	end

	if waypoints[newName] then
		showStatus("The name is already taken!", COLOR_RED)
		return
	end

	local data = waypoints[oldName]
	local wasSelected = currentWaypoint == oldName

	waypoints[oldName] = nil
	waypoints[newName] = data

	if wasSelected then
		currentWaypoint = newName
	end

	saveWaypoints()
	closeRename()
	refreshList()

	if wasSelected then
		selectWaypoint(newName)
	end

	showStatus("Renamed: " .. oldName .. " -> " .. newName, COLOR_GREEN)
end

-- ============ BUTTON CONNECTIONS ============
CloseBtn.MouseButton1Click:Connect(function()
	setOpen(false)
end)

SaveBtn.MouseButton1Click:Connect(function()
	local hrp = getHRP()
	if not hrp then
		showStatus("Character not found!", COLOR_RED)
		return
	end

	local name = generateWaypointName()

	waypoints[name] = {
		Position = {
			X = hrp.Position.X,
			Y = hrp.Position.Y,
			Z = hrp.Position.Z
		},
		Time = os.time()
	}

	saveWaypoints()
	refreshList()
	selectWaypoint(name)
	showStatus("Saved: " .. name, COLOR_GREEN)
end)

GotoBtn.MouseButton1Click:Connect(function()
	if not currentWaypoint or not waypoints[currentWaypoint] then
		showStatus("Select a waypoint first!", COLOR_ORANGE)
		return
	end

	local hrp = getHRP()
	if not hrp then
		showStatus("Character not found!", COLOR_RED)
		return
	end

	local pos = waypoints[currentWaypoint].Position
	hrp.CFrame = CFrame.new(Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(0, 3, 0))
	showStatus("Teleported to: " .. currentWaypoint, COLOR_GREEN)
end)

TweenBtn.MouseButton1Click:Connect(function()
	if not currentWaypoint or not waypoints[currentWaypoint] then
		showStatus("Select a waypoint first!", COLOR_ORANGE)
		return
	end

	local hrp = getHRP()
	if not hrp then
		showStatus("Character not found!", COLOR_RED)
		return
	end

	local pos = waypoints[currentWaypoint].Position
	local targetCFrame = CFrame.new(Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(0, 3, 0))

	TweenService:Create(
		hrp,
		TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{CFrame = targetCFrame}
	):Play()

	showStatus("Tweening to: " .. currentWaypoint, COLOR_GREEN)
end)

WalkBtn.MouseButton1Click:Connect(function()
	if not currentWaypoint or not waypoints[currentWaypoint] then
		showStatus("Select a waypoint first!", COLOR_ORANGE)
		return
	end

	local hrp = getHRP()
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")

	if not hrp or not humanoid then
		showStatus("Character not found!", COLOR_RED)
		return
	end

	local pos = waypoints[currentWaypoint].Position
	humanoid:MoveTo(Vector3.new(pos.X, pos.Y + 3, pos.Z))
	showStatus("Walking to: " .. currentWaypoint, COLOR_GREEN)
end)

RenameSaveBtn.MouseButton1Click:Connect(function()
	performRename()
end)

RenameCancelBtn.MouseButton1Click:Connect(function()
	closeRename()
end)

RenameInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		performRename()
	end
end)

-- ============ HOVER & CLICK EFFECTS ============
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

		TweenService:Create(
			button,
			TweenInfo.new(0.07),
			{
				Size = UDim2.new(
					originalSize.X.Scale,
					originalSize.X.Offset - 3,
					originalSize.Y.Scale,
					originalSize.Y.Offset - 3
				)
			}
		):Play()

		task.delay(0.07, function()
			TweenService:Create(button, TweenInfo.new(0.07), {Size = originalSize}):Play()
		end)
	end)
end

addHoverEffect(SaveBtn, Color3.fromRGB(55, 130, 55), Color3.fromRGB(45, 100, 45))
addHoverEffect(CloseBtn, Color3.fromRGB(70, 35, 35), Color3.fromRGB(45, 25, 25))
addHoverEffect(GotoBtn, Color3.fromRGB(58, 58, 58), Color3.fromRGB(38, 38, 38))
addHoverEffect(TweenBtn, Color3.fromRGB(58, 58, 58), Color3.fromRGB(38, 38, 38))
addHoverEffect(WalkBtn, Color3.fromRGB(58, 58, 58), Color3.fromRGB(38, 38, 38))
addHoverEffect(MiniToggle, Color3.fromRGB(35, 35, 35), COLOR_MAIN_BG)
addHoverEffect(RenameSaveBtn, Color3.fromRGB(55, 130, 55), Color3.fromRGB(45, 100, 45))
addHoverEffect(RenameCancelBtn, Color3.fromRGB(70, 45, 45), Color3.fromRGB(55, 35, 35))

local allButtons = {SaveBtn, CloseBtn, GotoBtn, TweenBtn, WalkBtn, RenameSaveBtn, RenameCancelBtn}
for _, btn in ipairs(allButtons) do
	addClickEffect(btn)
end

-- ============ RGB ANIMATION ============
local hue = 0

RunService.RenderStepped:Connect(function(deltaTime)
	hue = (hue + deltaTime * 0.18) % 1
	local rgbColor = Color3.fromHSV(hue, 1, 1)

	MainStroke.Color = rgbColor
	MiniStroke.Color = rgbColor
	AccentLine.BackgroundColor3 = rgbColor
	RenameStroke.Color = rgbColor
end)

-- ============ DRAGGABLE SYSTEM UNTUK PC & MOBILE ============
local draggingTarget = nil -- "main" atau "mini"
local dragStart
local dragStartPos
local miniMoved = false

local function isPressInput(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end

local function isMoveInput(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
end

DragHandle.InputBegan:Connect(function(input)
	if isPressInput(input) and not draggingTarget then
		draggingTarget = "main"
		dragStart = input.Position
		dragStartPos = MainFrame.Position
	end
end)

MiniToggle.InputBegan:Connect(function(input)
	if isPressInput(input) and not draggingTarget then
		draggingTarget = "mini"
		miniMoved = false
		dragStart = input.Position
		dragStartPos = MiniToggle.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not isMoveInput(input) then
		return
	end

	if draggingTarget == "main" then
		local delta = input.Position - dragStart
		local scale = math.max(MainScale.Scale, 0.1)

		MainFrame.Position = UDim2.new(
			dragStartPos.X.Scale,
			dragStartPos.X.Offset + delta.X / scale,
			dragStartPos.Y.Scale,
			dragStartPos.Y.Offset + delta.Y / scale
		)
	elseif draggingTarget == "mini" then
		local delta = input.Position - dragStart

		if math.abs(delta.X) + math.abs(delta.Y) > 6 then
			miniMoved = true
		end

		local newX = dragStartPos.X.Offset + delta.X
		local newY = dragStartPos.Y.Offset + delta.Y

		MiniToggle.Position = clampMiniCenterPos(newX, newY)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if not isPressInput(input) then
		return
	end

	if draggingTarget == "mini" and not miniMoved then
		setOpen(not isOpen)
	end

	draggingTarget = nil
	miniMoved = false
end)

-- ============ INITIAL RENDER ============
refreshList()
updateResponsiveScale()

-- Paksa muncul saat execute: mini frame + main frame
setOpen(true)
