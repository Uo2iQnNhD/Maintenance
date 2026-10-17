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

local COLOR_BUTTON_NORMAL = Color3.fromRGB(38, 38, 38)
local COLOR_BUTTON_HOVER = Color3.fromRGB(58, 58, 58)

local COLOR_LOOP_ACTIVE = Color3.fromRGB(190, 110, 35)
local COLOR_LOOP_ACTIVE_HOVER = Color3.fromRGB(215, 135, 55)

local COLOR_SLIDER_TRACK = Color3.fromRGB(15, 15, 15)
local COLOR_SLIDER_KNOB = Color3.fromRGB(245, 245, 245)

-- Ukuran dasar UI. Nanti di-scale otomatis untuk mobile.
local BASE_WIDTH = 420
local BASE_HEIGHT = 540

local OPEN_SIZE = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
local CLOSED_SIZE = UDim2.new(0, 0, 0, 0)

-- ============ RGB GRADIENT HELPER ============
local rgbGradients = {}

local function createRainbowColorSequence()
	local keypoints = {
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
		ColorSequenceKeypoint.new(1 / 6, Color3.fromRGB(255, 255, 0)),
		ColorSequenceKeypoint.new(2 / 6, Color3.fromRGB(0, 255, 0)),
		ColorSequenceKeypoint.new(3 / 6, Color3.fromRGB(0, 255, 255)),
		ColorSequenceKeypoint.new(4 / 6, Color3.fromRGB(0, 0, 255)),
		ColorSequenceKeypoint.new(5 / 6, Color3.fromRGB(255, 0, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
	}

	return ColorSequence.new(keypoints)
end

local function registerGradient(gradient, speed)
	table.insert(rgbGradients, {
		Gradient = gradient,
		Speed = speed or 0.12
	})

	return gradient
end

local function createRGBBorder(parent, thickness, radius, maskColor, zIndexBase)
	thickness = thickness or 2
	radius = radius or 10
	zIndexBase = zIndexBase or 1

	local border = Instance.new("Frame")
	border.Name = "RGBBorder"
	border.Size = UDim2.new(1, 0, 1, 0)
	border.Position = UDim2.new(0, 0, 0, 0)
	border.BackgroundColor3 = Color3.new(1, 1, 1)
	border.BackgroundTransparency = 0
	border.BorderSizePixel = 0
	border.Active = false
	border.ZIndex = zIndexBase
	border.Parent = parent

	local gradient = Instance.new("UIGradient")
	gradient.Color = createRainbowColorSequence()
	gradient.Offset = Vector2.new(0, 0)
	pcall(function()
		gradient.Rotation = 0
	end)
	gradient.Parent = border

	registerGradient(gradient, 0.10)

	local mask = Instance.new("Frame")
	mask.Name = "RGBBorderMask"
	mask.AnchorPoint = Vector2.new(0.5, 0.5)
	mask.Position = UDim2.new(0.5, 0, 0.5, 0)
	mask.Size = UDim2.new(1, -thickness * 2, 1, -thickness * 2)
	mask.BackgroundColor3 = maskColor or COLOR_MAIN_BG
	mask.BackgroundTransparency = 0
	mask.BorderSizePixel = 0
	mask.Active = false
	mask.ZIndex = zIndexBase + 1
	mask.Parent = parent

	if radius > thickness then
		local maskCorner = Instance.new("UICorner")
		maskCorner.CornerRadius = UDim.new(0, radius - thickness)
		maskCorner.Parent = mask
	end

	return border, mask
end

-- ============ SCREEN GUI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WaypointSystemUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
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

-- ============ INPUT HELPERS ============
local function isPressInput(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end

local function isMoveInput(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
end

-- Drag / slider state
local draggingTarget = nil -- "main" atau "mini"
local dragStart
local dragStartPos
local miniMoved = false
local sliderDragging = false

-- ============ MINI SHOW/HIDE BUTTON ============
local MiniToggle = Instance.new("TextButton")
MiniToggle.Name = "MiniToggle"
MiniToggle.Size = UDim2.new(0, 54, 0, 54)
MiniToggle.AnchorPoint = Vector2.new(0.5, 0.5)
MiniToggle.Position = UDim2.new(0, 42, 0, 360)
MiniToggle.BackgroundColor3 = COLOR_MAIN_BG
MiniToggle.BackgroundTransparency = 0
MiniToggle.Text = ""
MiniToggle.BorderSizePixel = 0
MiniToggle.AutoButtonColor = false
MiniToggle.Active = true
MiniToggle.Visible = true
MiniToggle.ClipsDescendants = true
MiniToggle.ZIndex = 50
MiniToggle.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 10)
MiniCorner.Parent = MiniToggle

local _, MiniMask = createRGBBorder(MiniToggle, 2, 10, COLOR_MAIN_BG, 1)

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

-- Clamp posisi CENTER mini box ke tepi layar sejati
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

createRGBBorder(MainFrame, 2, 10, COLOR_MAIN_BG, 1)

-- Responsive scale untuk mobile
local MainScale = Instance.new("UIScale")
MainScale.Parent = MainFrame

local function clampMainFramePosition()
	local viewport = getSafeViewportSize()
	local scale = math.max(MainScale.Scale, 0.1)

	local sizeX = MainFrame.AbsoluteSize.X
	local sizeY = MainFrame.AbsoluteSize.Y

	if sizeX <= 0 then
		sizeX = MainFrame.Size.X.Offset * scale
	end

	if sizeY <= 0 then
		sizeY = MainFrame.Size.Y.Offset * scale
	end

	if sizeX <= 0 or sizeY <= 0 then
		return
	end

	local halfX = sizeX / 2
	local halfY = sizeY / 2

	local centerX = viewport.X * 0.5 + MainFrame.Position.X.Offset
	local centerY = viewport.Y * 0.5 + MainFrame.Position.Y.Offset

	centerX = clampNumber(centerX, halfX, math.max(halfX, viewport.X - halfX))
	centerY = clampNumber(centerY, halfY, math.max(halfY, viewport.Y - halfY))

	MainFrame.Position = UDim2.new(
		0.5,
		centerX - viewport.X * 0.5,
		0.5,
		centerY - viewport.Y * 0.5
	)
end

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

	clampMainFramePosition()
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
AccentLine.BackgroundColor3 = Color3.new(1, 1, 1)
AccentLine.BorderSizePixel = 0
AccentLine.Active = false
AccentLine.ZIndex = 3
AccentLine.Parent = MainFrame

local AccentGradient = Instance.new("UIGradient")
AccentGradient.Color = createRainbowColorSequence()
AccentGradient.Offset = Vector2.new(0, 0)
pcall(function()
	AccentGradient.Rotation = 0
end)
AccentGradient.Parent = AccentLine

registerGradient(AccentGradient, 0.18)

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

-- ============ TWEEN SPEED SLIDER ============
local MIN_TWEEN_SPEED = 1
local MAX_TWEEN_SPEED = 2500
local DEFAULT_TWEEN_SPEED = 50


local tweenSpeed = DEFAULT_TWEEN_SPEED

local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -40, 0, 56)
SpeedFrame.Position = UDim2.new(0, 20, 0, 114)
SpeedFrame.BackgroundColor3 = COLOR_PANEL_BG
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Active = false
SpeedFrame.ZIndex = 3
SpeedFrame.Parent = MainFrame

local SpeedFrameCorner = Instance.new("UICorner")
SpeedFrameCorner.CornerRadius = UDim.new(0, 8)
SpeedFrameCorner.Parent = SpeedFrame

local SpeedFrameStroke = Instance.new("UIStroke")
SpeedFrameStroke.Color = COLOR_ITEM_NORMAL_STROKE
SpeedFrameStroke.Thickness = 1
SpeedFrameStroke.Parent = SpeedFrame

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, -80, 0, 16)
SpeedTitle.Position = UDim2.new(0, 10, 0, 8)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "TWEEN SPEED"
SpeedTitle.TextColor3 = Color3.fromRGB(170, 170, 170)
SpeedTitle.TextSize = 11
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.Active = false
SpeedTitle.ZIndex = 5
SpeedTitle.Parent = SpeedFrame

local SpeedValue = Instance.new("TextLabel")
SpeedValue.Size = UDim2.new(0, 60, 0, 16)
SpeedValue.Position = UDim2.new(1, -70, 0, 8)
SpeedValue.BackgroundTransparency = 1
SpeedValue.Text = "50"
SpeedValue.TextColor3 = COLOR_GREEN
SpeedValue.TextSize = 12
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextXAlignment = Enum.TextXAlignment.Right
SpeedValue.Active = false
SpeedValue.ZIndex = 5
SpeedValue.Parent = SpeedFrame

local SliderTrack = Instance.new("Frame")
SliderTrack.Size = UDim2.new(1, -20, 0, 10)
SliderTrack.Position = UDim2.new(0, 10, 0, 34)
SliderTrack.BackgroundColor3 = COLOR_SLIDER_TRACK
SliderTrack.BorderSizePixel = 0
SliderTrack.Active = true
SliderTrack.ZIndex = 4
SliderTrack.Parent = SpeedFrame

local SliderTrackCorner = Instance.new("UICorner")
SliderTrackCorner.CornerRadius = UDim.new(0, 5)
SliderTrackCorner.Parent = SliderTrack

local SliderTrackStroke = Instance.new("UIStroke")
SliderTrackStroke.Color = Color3.fromRGB(55, 55, 55)
SliderTrackStroke.Thickness = 1
SliderTrackStroke.Parent = SliderTrack

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.246, 0, 1, 0)
SliderFill.Position = UDim2.new(0, 0, 0, 0)
SliderFill.BackgroundColor3 = Color3.new(1, 1, 1)
SliderFill.BorderSizePixel = 0
SliderFill.Active = false
SliderFill.ZIndex = 5
SliderFill.Parent = SliderTrack

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 5)
SliderFillCorner.Parent = SliderFill

