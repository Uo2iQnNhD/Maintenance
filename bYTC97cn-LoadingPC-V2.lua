-- ==========================================
-- ZETHUB Loading Screen
-- ★ AURORA GLASS EDITION - PC ONLY ★
-- Background Gelap Transparan (darker overlay)
-- FIX: Offset tween UDim2 → Vector2 (UIGradient.Offset = Vector2)
-- ==========================================

-- Guard: cegah splash berulang dalam 30 detik
local lastExecution = _G.ZETHUB_SPLASH_PC_LAST_EXEC or 0
local currentTime = os.clock()

if (currentTime - lastExecution) < 30 then
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/eaDnYiUk-CheckingV2.luau"))()
    end)
    if not success then
        warn("[System] Failed to load script:", errorMessage)
    end
    return
end

_G.ZETHUB_SPLASH_PC_LAST_EXEC = currentTime

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- Kunci PC: kalau mobile, keluar (versi mobile punya script sendiri)
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
if isMobile then
    warn("[ZETHUB] Script ini khusus PC. Gunakan script versi mobile di HP.")
    return
end

math.randomseed(os.clock())

local function getGuiParent()
    if gethui then
        local ok, hui = pcall(gethui)
        if ok and hui then return hui end
    end
    if syn and syn.protect_gui then
        return game:GetService("CoreGui")
    end
    return player:WaitForChild("PlayerGui")
end

local parentGui = getGuiParent()

local function new(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    return inst
end

-- ★ FIX UTAMA ★: pembuatan instance opsional yang aman gagal.
-- Beberapa executor memblokir Instance.new("UIBlur") dll.
-- Kalau gagal, return nil tanpa crash, lalu pakai fallback visual.
local function tryNew(class, props)
    local ok, inst = pcall(function()
        local i = Instance.new(class)
        for k, v in pairs(props or {}) do
            pcall(function() i[k] = v end)
        end
        return i
    end)
    if ok and inst then
        return inst
    end
    return nil
end

local function tween(obj, props, duration, style, direction)
    local info = TweenInfo.new(
        duration,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function loopTween(obj, props, duration)
    local info = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Bersihkan splash lama
pcall(function()
    for _, v in ipairs(parentGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("ZETHUB_SPLASH_PC") then
            v:Destroy()
        end
    end
end)

local gui = new("ScreenGui", {
    Name = "ZETHUB_SPLASH_PC_" .. tostring(math.random(100000, 999999)),
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 9999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = parentGui
})

-- ==========================================
-- BACKGROUND GELAP TRANSPARAN (Darker Overlay)
-- Game tetap terlihat tapi lebih gelap agar fokus ke splash
-- ==========================================
local main = new("Frame", {
    Name = "Main",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(4, 6, 14), -- warna sangat gelap, hampir hitam
    BackgroundTransparency = 1, -- mulai transparan penuh, di-fade in ke 0.55
    BorderSizePixel = 0,
    ZIndex = 10,
    Parent = gui
})

-- Vignette gradient untuk efek gelap di pinggir
local vignette = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.35, Color3.fromRGB(10, 14, 26)),
        ColorSequenceKeypoint.new(0.65, Color3.fromRGB(10, 14, 26)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    }),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.35, 0.55),
        NumberSequenceKeypoint.new(0.65, 0.55),
        NumberSequenceKeypoint.new(1, 0.1),
    }),
    Rotation = 0,
    Parent = main
})

local content = new("Frame", {
    Name = "Content",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 11,
    Parent = main
})

-- Scaling PC (adaptif untuk window kecil)
local viewport = camera.ViewportSize
local tries = 0
while (viewport.X < 100 or viewport.Y < 100) and tries < 30 do
    task.wait(0.1)
    viewport = camera.ViewportSize
    tries += 1
end
if viewport.X < 100 or viewport.Y < 100 then
    viewport = Vector2.new(1920, 1080)
end

local scaleFactor = 1
local function computeScale()
    scaleFactor = math.clamp(math.min(viewport.X / 1920, viewport.Y / 1080), 0.8, 1.2)
end
computeScale()

local function sc(n) return n * scaleFactor end
local function ts(n, minSize) return math.max(minSize or 10, math.floor(n * scaleFactor)) end

