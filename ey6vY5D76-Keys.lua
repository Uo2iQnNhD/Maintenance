local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============ CONFIG ============
local KEY_SCRIPT_URL = "https://raw.githubusercontent.com/zeutronxsite/hrZyx4kUT-KeyG/refs/heads/main/Generator.luau"
local VERIFY_SCRIPT_URL = "https://raw.githubusercontent.com/zeutronxsite/F4DiY9yZ9Safety/refs/heads/main/yXLHkaN70yMain"
local PASTEBIN_LINK = "https://pastebin.com/Ty4rds"
local SAVE_FILE = "KeySystem_Save.txt"
local REDEEM_TRACKER_URL = "https://your-backend-api.com/redeem"

local LIFETIME_KEYS = {
    "KEYLIFE-VuTSnhp4s-sJVoJGiE",
    "KEYTIME-zGHzmsXBj-rub7q9aE",
    "KEY-NsheRJF2CN-nMFFZ7uHcS"
}
-- =================================

local function isLifetimeKey(key)
    if not key then return false end
    for _, lk in ipairs(LIFETIME_KEYS) do
        if key == lk then return true end
    end
    if string.sub(key, 1, 9) == "LIFETIME-" then
        return true
    end
    return false
end

local savedKey = nil
local isKeyExpired = false

if isfile and isfile(SAVE_FILE) then
    local fileContent = readfile(SAVE_FILE)
    local key, timestamp = fileContent:match("^(.-)|(%d+)$")
    
    if key and timestamp then
        local currentTime = os.time()
        local keyAge = currentTime - tonumber(timestamp)
        local expirationLimit = 6 * 60 * 60
        
        if isLifetimeKey(key) then
            isKeyExpired = false
            savedKey = key
        elseif keyAge > expirationLimit then
            isKeyExpired = true
            if delfile then delfile(SAVE_FILE) end
            savedKey = nil
        else
            savedKey = key
        end
    else
        if delfile then delfile(SAVE_FILE) end
        savedKey = nil
    end
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystemUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 380)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Corner
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Stroke
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(45, 45, 45)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Dark Overlay
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.4
Overlay.Parent = MainFrame

-- Logo (Profile Avatar Player)
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 50, 0, 50)
LogoFrame.Position = UDim2.new(0, 20, 0, 20)
LogoFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
LogoFrame.BorderSizePixel = 0
LogoFrame.Visible = false
LogoFrame.Parent = MainFrame

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 8)
LogoCorner.Parent = LogoFrame

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(70, 70, 70)
LogoStroke.Thickness = 1.5
LogoStroke.Parent = LogoFrame

local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.new(1, -10, 1, -10)
LogoImage.Position = UDim2.new(0, 5, 0, 5)
LogoImage.BackgroundTransparency = 1
LogoImage.ScaleType = Enum.ScaleType.Crop
LogoImage.Parent = LogoFrame

local success, thumbnailUrl = pcall(function()
    local url, isReady = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
    return url
end)

if success and thumbnailUrl then
    LogoImage.Image = thumbnailUrl
    LogoFrame.Visible = true
else
    LogoImage.Image = "rbxassetid://0"
    LogoFrame.Visible = true
end

-- Title & Subtitle
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 350, 0, 28)
Title.Position = UDim2.new(0, 80, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 350, 0, 16)
Subtitle.Position = UDim2.new(0, 80, 0, 43)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Enter or generate your key to access scripts"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame

-- Key Input (TextBox)
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(0, 480, 0, 36)
InputFrame.Position = UDim2.new(0, 20, 0, 75)
InputFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
InputFrame.BorderSizePixel = 0
InputFrame.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 7)
InputCorner.Parent = InputFrame

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(55, 55, 55)
InputStroke.Thickness = 1
InputStroke.Parent = InputFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.Text = savedKey or ""
KeyInput.PlaceholderText = "Enter your key here..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
KeyInput.TextColor3 = Color3.fromRGB(220, 220, 220)
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.Parent = InputFrame

KeyInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(120, 60, 220)
    }):Play()
end)

KeyInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(55, 55, 55)
    }):Play()
    if KeyInput.Text ~= "" then
        savedKey = KeyInput.Text
    end
end)

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 20)
StatusLabel.Position = UDim2.new(0, 20, 0, 120)
StatusLabel.BackgroundTransparency = 1

if isKeyExpired then
    StatusLabel.Text = "⚠️ Key is expired! Please GET KEY again"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
else
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end

StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- Button Container untuk GET KEY dan VERIFY
local TopButtonContainer = Instance.new("Frame")
TopButtonContainer.Size = UDim2.new(1, -40, 0, 36)
TopButtonContainer.Position = UDim2.new(0, 20, 0, 150)
TopButtonContainer.BackgroundTransparency = 1
TopButtonContainer.Parent = MainFrame

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.485, 0, 1, 0)
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
GetKeyBtn.Text = "🔑 GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Parent = TopButtonContainer

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 7)
GetKeyCorner.Parent = GetKeyBtn

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Color = Color3.fromRGB(75, 75, 75)
GetKeyStroke.Thickness = 1
GetKeyStroke.Parent = GetKeyBtn

-- Verify Button
local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.485, 0, 1, 0)
VerifyBtn.Position = UDim2.new(0.515, 0, 0, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(55, 25, 110)
VerifyBtn.Text = "✅ VERIFY"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 13
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Parent = TopButtonContainer

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 7)
VerifyCorner.Parent = VerifyBtn

local VerifyStroke = Instance.new("UIStroke")
VerifyStroke.Color = Color3.fromRGB(90, 50, 170)
VerifyStroke.Thickness = 1
VerifyStroke.Parent = VerifyBtn

-- Pastebin Link Button
local PastebinBtn = Instance.new("TextButton")
PastebinBtn.Size = UDim2.new(1, -40, 0, 36)
PastebinBtn.Position = UDim2.new(0, 20, 0, 195)
PastebinBtn.BackgroundColor3 = Color3.fromRGB(25, 70, 110)
PastebinBtn.Text = "📋 PASTEBIN LINK"
PastebinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PastebinBtn.TextSize = 12
PastebinBtn.Font = Enum.Font.GothamBold
PastebinBtn.BorderSizePixel = 0
PastebinBtn.Parent = MainFrame

local PastebinCorner = Instance.new("UICorner")
PastebinCorner.CornerRadius = UDim.new(0, 7)
PastebinCorner.Parent = PastebinBtn

local PastebinStroke = Instance.new("UIStroke")
PastebinStroke.Color = Color3.fromRGB(45, 100, 150)
PastebinStroke.Thickness = 1
PastebinStroke.Parent = PastebinBtn

-- Bottom Button Container untuk REJOIN dan SERVER HOP
local BottomButtonContainer = Instance.new("Frame")
BottomButtonContainer.Size = UDim2.new(1, -40, 0, 36)
BottomButtonContainer.Position = UDim2.new(0, 20, 0, 240)
BottomButtonContainer.BackgroundTransparency = 1
BottomButtonContainer.Parent = MainFrame

-- Rejoin Button
local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(0.485, 0, 1, 0)
RejoinBtn.Position = UDim2.new(0, 0, 0, 0)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(110, 25, 25)
RejoinBtn.Text = "🔄 REJOIN"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.TextSize = 12
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.BorderSizePixel = 0
RejoinBtn.Parent = BottomButtonContainer

local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0, 7)
RejoinCorner.Parent = RejoinBtn

local RejoinStroke = Instance.new("UIStroke")
RejoinStroke.Color = Color3.fromRGB(150, 45, 45)
RejoinStroke.Thickness = 1
RejoinStroke.Parent = RejoinBtn

-- Server Hop Button
local ServerHopBtn = Instance.new("TextButton")
ServerHopBtn.Size = UDim2.new(0.485, 0, 1, 0)
ServerHopBtn.Position = UDim2.new(0.515, 0, 0, 0)
ServerHopBtn.BackgroundColor3 = Color3.fromRGB(25, 70, 110)
ServerHopBtn.Text = "🌐 SERVER HOP"
ServerHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerHopBtn.TextSize = 12
ServerHopBtn.Font = Enum.Font.GothamBold
ServerHopBtn.BorderSizePixel = 0
ServerHopBtn.Parent = BottomButtonContainer

local ServerHopCorner = Instance.new("UICorner")
ServerHopCorner.CornerRadius = UDim.new(0, 7)
ServerHopCorner.Parent = ServerHopBtn

local ServerHopStroke = Instance.new("UIStroke")
ServerHopStroke.Color = Color3.fromRGB(45, 100, 150)
ServerHopStroke.Thickness = 1
ServerHopStroke.Parent = ServerHopBtn

-- Created by Text
local CreatedByText = Instance.new("TextLabel")
CreatedByText.Size = UDim2.new(1, -40, 0, 16)
CreatedByText.Position = UDim2.new(0, 20, 0, 290)
CreatedByText.BackgroundTransparency = 1
CreatedByText.Text = "Created By Exterminate0"
CreatedByText.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatedByText.TextSize = 10
CreatedByText.Font = Enum.Font.GothamBold
CreatedByText.TextXAlignment = Enum.TextXAlignment.Center
CreatedByText.Parent = MainFrame