local SliderFillGradient = Instance.new("UIGradient")
SliderFillGradient.Color = createRainbowColorSequence()
SliderFillGradient.Offset = Vector2.new(0, 0)
pcall(function()
	SliderFillGradient.Rotation = 0
end)
SliderFillGradient.Parent = SliderFill

registerGradient(SliderFillGradient, 0.22)

local SliderKnob = Instance.new("Frame")
SliderKnob.Size = UDim2.new(0, 18, 0, 18)
SliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
SliderKnob.Position = UDim2.new(0.246, 0, 0.5, 0)
SliderKnob.BackgroundColor3 = COLOR_SLIDER_KNOB
SliderKnob.BorderSizePixel = 0
SliderKnob.Active = true
SliderKnob.ZIndex = 6
SliderKnob.Parent = SliderTrack

local SliderKnobCorner = Instance.new("UICorner")
SliderKnobCorner.CornerRadius = UDim.new(0, 9)
SliderKnobCorner.Parent = SliderKnob

local SliderKnobStroke = Instance.new("UIStroke")
SliderKnobStroke.Color = Color3.fromRGB(30, 30, 30)
SliderKnobStroke.Thickness = 2
SliderKnobStroke.Parent = SliderKnob

local function setSliderRatio(ratio)
	ratio = clampNumber(ratio, 0, 1)

	tweenSpeed = math.floor(
		MIN_TWEEN_SPEED + ratio * (MAX_TWEEN_SPEED - MIN_TWEEN_SPEED) + 0.5
	)

	tweenSpeed = clampNumber(tweenSpeed, MIN_TWEEN_SPEED, MAX_TWEEN_SPEED)

	SliderFill.Size = UDim2.new(ratio, 0, 1, 0)
	SliderKnob.Position = UDim2.new(ratio, 0, 0.5, 0)
	SpeedValue.Text = tostring(tweenSpeed)