-- Palette Aurora
local CYAN = Color3.fromRGB(0, 229, 255)
local VIOLET = Color3.fromRGB(124, 77, 255)
local PINK = Color3.fromRGB(255, 77, 158)
local WHITE = Color3.fromRGB(240, 248, 255)

local splashActive = true

-- ==========================================
-- AURORA RIBBONS (pita cahaya melayang)
-- ==========================================
local ribbonData = {
    { color1 = CYAN,   color2 = VIOLET, rot = -12, yPos = 0.30 },
    { color1 = VIOLET, color2 = PINK,   rot = 8,   yPos = 0.52 },
    { color1 = PINK,   color2 = CYAN,   rot = -5,  yPos = 0.70 },
}

local ribbons = {}
for i, data in ipairs(ribbonData) do
    local ribbon = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, data.yPos, 0),
        Size = UDim2.fromOffset(sc(1400), sc(140)),
        BackgroundColor3 = data.color1,
        BackgroundTransparency = 0.82, -- sedikit lebih jelas di atas background gelap
        BorderSizePixel = 0,
        Rotation = data.rot,
        ZIndex = 12,
        Parent = content
    })
    new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = ribbon })
    new("UIGradient", {
        Color = ColorSequence.new(data.color1, data.color2),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.2),
            NumberSequenceKeypoint.new(0.7, 0.2),
            NumberSequenceKeypoint.new(1, 1),
        }),
        Rotation = 90,
        Parent = ribbon
    })
    table.insert(ribbons, ribbon)
end

-- Drift ribbons pelan
task.spawn(function()
    while splashActive and gui.Parent do
        for i, ribbon in ipairs(ribbons) do
            tween(ribbon, {
                Position = UDim2.new(0.5 + (i % 2 == 0 and 0.06 or -0.06), 0, ribbon.Position.Y.Scale - 0.03, 0),
                Rotation = ribbon.Rotation + 3
            }, 3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        end
        task.wait(3)
        if not (splashActive and gui.Parent) then break end
        for i, ribbon in ipairs(ribbons) do
            tween(ribbon, {
                Position = UDim2.new(0.5 - (i % 2 == 0 and 0.06 or -0.06), 0, ribbon.Position.Y.Scale + 0.03, 0),
                Rotation = ribbon.Rotation - 3
            }, 3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        end
        task.wait(3)
    end
end)

-- ==========================================
-- STARDUST PARTICLES (partikel melayang naik)
-- ==========================================
local particlesContainer = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 13,
    Parent = content
})

local particles = {}
local particleColors = { CYAN, VIOLET, PINK, WHITE }

local function spawnParticle()
    local size = math.random(2, 5)
    local p = new("Frame", {
        Size = UDim2.fromOffset(size, size),
        BackgroundColor3 = particleColors[math.random(1, #particleColors)],
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 13,
        Parent = particlesContainer
    })
    new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = p })
    table.insert(particles, p)
    return p
end

