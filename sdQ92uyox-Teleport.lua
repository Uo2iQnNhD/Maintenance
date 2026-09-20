-- ==========================================
-- SERVICES
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer

-- ==========================================
-- UI SETUP (Modal Library)
-- ==========================================
local Modal = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/izoTQhvzLib/refs/heads/main/Maintance"))()
local Window = Modal:CreateWindow({
    Title = "ZETHUB | Teleport",
    SubTitle = "By Zeutronxsite",
    Size = UDim2.fromOffset(400, 400),
    MinimumSize = Vector2.new(250, 200),
    Transparency = 0,
    Icon = "rbxassetid://68073547",
})

-- ==========================================
-- VARIABEL KONTROL
-- ==========================================
local currentTween = nil
local currentLoopActive = false
local selectedPlayerName = nil

-- ==========================================
-- FUNGSI: Ambil Daftar Player (Kecuali LocalPlayer)
-- ==========================================
local function getPlayerList()
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp then
            table.insert(list, player.Name)
        end
    end
    
    if #list == 0 then
        table.insert(list, "No Players Available")
    end
    
    table.sort(list)
    return list
end

-- ==========================================
-- FUNGSI: Teleport ke Player (TweenService + Spam 7 Detik)
-- ==========================================
local function teleportToPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if not targetPlayer or not targetPlayer.Character then
        Window:Notify({
            Title = "Error",
            Description = "Player not found",
            Duration = 3,
            Type = "Error"
        })
        return
    end
    
    local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then
        Window:Notify({
            Title = "Error",
            Description = "Target HumanoidRootPart not found",
            Duration = 3,
            Type = "Error"
        })
        return
    end

    if currentTween then
        pcall(function() currentTween:Cancel() end)
        currentTween = nil
    end
    
    if currentLoopActive then
        currentLoopActive = false
        task.wait(0.1)
    end

    local char = lp.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    currentLoopActive = true
    local startTime = tick()
    
    Window:Notify({
        Title = "Teleport Started",
        Description = "Teleporting to " .. playerName,
        Duration = 3,
        Type = "Info"
    })

    task.spawn(function()
        while currentLoopActive and (tick() - startTime < 10) do
            if not hrp.Parent or not targetHRP.Parent then 
                currentLoopActive = false
                break 
            end
            
            local targetCFrame = targetHRP.CFrame + targetHRP.CFrame.RightVector * 3
            
            currentTween = TweenService:Create(
                hrp, 
                TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                {CFrame = targetCFrame}
            )
            currentTween:Play()
            
            local completed = false
            local conn = currentTween.Completed:Connect(function()
                completed = true
                if conn then conn:Disconnect() end
            end)
            
            local waitStart = tick()
            while not completed and currentLoopActive and (tick() - startTime < 10) do
                if tick() - waitStart >= 2.5 then break end
                task.wait(0.1)
            end
            
            if conn then conn:Disconnect() end
        end
        
        currentLoopActive = false
        currentTween = nil
        
        Window:Notify({
            Title = "Teleport Complete",
            Description = "Successfully teleported to " .. playerName,
            Duration = 3,
            Type = "Success"
        })
    end)
end

-- ==========================================
-- TAB: TELEPORT
-- ==========================================
local TeleportTab = Window:AddTab("Teleport")

TeleportTab:New("Title")({
    Title = "Player Teleport"
})

-- Dropdown untuk memilih player
local PlayerDropdown = TeleportTab:New("Dropdown")({
    Title = "Select Player",
    Description = "Choose a player to teleport to",
    Options = getPlayerList(),
    Default = "No Players Available",
    Callback = function(Value)
        selectedPlayerName = Value
    end,
})

-- Button 1: Go to Player
TeleportTab:New("Button")({
    Title = "Go to Player",
    Description = "Teleport to selected player (2.5s Teleport, 10s spam)",
    Callback = function()
        if selectedPlayerName and selectedPlayerName ~= "No Players Available" then
            teleportToPlayer(selectedPlayerName)
        else
            Window:Notify({
                Title = "Warning",
                Description = "Select a player first!",
                Duration = 3,
                Type = "Warning"
            })
        end
    end,
})

-- Button 2: Refresh Player List
TeleportTab:New("Button")({
    Title = "Refresh Player List",
    Description = "Update the player list",
    Callback = function()
        local newList = getPlayerList()
        PlayerDropdown:SetOptions(newList)
        
        Window:Notify({
            Title = "Refreshed",
            Description = "Player list updated! Total: " .. #newList .. " players",
            Duration = 3,
            Type = "Success"
        })
    end,
})

-- ==========================================
-- TAB: SETTINGS
-- ==========================================
local Settings = Window:AddTab("Settings")

Settings:New("Title")({
    Title = "Themes"
})

Settings:New("Dropdown")({
    Title = "Theme",
    Description = "Default theme options",
    Options = { "Light", "Dark", "Midnight", "Rose", "Emerald" },
    Default = "Rose",
    Callback = function(Theme)
        Window:SetTheme(Theme)
    end,
})

Settings:New("Button")({
    Title = "Destroy GUI",
    Description = "Click to get rid of the UI (can't be brought back)",
    Callback = function()
        Window:Destroy()
    end,
})

Window:SetTab("Teleport")
Window:SetTheme("Rose")