end

local function updateSliderFromScreenPos(screenPosition)
	local absPos = SliderTrack.AbsolutePosition
	local absSize = SliderTrack.AbsoluteSize

	if absSize.X <= 0 then
		return
	end

	local ratio = (screenPosition.X - absPos.X) / absSize.X
	setSliderRatio(ratio)
end

SliderTrack.InputBegan:Connect(function(input)
	if isPressInput(input) and not draggingTarget and not sliderDragging then
		sliderDragging = true
		updateSliderFromScreenPos(input.Position)
	end
end)

SliderKnob.InputBegan:Connect(function(input)
	if isPressInput(input) and not draggingTarget and not sliderDragging then
		sliderDragging = true
		updateSliderFromScreenPos(input.Position)
	end
end)

setSliderRatio(
	(tweenSpeed - MIN_TWEEN_SPEED) / (MAX_TWEEN_SPEED - MIN_TWEEN_SPEED)
)

-- ============ LIST SECTION ============
local ListFrame = Instance.new("Frame")
ListFrame.Size = UDim2.new(1, -40, 0, 208)
ListFrame.Position = UDim2.new(0, 20, 0, 178)
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
SelectedFrame.Position = UDim2.new(0, 20, 0, 392)
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
ActionFrame.Size = UDim2.new(1, -40, 0, 34)
ActionFrame.Position = UDim2.new(0, 20, 0, 432)
ActionFrame.BackgroundTransparency = 1
ActionFrame.Active = false
ActionFrame.ZIndex = 3
ActionFrame.Parent = MainFrame