local function animateParticle(p)
    while splashActive and p.Parent do
        local startX = math.random(0, math.floor(viewport.X))
        local startY = math.random(math.floor(viewport.Y * 0.4), math.floor(viewport.Y))
        p.Position = UDim2.fromOffset(startX, startY)
        p.BackgroundTransparency = 1

        tween(p, { BackgroundTransparency = 0.1 }, 0.6) -- sedikit lebih terang di atas dark bg
        tween(p, {
            Position = UDim2.fromOffset(startX + math.random(-80, 80), startY - math.random(200, 450))
        }, math.random(3, 6), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        task.wait(math.random(24, 48) / 10)
        tween(p, { BackgroundTransparency = 1 }, 1.2)
        task.wait(1.3)
    end
end

for i = 1, 45 do
    local p = spawnParticle()
    task.spawn(function()
        task.wait(math.random() * 2)
        animateParticle(p)
    end)
end

-- ==========================================
-- CORNER BRACKETS (bingkai HUD sci-fi)
-- ==========================================
local function makeBracket(posX, posY, flipX, flipY)
    local holder = new("Frame", {
        AnchorPoint = Vector2.new(flipX == 1 and 1 or 0, flipY == 1 and 1 or 0),
        Position = UDim2.new(posX, flipX == 1 and -sc(28) or sc(28), posY, flipY == 1 and -sc(28) or sc(28)),
        Size = UDim2.fromOffset(sc(46), sc(46)),
        BackgroundTransparency = 1,
        ZIndex = 14,
        Parent = content
    })
    local h = new("Frame", {
        Size = UDim2.new(1, 0, 0, sc(3)),
        Position = UDim2.new(0, 0, flipY == 1 and 1 or 0, flipY == 1 and -sc(3) or 0),
        BackgroundColor3 = CYAN,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = holder
    })
    local v = new("Frame", {
        Size = UDim2.new(0, sc(3), 1, 0),
        Position = UDim2.new(flipX == 1 and 1 or 0, flipX == 1 and -sc(3) or 0, 0, 0),
        BackgroundColor3 = CYAN,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 14,
        Parent = holder
    })
    return holder, h, v
end

local bracketParts = {}
for _, cfg in ipairs({
    { 0, 0, 0, 0 },
    { 1, 0, 1, 0 },
    { 0, 1, 0, 1 },
    { 1, 1, 1, 1 },
}) do
    local _, h, v = makeBracket(cfg[1], cfg[2], cfg[3], cfg[4])
    table.insert(bracketParts, h)
    table.insert(bracketParts, v)
end

-- ==========================================
-- GLASS CARD (kartu kaca di tengah)
-- ==========================================
local card = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(sc(760), sc(400)),
    BackgroundColor3 = Color3.fromRGB(8, 12, 22), -- sedikit lebih gelap agar kontras dengan background
    BackgroundTransparency = 0.25, -- lebih opaque biar terasa glass di atas dark bg
    BorderSizePixel = 0,
    ZIndex = 20,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(0, sc(18)), Parent = card })

-- ★ FIX ★: UIBlur dibuat aman. Kalau executor blokir, pakai fallback glass.
local cardBlur = tryNew("UIBlur", { Size = sc(22), Parent = card })
local glassFallback = nil

if not cardBlur then
    -- Fallback: lapisan kaca bertingkat (tanpa UIBlur tetap terlihat glassy)
    glassFallback = new("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(100, 140, 220),
        BackgroundTransparency = 0.95,
        BorderSizePixel = 0,
        ZIndex = 21,
        Parent = card
    })
    new("UICorner", { CornerRadius = UDim.new(0, sc(18)), Parent = glassFallback })
end

local cardStroke = tryNew("UIStroke", {
    Thickness = sc(1.5),
    Color = CYAN,
    Transparency = 0.3,
    Parent = card
})

if cardStroke then
    new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, CYAN),
            ColorSequenceKeypoint.new(0.5, VIOLET),
            ColorSequenceKeypoint.new(1, PINK),
        }),
        Parent = cardStroke
    })
end

local cardScale = new("UIScale", { Scale = 0.85, Parent = card })

-- Logo ZETHUB dengan gradient + shine sweep
local logo = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.20, 0),
    Size = UDim2.fromOffset(sc(520), sc(90)),
    BackgroundTransparency = 1,
    Text = "ZETHUB",
    Font = Enum.Font.GothamBlack,
    TextSize = ts(76, 32),
    TextColor3 = WHITE,
    TextTransparency = 1,
    ZIndex = 22,
    Parent = card
})

local logoGradient = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, CYAN),
        ColorSequenceKeypoint.new(0.42, VIOLET),
        ColorSequenceKeypoint.new(0.50, WHITE),
        ColorSequenceKeypoint.new(0.58, VIOLET),
        ColorSequenceKeypoint.new(1.00, PINK),
    }),
    Parent = logo
})

-- Subtitle
local subtitle = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.335, 0),
    Size = UDim2.fromOffset(sc(460), sc(26)),
    BackgroundTransparency = 1,
    Text = "Powered by Exterminate0",
    Font = Enum.Font.Gotham,
    TextSize = ts(17, 11),
    TextColor3 = Color3.fromRGB(200, 220, 245), -- sedikit lebih terang di dark bg
    TextTransparency = 1,
    ZIndex = 22,
    Parent = card
})

-- Orbit loader: ring luar + dalam berputar berlawanan
local loader = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.56, 0),
    Size = UDim2.fromOffset(sc(150), sc(150)),
    BackgroundTransparency = 1,
    ZIndex = 22,
    Parent = card
})