-- Server ID Label (Pojok Kiri Bawah)
local ServerIdLabel = Instance.new("TextLabel")
ServerIdLabel.Size = UDim2.new(0, 280, 0, 16)
ServerIdLabel.Position = UDim2.new(0, 15, 1, -22)
ServerIdLabel.BackgroundTransparency = 1
ServerIdLabel.Text = "Server ID: " .. tostring(game.JobId)
ServerIdLabel.TextColor3 = Color3.fromRGB(90, 90, 90)
ServerIdLabel.TextSize = 9
ServerIdLabel.Font = Enum.Font.Gotham
ServerIdLabel.TextXAlignment = Enum.TextXAlignment.Left
ServerIdLabel.Parent = MainFrame

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 25)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.TextSize = 14
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

-- ============ FUNCTION TO DESTROY UI SMOOTHLY ============
local function destroyUI()
    local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    fadeTween:Play()
    
    for _, child in pairs(MainFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            pcall(function()
                TweenService:Create(child, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1,
                    TextTransparency = 1,
                    ImageTransparency = 1
                }):Play()
            end)
        end
    end
    
    task.wait(0.5)
    
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
    print("✓ Key System verified and destroyed!")
end

-- ============ HOVER & CLICK EFFECTS ============
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = hoverColor
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = normalColor
        }):Play()
    end)
end

addHoverEffect(GetKeyBtn, Color3.fromRGB(55, 55, 55), Color3.fromRGB(38, 38, 38))
addHoverEffect(VerifyBtn, Color3.fromRGB(75, 35, 140), Color3.fromRGB(55, 25, 110))
addHoverEffect(PastebinBtn, Color3.fromRGB(35, 90, 140), Color3.fromRGB(25, 70, 110))
addHoverEffect(RejoinBtn, Color3.fromRGB(140, 35, 35), Color3.fromRGB(110, 25, 25))
addHoverEffect(ServerHopBtn, Color3.fromRGB(35, 90, 140), Color3.fromRGB(25, 70, 110))
addHoverEffect(CloseBtn, Color3.fromRGB(70, 35, 35), Color3.fromRGB(45, 25, 25))

local function addClickEffect(button)
    button.MouseButton1Click:Connect(function()
        local originalSize = button.Size
        TweenService:Create(button, TweenInfo.new(0.08), {
            Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 4, originalSize.Y.Scale, originalSize.Y.Offset - 4)
        }):Play()
        task.wait(0.08)
        TweenService:Create(button, TweenInfo.new(0.08), {
            Size = originalSize
        }):Play()
    end)
end

addClickEffect(GetKeyBtn)
addClickEffect(VerifyBtn)
addClickEffect(PastebinBtn)
addClickEffect(RejoinBtn)
addClickEffect(ServerHopBtn)
addClickEffect(CloseBtn)

-- ============ KEY VALIDATION FUNCTION ============
local function isValidKey(key)
    if not key or key == "" then return false end
    
    if string.match(key, "^EXTERM%-%d%d%d%d%d%d%-%d%d%d%d$") then return true end
    
    if string.match(key, "^KEY%-%w+%-%w+%-%w+$") then
        local parts = {}
        for part in string.gmatch(key, "([^%-]+)") do
            table.insert(parts, part)
        end
        if #parts == 4 and #parts[2] == 6 and #parts[3] == 6 and #parts[4] == 6 then
            return true
        end
    end
    
    if isLifetimeKey(key) then return true end
    
    return false
end

-- ============ GET KEY FUNCTION ============
GetKeyBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🔄 Execute Key Generator..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    local success, result = pcall(function()
        local keyScript = loadstring(game:HttpGet(KEY_SCRIPT_URL))()
        return keyScript
    end)
    
    if success and result and type(result) == "string" then
        local newKey = result
        local currentTime = tostring(os.time())
        local dataToSave = newKey .. "|" .. currentTime
        
        savedKey = newKey
        isKeyExpired = false
        
        if writefile then
            writefile(SAVE_FILE, dataToSave)
        end
        
        KeyInput.Text = newKey
        
        if setclipboard then
            setclipboard(newKey)
            StatusLabel.Text = ""
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            StatusLabel.Text = ""
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        end
        
        task.wait(2)
        StatusLabel.Text = ""
    else
        StatusLabel.Text = ""
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        StatusLabel.Text = ""
    end