local GotoBtn = Instance.new("TextButton")
GotoBtn.Size = UDim2.new(0.32, 0, 1, 0)
GotoBtn.Position = UDim2.new(0, 0, 0, 0)
GotoBtn.BackgroundColor3 = COLOR_BUTTON_NORMAL
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
TweenBtn.BackgroundColor3 = COLOR_BUTTON_NORMAL
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
WalkBtn.BackgroundColor3 = COLOR_BUTTON_NORMAL
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

-- ============ LOOP BUTTONS ============
local LoopFrame = Instance.new("Frame")
LoopFrame.Size = UDim2.new(1, -40, 0, 34)
LoopFrame.Position = UDim2.new(0, 20, 0, 472)
LoopFrame.BackgroundTransparency = 1
LoopFrame.Active = false
LoopFrame.ZIndex = 3
LoopFrame.Parent = MainFrame

local LoopGotoBtn = Instance.new("TextButton")
LoopGotoBtn.Size = UDim2.new(0.32, 0, 1, 0)
LoopGotoBtn.Position = UDim2.new(0, 0, 0, 0)
LoopGotoBtn.BackgroundColor3 = COLOR_BUTTON_NORMAL
LoopGotoBtn.Text = "🔁 LOOP GOTO"
LoopGotoBtn.TextColor3 = COLOR_TEXT
LoopGotoBtn.TextSize = 11
LoopGotoBtn.Font = Enum.Font.GothamBold
LoopGotoBtn.BorderSizePixel = 0
LoopGotoBtn.AutoButtonColor = false
LoopGotoBtn.Active = true
LoopGotoBtn.ZIndex = 4
LoopGotoBtn.Parent = LoopFrame

Instance.new("UICorner", LoopGotoBtn).CornerRadius = UDim.new(0, 6)

local LoopGotoStroke = Instance.new("UIStroke")
LoopGotoStroke.Color = Color3.fromRGB(60, 60, 60)
LoopGotoStroke.Thickness = 1
LoopGotoStroke.Parent = LoopGotoBtn

local LoopTweenBtn = Instance.new("TextButton")
LoopTweenBtn.Size = UDim2.new(0.32, 0, 1, 0)
LoopTweenBtn.Position = UDim2.new(0.34, 0, 0, 0)
LoopTweenBtn.BackgroundColor3 = COLOR_BUTTON_NORMAL
LoopTweenBtn.Text = "🔁 LOOP TWEEN"
LoopTweenBtn.TextColor3 = COLOR_TEXT
LoopTweenBtn.TextSize = 11
LoopTweenBtn.Font = Enum.Font.GothamBold
LoopTweenBtn.BorderSizePixel = 0
LoopTweenBtn.AutoButtonColor = false
LoopTweenBtn.Active = true
LoopTweenBtn.ZIndex = 4
LoopTweenBtn.Parent = LoopFrame

Instance.new("UICorner", LoopTweenBtn).CornerRadius = UDim.new(0, 6)

local LoopTweenStroke = Instance.new("UIStroke")
LoopTweenStroke.Color = Color3.fromRGB(60, 60, 60)
LoopTweenStroke.Thickness = 1
LoopTweenStroke.Parent = LoopTweenBtn