local outerRing = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 22,
    Parent = loader
})
local innerRing = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(sc(104), sc(104)),
    BackgroundTransparency = 1,
    ZIndex = 22,
    Parent = loader
})

local function addOrbitDots(ring, count, dotSize, color, radiusScale)
    for i = 1, count do
        local angle = (i - 1) / count * math.pi * 2
        local dot = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5 + math.cos(angle) * radiusScale, 0, 0.5 + math.sin(angle) * radiusScale, 0),
            Size = UDim2.fromOffset(sc(dotSize), sc(dotSize)),
            BackgroundColor3 = color,
            BackgroundTransparency = 1 - (i / count) * 0.9, -- ekor komet memudar
            BorderSizePixel = 0,
            ZIndex = 22,
            Parent = ring
        })
        new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = dot })
    end
end

addOrbitDots(outerRing, 10, 9, CYAN, 0.5)
addOrbitDots(innerRing, 7, 6, PINK, 0.5)

-- Percent di tengah orbit
local percent = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(sc(90), sc(40)),
    BackgroundTransparency = 1,
    Text = "0%",
    Font = Enum.Font.GothamBold,
    TextSize = ts(28, 16),
    TextColor3 = WHITE,
    TextTransparency = 1,
    ZIndex = 23,
    Parent = loader
})

-- Progress bar dengan shimmer
local barBg = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.78, 0),
    Size = UDim2.fromOffset(sc(520), sc(7)),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    ZIndex = 22,
    Parent = card
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = barBg })

local barFill = new("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = CYAN,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 23,
    Parent = barBg
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = barFill })
local barGradient = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, CYAN),
        ColorSequenceKeypoint.new(0.45, VIOLET),
        ColorSequenceKeypoint.new(0.50, WHITE),
        ColorSequenceKeypoint.new(0.55, VIOLET),
        ColorSequenceKeypoint.new(1.00, PINK),
    }),
    Parent = barFill
})

-- Status (typewriter)
local status = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.895, 0),
    Size = UDim2.fromOffset(sc(600), sc(24)),
    BackgroundTransparency = 1,
    Text = "",
    Font = Enum.Font.Code,
    TextSize = ts(15, 10),
    TextColor3 = Color3.fromRGB(180, 230, 255), -- lebih terang di dark bg
    TextTransparency = 1,
    ZIndex = 22,
    Parent = card
})

-- ==========================================
-- RESCALE (resize window PC)
-- ==========================================
local function applyScale()
    card.Size = UDim2.fromOffset(sc(760), sc(400))
    if cardStroke then cardStroke.Thickness = sc(1.5) end
    if cardBlur then cardBlur.Size = sc(22) end
    logo.Size = UDim2.fromOffset(sc(520), sc(90))
    logo.TextSize = ts(76, 32)
    subtitle.Size = UDim2.fromOffset(sc(460), sc(26))
    subtitle.TextSize = ts(17, 11)
    loader.Size = UDim2.fromOffset(sc(150), sc(150))
    innerRing.Size = UDim2.fromOffset(sc(104), sc(104))
    percent.Size = UDim2.fromOffset(sc(90), sc(40))
    percent.TextSize = ts(28, 16)
    barBg.Size = UDim2.fromOffset(sc(520), sc(7))
    status.Size = UDim2.fromOffset(sc(600), sc(24))
    status.TextSize = ts(15, 10)
end
applyScale()

camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local vp = camera.ViewportSize
    if vp.X > 100 and vp.Y > 100 then
        viewport = vp
        computeScale()
        applyScale()
    end
end)

-- ==========================================
-- ANIMASI LOOP (rotasi orbit + shine sweep)
-- ==========================================
loopTween(outerRing, { Rotation = 360 }, 7)
loopTween(innerRing, { Rotation = -360 }, 5)
-- ★ FIX ★: UIGradient.Offset bertipe Vector2, BUKAN UDim2
loopTween(logoGradient, { Offset = Vector2.new(0.8, 0) }, 2.8)
loopTween(barGradient, { Offset = Vector2.new(0.8, 0) }, 1.6)

-- Typewriter effect
local function typewriter(label, text, charsPerSec)
    label.Text = ""
    for i = 1, #text do
        if not gui.Parent then return end
        label.Text = text:sub(1, i)
        task.wait(1 / charsPerSec)
    end