end)

-- ============ VERIFY FUNCTION ============
VerifyBtn.MouseButton1Click:Connect(function()
    local keyToVerify = KeyInput.Text
    
    if not keyToVerify or keyToVerify == "" then
        StatusLabel.Text = "⚠️ Please enter a key!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 100)
        return
    end
    
    if not savedKey or savedKey == "" or isKeyExpired then
        StatusLabel.Text = "⚠️ Key expired or invalid! Please GET KEY again."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        KeyInput.Text = ""
        return
    end

    if not isValidKey(keyToVerify) then
        StatusLabel.Text = "⚠️ Invalid key format!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        local originalPos = InputFrame.Position
        for i = 1, 4 do
            TweenService:Create(InputFrame, TweenInfo.new(0.05), {
                Position = UDim2.new(0, 20 + (i % 2 == 0 and -5 or 5), 0, 75)
            }):Play()
            task.wait(0.05)
        end
        TweenService:Create(InputFrame, TweenInfo.new(0.05), {
            Position = originalPos
        }):Play()
        return
    end
    
    StatusLabel.Text = "🔄 Checking key availability..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    if REDEEM_TRACKER_URL ~= "https://your-backend-api.com/redeem" then
        local checkSuccess, checkResult = pcall(function()
            local encodedKey = HttpService:UrlEncode(keyToVerify)
            local response = game:HttpGet(REDEEM_TRACKER_URL .. "?key=" .. encodedKey)
            return HttpService:JSONDecode(response)
        end)
        
        if checkSuccess and checkResult and checkResult.redeemed == true then
            StatusLabel.Text = "⚠️ Key sudah digunakan player lain!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            if delfile then delfile(SAVE_FILE) end
            savedKey = nil
            KeyInput.Text = ""
            return
        end
    end
    
    task.wait(1)
    
    StatusLabel.Text = "🔄 Verifying..."
    task.wait(1.5)
    
    local success, result = pcall(function()
        local verifyscript = loadstring(game:HttpGet(VERIFY_SCRIPT_URL))()
        return verifyscript
    end)
    
    if success then
        StatusLabel.Text = "✓ Key verified successfully!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        VerifyBtn.Text = "✅ VERIFIED"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(25, 90, 25)
        
        task.wait(1)
        StatusLabel.Text = "✓ Access granted! Executing script..."
        task.wait(1.5)
        
        if REDEEM_TRACKER_URL ~= "https://your-backend-api.com/redeem" then
            pcall(function()
                game:HttpPost(REDEEM_TRACKER_URL, HttpService:JSONEncode({key = keyToVerify, userId = player.UserId}))
            end)
        end
        
        -- HANCURKAN UI SECARA OTOMATIS SETELAH BERHASIL
        destroyUI()
        
    else
        StatusLabel.Text = "⚠️ Verification failed!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- ============ PASTEBIN LINK ============
PastebinBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(PASTEBIN_LINK)
        StatusLabel.Text = "✓ Pastebin link copied!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(2)
        StatusLabel.Text = ""
    else
        StatusLabel.Text = "Link: " .. PASTEBIN_LINK
        StatusLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    end
end)

-- ============ REJOIN FUNCTION ============
RejoinBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🔄 Rejoining..."
    task.wait(0.5)
    TeleportService:Teleport(game.PlaceId, player)
end)

-- ============ SERVER HOP FUNCTION ============
ServerHopBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🔄 Finding new server..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    local PlaceId = game.PlaceId
    local success, result = pcall(function()
        local response = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local data = HttpService:JSONDecode(response)
        local availableServers = {}
        
        for _, server in ipairs(data.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                table.insert(availableServers, server.id)
            end
        end
        return availableServers
    end)
    
    if success and #result > 0 then
        local randomServer = result[math.random(1, #result)]
        StatusLabel.Text = "🔄 Hopping to new server..."
        task.wait(0.5)
        TeleportService:TeleportToPlaceInstance(PlaceId, randomServer, player)
    else
        StatusLabel.Text = "⚠️ Failed to find available server!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        StatusLabel.Text = ""
    end
end)

-- ============ CLOSE BUTTON ============
CloseBtn.MouseButton1Click:Connect(function()
    destroyUI()
end)

-- ============ DRAGGABLE ============
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

game:GetService("UserInputService").InputChanged:Connect(function(input)
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
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -240)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Position = UDim2.new(0.5, -260, 0.5, -190),
    BackgroundTransparency = 0
}):Play()