local LoopWalkBtn = Instance.new("TextButton")
LoopWalkBtn.Size = UDim2.new(0.32, 0, 1, 0)
LoopWalkBtn.Position = UDim2.new(0.68, 0, 0, 0)
LoopWalkBtn.BackgroundColor3 = COLOR_BUTTON_NORMAL
LoopWalkBtn.Text = "🔁 LOOP WALK"
LoopWalkBtn.TextColor3 = COLOR_TEXT
LoopWalkBtn.TextSize = 11
LoopWalkBtn.Font = Enum.Font.GothamBold
LoopWalkBtn.BorderSizePixel = 0
LoopWalkBtn.AutoButtonColor = false
LoopWalkBtn.Active = true
LoopWalkBtn.ZIndex = 4
LoopWalkBtn.Parent = LoopFrame

Instance.new("UICorner", LoopWalkBtn).CornerRadius = UDim.new(0, 6)

local LoopWalkStroke = Instance.new("UIStroke")
LoopWalkStroke.Color = Color3.fromRGB(60, 60, 60)
LoopWalkStroke.Thickness = 1
LoopWalkStroke.Parent = LoopWalkBtn

-- ============ STATUS LABEL ============
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 16)
StatusLabel.Position = UDim2.new(0, 20, 0, 512)
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
RenameBox.ClipsDescendants = true
RenameBox.ZIndex = 21
RenameBox.Parent = RenameOverlay

local RenameScale = Instance.new("UIScale")
RenameScale.Scale = 0.92
RenameScale.Parent = RenameBox

local RenameCorner = Instance.new("UICorner")
RenameCorner.CornerRadius = UDim.new(0, 10)
RenameCorner.Parent = RenameBox

createRGBBorder(RenameBox, 2, 10, COLOR_PANEL_BG, 1)

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

local loopMode = nil -- "goto", "tween", "walk", atau nil
local loopToken = 0

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

local function getTweenDuration(fromPosition, toPosition)
	local distance = (toPosition - fromPosition).Magnitude
	local speed = math.max(1, tweenSpeed)
	local duration = distance / speed

	return clampNumber(duration, 0.08, 60)
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

-- ============ LOOP SYSTEM ============
local loopButtonData = {
	{
		Button = LoopGotoBtn,
		Mode = "goto",
		Normal = COLOR_BUTTON_NORMAL,
		Hover = COLOR_BUTTON_HOVER,
		Active = COLOR_LOOP_ACTIVE
	},
	{
		Button = LoopTweenBtn,
		Mode = "tween",
		Normal = COLOR_BUTTON_NORMAL,
		Hover = COLOR_BUTTON_HOVER,
		Active = COLOR_LOOP_ACTIVE
	},
	{
		Button = LoopWalkBtn,
		Mode = "walk",
		Normal = COLOR_BUTTON_NORMAL,
		Hover = COLOR_BUTTON_HOVER,
		Active = COLOR_LOOP_ACTIVE
	}
}

local function updateLoopButtons()
	for _, data in ipairs(loopButtonData) do
		local isActive = loopMode == data.Mode

		if isActive then
			data.Button.BackgroundColor3 = data.Active
			data.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			data.Button.BackgroundColor3 = data.Normal
			data.Button.TextColor3 = COLOR_TEXT
		end
	end
end

local function stopAllLoops(silent)
	local hadLoop = loopMode ~= nil

	loopMode = nil
	loopToken = loopToken + 1

	updateLoopButtons()

	if hadLoop and not silent then
		showStatus("Loop stopped", COLOR_ORANGE)
	end
end

local function waitForLoop(token, seconds)
	local elapsed = 0

	while elapsed < seconds do
		if loopMode == nil or token ~= loopToken then
			return false
		end

		local step = math.min(0.1, seconds - elapsed)
		task.wait(step)
		elapsed = elapsed + step
	end

	return true
end