end

-- ==========================================
-- ENTRANCE ANIMATION
-- ==========================================
-- Fade in overlay gelap transparan
tween(main, { BackgroundTransparency = 0.55 }, 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

tween(cardScale, { Scale = 1 }, 0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
tween(card, { BackgroundTransparency = cardBlur and 0.25 or 0.2 }, 0.6)
if cardStroke then tween(cardStroke, { Transparency = 0.25 }, 0.8) end
if glassFallback then tween(glassFallback, { BackgroundTransparency = 0.95 }, 0.8) end
tween(logo, { TextTransparency = 0 }, 0.8)
tween(subtitle, { TextTransparency = 0.1 }, 0.8)
tween(percent, { TextTransparency = 0 }, 0.8)
tween(status, { TextTransparency = 0 }, 0.8)
tween(barBg, { BackgroundTransparency = 0.88 }, 0.6)
tween(barFill, { BackgroundTransparency = 0 }, 0.6)

for _, part in ipairs(bracketParts) do
    tween(part, { BackgroundTransparency = 0.1 }, 0.7)
end

task.wait(0.4)

-- Preload Rayfield
local Rayfield = nil
local rayfieldReady = false

task.spawn(function()
    local ok, result = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    if ok then
        Rayfield = result
    end
    rayfieldReady = true
end)

-- ==========================================
-- LOADING FLOW
-- ==========================================
local messages = {
    "> BOOTING API CORE...",
    "> INJECTING MODULES...",
    "> SYNCING INTERFACE...",
    "> CALIBRATING VISUAL FX...",
    "> LOADING INTERFACE...",
    "> FINALIZING..."
}

local progress = 0
local function setProgress(value)
    value = math.clamp(value, 0, 100)
    tween(barFill, { Size = UDim2.fromScale(value / 100, 1) }, 0.2)
    percent.Text = math.floor(value) .. "%"
end

for _, msg in ipairs(messages) do
    task.spawn(typewriter, status, msg, 40)
    for _ = 1, math.random(3, 5) do
        progress = math.min(98, progress + math.random(3, 8))
        setProgress(progress)
        task.wait(math.random(12, 22) / 98)
    end
end

setProgress(99)

while not rayfieldReady do
    task.spawn(typewriter, status, "> WAITING FOR INTERFACE...", 40)
    task.wait(3)
end

task.spawn(typewriter, status, Rayfield and "> SYSTEM OPERATIONAL" or "> SYSTEM ERROR", 40)
task.wait(1.5)

setProgress(100)

-- Klik / tombol apapun untuk lanjut, atau auto 2.5 detik
local function waitForInputOrTimeout(timeout)
    local done = false
    local conn
    conn = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            done = true
        end
    end)
    local t0 = os.clock()
    while not done and (os.clock() - t0) < timeout do
        task.wait(0.05)
    end
    conn:Disconnect()
end
waitForInputOrTimeout(2.5)

-- ==========================================
-- EXIT ANIMATION
-- ==========================================
splashActive = false

-- Card pop out dulu
tween(cardScale, { Scale = 1.08 }, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
task.wait(0.35)

-- Fade semua elemen secara generik (aman untuk semua tipe)
local fadeTime = 0.8
for _, desc in ipairs(content:GetDescendants()) do
    if desc:IsA("Frame") then
        pcall(tween, desc, { BackgroundTransparency = 1 }, fadeTime)
    elseif desc:IsA("TextLabel") then
        pcall(tween, desc, { TextTransparency = 1, TextStrokeTransparency = 1 }, fadeTime)
    elseif desc:IsA("UIStroke") then
        pcall(tween, desc, { Transparency = 1 }, fadeTime)
    end
end

-- Fade out overlay gelap (kembalikan game ke terang normal sebelum destroy)
tween(main, { BackgroundTransparency = 1 }, fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

task.wait(fadeTime + 0.3)
gui:Destroy()

-- ==========================================
-- EXECUTE CUSTOM SCRIPT (RAYFIELD / UI)
-- ==========================================
local success, errorMessage = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/eaDnYiUk-CheckingV2.luau"))()
end)

if not success then
    warn("[System] Failed to load script:", errorMessage)
end