local function setLoopMode(mode)
	if loopMode == mode then
		stopAllLoops(false)
		return
	end

	loopMode = mode
	loopToken = loopToken + 1

	local token = loopToken
	updateLoopButtons()

	if mode == "goto" then
		showStatus("Loop GOTO enabled", COLOR_GREEN)

		task.spawn(function()
			while loopMode == "goto" and token == loopToken do
				local wp = currentWaypoint

				if not wp or not waypoints[wp] then
					stopAllLoops(true)
					showStatus("Loop stopped: waypoint missing", COLOR_RED)
					return
				end

				local hrp = getHRP()

				if not hrp or not hrp.Parent then
					stopAllLoops(true)
					showStatus("Loop stopped: character missing", COLOR_RED)
					return
				end

				local pos = waypoints[wp].Position
				hrp.CFrame = CFrame.new(Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(0, 3, 0))

				if not waitForLoop(token, 0.12) then
					return
				end
			end
		end)

	elseif mode == "tween" then
		showStatus("Loop TWEEN enabled", COLOR_GREEN)

		task.spawn(function()
			while loopMode == "tween" and token == loopToken do
				local wp = currentWaypoint

				if not wp or not waypoints[wp] then
					stopAllLoops(true)
					showStatus("Loop stopped: waypoint missing", COLOR_RED)
					return
				end

				local hrp = getHRP()

				if not hrp or not hrp.Parent then
					stopAllLoops(true)
					showStatus("Loop stopped: character missing", COLOR_RED)
					return
				end

				local pos = waypoints[wp].Position
				local targetPos = Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(0, 3, 0)
				local targetCFrame = CFrame.new(targetPos)

				if (targetPos - hrp.Position).Magnitude < 0.5 then
					if not waitForLoop(token, 0.25) then
						return
					end
				else
					local duration = getTweenDuration(hrp.Position, targetPos)
					local tween = TweenService:Create(
						hrp,
						TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
						{CFrame = targetCFrame}
					)

					tween:Play()

					if not waitForLoop(token, duration + 0.05) then
						return
					end

					if not hrp or not hrp.Parent then
						stopAllLoops(true)
						showStatus("Loop stopped: character missing", COLOR_RED)
						return
					end
				end
			end
		end)

	elseif mode == "walk" then
		showStatus("Loop WALK enabled", COLOR_GREEN)

		task.spawn(function()
			while loopMode == "walk" and token == loopToken do
				local wp = currentWaypoint

				if not wp or not waypoints[wp] then
					stopAllLoops(true)
					showStatus("Loop stopped: waypoint missing", COLOR_RED)
					return
				end

				local character = player.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				local hrp = getHRP()

				if not humanoid or not humanoid.Parent or not hrp or not hrp.Parent then
					stopAllLoops(true)
					showStatus("Loop stopped: character missing", COLOR_RED)
					return
				end

				local pos = waypoints[wp].Position
				humanoid:MoveTo(Vector3.new(pos.X, pos.Y + 3, pos.Z))

				if not waitForLoop(token, 0.25) then
					return
				end
			end
		end)
	end
end

for _, data in ipairs(loopButtonData) do
	data.Button.MouseEnter:Connect(function()
		if loopMode ~= data.Mode then
			TweenService:Create(data.Button, TweenInfo.new(0.15), {BackgroundColor3 = data.Hover}):Play()
		end
	end)

	data.Button.MouseLeave:Connect(function()
		if loopMode ~= data.Mode then
			TweenService:Create(data.Button, TweenInfo.new(0.15), {BackgroundColor3 = data.Normal}):Play()
		end
	end)

	data.Button.MouseButton1Click:Connect(function()
		setLoopMode(data.Mode)
	end)

	addClickEffect(data.Button)
end

-- ============ REFRESH LIST ============
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

					if loopMode then
						stopAllLoops(true)
					end
				end

				waypoints[name] = nil
				saveWaypoints()
				refreshList()
				showStatus("Deleted: " .. name, COLOR_RED)
			end)
		end
	end
end

-- ============ OPEN / CLOSE ============
local function setOpen(state)
	if state == isOpen then
		return
	end

	isOpen = state

	if state then
		IconMenu.Visible = false
		IconClose.Visible = true
		MainFrame.Visible = true

		TweenService:Create(
			MainFrame,
			TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{Size = OPEN_SIZE}
		):Play()

		task.delay(0.36, function()
			if isOpen then
				clampMainFramePosition()
			end
		end)
	else
		closeRename()
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

-- ============ RENAME ============
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
	if loopMode then
		stopAllLoops(true)
	end

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
	if loopMode then
		stopAllLoops(true)
	end

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
	local targetPos = Vector3.new(pos.X, pos.Y, pos.Z) + Vector3.new(0, 3, 0)
	local duration = getTweenDuration(hrp.Position, targetPos)

	TweenService:Create(
		hrp,
		TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{CFrame = CFrame.new(targetPos)}
	):Play()

	showStatus("Tweening to: " .. currentWaypoint .. " | speed: " .. tostring(tweenSpeed), COLOR_GREEN)
end)

WalkBtn.MouseButton1Click:Connect(function()
	if loopMode then
		stopAllLoops(true)
	end

	if not currentWaypoint or not waypoints[currentWaypoint] then
		showStatus("Select a waypoint first!", COLOR_ORANGE)
		return
	end

	local hrp = getHRP()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

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

-- ============ EXTRA HOVER / CLICK ============
addHoverEffect(SaveBtn, Color3.fromRGB(55, 130, 55), Color3.fromRGB(45, 100, 45))
addHoverEffect(CloseBtn, Color3.fromRGB(70, 35, 35), Color3.fromRGB(45, 25, 25))
addHoverEffect(GotoBtn, COLOR_BUTTON_HOVER, COLOR_BUTTON_NORMAL)
addHoverEffect(TweenBtn, COLOR_BUTTON_HOVER, COLOR_BUTTON_NORMAL)
addHoverEffect(WalkBtn, COLOR_BUTTON_HOVER, COLOR_BUTTON_NORMAL)
addHoverEffect(RenameSaveBtn, Color3.fromRGB(55, 130, 55), Color3.fromRGB(45, 100, 45))
addHoverEffect(RenameCancelBtn, Color3.fromRGB(70, 45, 45), Color3.fromRGB(55, 35, 35))

local standardButtons = {
	SaveBtn,
	CloseBtn,
	GotoBtn,
	TweenBtn,
	WalkBtn,
	RenameSaveBtn,
	RenameCancelBtn
}

for _, btn in ipairs(standardButtons) do
	addClickEffect(btn)
end

-- Mini toggle hover khusus, karena ada mask RGB border
local MINI_HOVER = Color3.fromRGB(35, 35, 35)

MiniToggle.MouseEnter:Connect(function()
	TweenService:Create(MiniToggle, TweenInfo.new(0.15), {BackgroundColor3 = MINI_HOVER}):Play()
	TweenService:Create(MiniMask, TweenInfo.new(0.15), {BackgroundColor3 = MINI_HOVER}):Play()
end)

MiniToggle.MouseLeave:Connect(function()
	TweenService:Create(MiniToggle, TweenInfo.new(0.15), {BackgroundColor3 = COLOR_MAIN_BG}):Play()
	TweenService:Create(MiniMask, TweenInfo.new(0.15), {BackgroundColor3 = COLOR_MAIN_BG}):Play()
end)

-- ============ RGB ANIMATION ============
local rgbElapsed = 0

RunService.RenderStepped:Connect(function(deltaTime)
	rgbElapsed = rgbElapsed + deltaTime

	for _, data in ipairs(rgbGradients) do
		local phase = (rgbElapsed * (data.Speed or 0.12)) % 1

		data.Gradient.Offset = Vector2.new(phase, 0)

		pcall(function()
			data.Gradient.Rotation = phase * 360
		end)
	end
end)

-- ============ DRAGGABLE SYSTEM UNTUK PC & MOBILE ============
DragHandle.InputBegan:Connect(function(input)
	if isPressInput(input) and not draggingTarget and not sliderDragging then
		draggingTarget = "main"
		dragStart = input.Position
		dragStartPos = MainFrame.Position
	end
end)

MiniToggle.InputBegan:Connect(function(input)
	if isPressInput(input) and not draggingTarget and not sliderDragging then
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

	if sliderDragging then
		updateSliderFromScreenPos(input.Position)
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

		clampMainFramePosition()
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

	if sliderDragging then
		sliderDragging = false
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
updateLoopButtons()

-- Paksa muncul saat execute: mini frame + main frame
setOpen(true)
