local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ZETHUB | TLK PRISON | V-MAX",
   Icon = "user",
   LoadingTitle = "Loading......",
   LoadingSubtitle = "by Zeutronxsite",
   ShowText = "Interface", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "DarkBlue",

-- Toggle HIde UI in PC
   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

-- Disable RayfieldSettings
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Zenhubxsite File"
   },
})

-- Notification Rayfield
Rayfield:Notify({
   Title = "📢 Notification Alert",
   Content = "- Thank you for using this script\n- This script is still in beta stage so there are many bugs",
   Duration = 5,
   Image = "megaphone",
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay",
         Callback = function()
      end
   },
},
})

-- Name Scripts/Local Script
local Change = Window:CreateTab("Changelog", "newspaper")
local MainTab = Window:CreateTab("Attack", "swords")
local Buff = Window:CreateTab("Buffer", "gauge")
local Bypass = Window:CreateTab("Anti Cheat Bypass", "shield-alert")
local Team = Window:CreateTab("Team & Esp", "users")
local Other = Window:CreateTab("Scripts & Tools", "wrench")
local Target = Window:CreateTab("Target & Player", "crosshair")
local Theme = Window:CreateTab("Theme & Teleport", "palette")
local Misc = Window:CreateTab("Creadits", "flame")

-- ==========================================
-- UI TABS & SECTIONS
-- ==========================================

local MainSection = Change:CreateSection("Recent Updates")
local Paragraph = Change:CreateParagraph({Title = "✅ VERSION MAXIMUM", Content = "- [+] Remake System Checking For Mobile\n- [+] Fixed Some Bugs\n- [+] Add More Details\n- [+] Add Destroy UI\n- [+] Add More Information\n- [+] Add New System Checking For Computer\n- [NEW] More Details"})
local Paragraph = Change:CreateParagraph({Title = "✅ FINAL UPDATED (Will no longer be Updated)", Content = "- [+] Add More Details\n- [+] Changes Icon And Image\n- [+] Fixed Some Bugs\n- [+] Fixed Choose Team Bugs\n- [+] Fixed Cframe Fly Bug On Mobile\n- [=] Deleted System Checking Mobile & Computer\n- [+] Fixed UI Not Show Slider, Toggle, Section And More"})

local MainSection = MainTab:CreateSection("Main Script Toggle")
local Paragraph = MainTab:CreateParagraph({Title = "📢 INFORMATION", Content = "Auto Attack & Auto Heal Working Now, Keybind One Hit (F) moved to the target tab"})

-- ==========================================
-- LOCAL SCRIPTS & SERVICE
-- ==========================================
-- Script Auto Attack
local Plr = game:GetService("Players").LocalPlayer

workspace.FallenPartsDestroyHeight = -50000

-- Daftar item yang diabaikan (Bukan senjata / Tool pendukung)
local IgnoredItems = {
    -- Makanan & Minuman
    ["Drink"] = true, 
    ["Doughnut"] = true, 
    ["Hamburger"] = true, 
    ["Food"] = true, 
    ["Subway"] = true,
    
    -- Benda lain / Non-Weapon
    ["KeyCard"] = true, 
    ["BallNChainTool"] = true, 
    ["Broom"] = true, 
    ["BlindFold"] = true, 
    ["Rope"] = true, 
    ["Handcuffs (fugitive)"] = true, 
    ["Flashlight"] = true, 
    ["Board"] = true, 
    ["Grab"] = true
}

-- ==========================================
-- AUTO ATTACK (CONTINUOUS LOOP)
-- ==========================================
local IsAutoAttacking = false

-- Catatan: Pastikan variabel 'MainTab' sudah didefinisikan di script GUI utama kamu
local Toggle = MainTab:CreateToggle({
    Name = "Auto Attack (Working)",
    CurrentValue = false,
    Flag = "Auto Attack",
    Callback = function(value)
        IsAutoAttacking = value
        
        if value then
            -- Memulai thread looping saat toggle ON
            task.spawn(function()
                while IsAutoAttacking do
                    pcall(function()
                        if Plr.Character and Plr.Backpack then
                            
                            -- 1. Equip tool dari Backpack ke Character (Kecuali yang ada di IgnoredItems)
                            for _, tool in pairs(Plr.Backpack:GetChildren()) do
                                if tool:IsA("Tool") and not IgnoredItems[tool.Name] then
                                    tool.Parent = Plr.Character
                                end
                            end
                            
                            -- 2. Auto click/attack SEMUA tool yang ada di Character (Kecuali yang ada di IgnoredItems)
                            for _, tool in pairs(Plr.Character:GetChildren()) do
                                if tool:IsA("Tool") and not IgnoredItems[tool.Name] then
                                    tool:Activate()
                                end
                            end
                            
                        end
                    end)
                    
                    task.wait(0.1) -- Delay kecil agar tidak membuat game lag/crash
                end
            end)
        end
        -- Jika value = false, loop akan otomatis berhenti karena kondisi "while IsAutoAttacking" menjadi false
    end,
})


-- ==========================================
-- PERBAIKAN AUTO HEAL (CONTINUOUS LOOP)
-- ==========================================
-- Script Auto Heal
local Plr = game:GetService("Players").LocalPlayer

-- Daftar makanan yang boleh digunakan untuk heal (Whitelist)
local FoodList = {
    "Drink", 
    "Doughnut", 
    "Hamburger", 
    "Food", 
    "Subway"
}

-- Konversi ke dictionary untuk pengecekan lebih cepat
local AllowedFood = {}
for _, foodName in ipairs(FoodList) do
    AllowedFood[foodName] = true
end

-- ==========================================
-- AUTO HEAL (CONTINUOUS LOOP)
-- ==========================================
local IsAutoHealing = false

local Toggle = MainTab:CreateToggle({
    Name = "Auto Heal (Working)",
    CurrentValue = false,
    Flag = "Auto Heal",
    Callback = function(value)
        IsAutoHealing = value
        
        if value then
            task.spawn(function()
                while IsAutoHealing do
                    pcall(function()
                        local char = Plr.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        
                        if hum and hum.Health > 0 then
                            
                            -- Cek apakah darah masih belum full
                            if hum.Health < hum.MaxHealth then
                                
                                -- 1. Cari makanan yang sedang di-equip di character
                                local equippedFood = nil
                                for _, tool in pairs(char:GetChildren()) do
                                    if tool:IsA("Tool") and AllowedFood[tool.Name] then
                                        equippedFood = tool
                                        break
                                    end
                                end
                                
                                if equippedFood then
                                    -- 2. Auto clicker: klik makanan berkali-kali sampai habis atau HP full
                                    while IsAutoHealing 
                                          and equippedFood.Parent == char 
                                          and hum.Health < hum.MaxHealth 
                                          and hum.Health > 0 do
                                        
                                        equippedFood:Activate()
                                        task.wait(0.1) -- Klik cepat setiap 0.1 detik
                                    end
                                else
                                    -- 3. Tidak ada makanan di character, cari di backpack dan equip 1 saja
                                    for _, tool in pairs(Plr.Backpack:GetChildren()) do
                                        if tool:IsA("Tool") and AllowedFood[tool.Name] then
                                            tool.Parent = char
                                            break -- Equip 1 makanan saja
                                        end
                                    end
                                end
                                
                            else
                                -- 4. Darah sudah full, auto unequip semua makanan dari character
                                for _, tool in pairs(char:GetChildren()) do
                                    if tool:IsA("Tool") and AllowedFood[tool.Name] then
                                        tool.Parent = Plr.Backpack
                                    end
                                end
                            end
                            
                        end
                    end)
                    
                    task.wait(0.1) -- Delay kecil untuk responsif
                end
            end)
        end
    end,
})

-- ==========================================
-- AUTO DROP FOOD (ZENHUB)
-- ==========================================

-- Daftar makanan yang akan di-drop (Whitelist)
local FoodList = {
    ["Subway"] = true,
    ["Food"] = true,
    ["Hamburger"] = true,
    ["Doughnut"] = true,
    ["Drink"] = true
}

-- Variabel untuk mengontrol status toggle
local autoDropFoodActive = false

-- Keybind untuk Auto Drop Food
local Keybind = MainTab:CreateKeybind({
    Name = "Auto Drop (Food)",
    CurrentKeybind = "G",
    HoldToInteract = false,
    Flag = "AutoDropFood",
    Callback = function()
        -- Toggle status ON/OFF setiap kali keybind ditekan
        autoDropFoodActive = not autoDropFoodActive
        
        -- Tampilkan notifikasi sesuai status
        if autoDropFoodActive then
            Rayfield:Notify({
                Title = "✅ Information",
                Content = "Auto Drop Food: ON",
                Duration = 5,
                Image = "check",
            })
        else
            Rayfield:Notify({
                Title = "❌ Information",
                Content = "Auto Drop Food: OFF",
                Duration = 5,
                Image = "x",
            })
        end
    end,
})

-- Script Auto Drop (berjalan di background menggunakan spawn agar GUI tidak freeze)
spawn(function()
    local lp = game:GetService("Players").LocalPlayer
    
    while wait(0.5) do -- Looping terus menerus dengan jeda 0.5 detik
        if autoDropFoodActive then
            
            -- Langkah 1: Pindahkan makanan dari Backpack ke Character 
            -- (Beberapa game mewajibkan tool berada di character dulu agar bisa di-drop)
            if lp.Backpack then
                for _, item in pairs(lp.Backpack:GetChildren()) do 
                    if item:IsA("Tool") and FoodList[item.Name] then 
                        item.Parent = lp.Character 
                    end 
                end
            end
            
            wait(0.1) -- Delay kecil agar game sempat memproses perpindahan item
            
            -- Langkah 2: Jatuhkan makanan dari Character ke Workspace
            if lp.Character then
                for _, item in pairs(lp.Character:GetChildren()) do 
                    if item:IsA("Tool") and FoodList[item.Name] then 
                        item.Parent = workspace 
                    end 
                end
            end
            
        end
    end
end)

-- ==========================================
-- AUTO DROP FOOD (ZENHUB)
-- ==========================================

-- Daftar makanan yang akan di-drop (Whitelist)
local FoodList = {
    ["Flashlight"] = true,
}

-- Variabel untuk mengontrol status toggle
local autoDropFoodActive = false

-- Keybind untuk Auto Drop Food
local Keybind = MainTab:CreateKeybind({
    Name = "Auto Drop (Flashlight)",
    CurrentKeybind = "H",
    HoldToInteract = false,
    Flag = "AutoDropFlash",
    Callback = function()
        -- Toggle status ON/OFF setiap kali keybind ditekan
        autoDropFoodActive = not autoDropFoodActive
        
        -- Tampilkan notifikasi sesuai status
        if autoDropFoodActive then
            Rayfield:Notify({
                Title = "✅ Information",
                Content = "Auto Drop Flashlight: ON",
                Duration = 5,
                Image = "check",
            })
        else
            Rayfield:Notify({
                Title = "❌ Information",
                Content = "Auto Drop Flashlight: OFF",
                Duration = 5,
                Image = "x",
            })
        end
    end,
})

-- Script Auto Drop (berjalan di background menggunakan spawn agar GUI tidak freeze)
spawn(function()
    local lp = game:GetService("Players").LocalPlayer
    
    while wait(0.5) do -- Looping terus menerus dengan jeda 0.5 detik
        if autoDropFoodActive then
            
            -- Langkah 1: Pindahkan makanan dari Backpack ke Character 
            -- (Beberapa game mewajibkan tool berada di character dulu agar bisa di-drop)
            if lp.Backpack then
                for _, item in pairs(lp.Backpack:GetChildren()) do 
                    if item:IsA("Tool") and FoodList[item.Name] then 
                        item.Parent = lp.Character 
                    end 
                end
            end
            
            wait(0.1) -- Delay kecil agar game sempat memproses perpindahan item
            
            -- Langkah 2: Jatuhkan makanan dari Character ke Workspace
            if lp.Character then
                for _, item in pairs(lp.Character:GetChildren()) do 
                    if item:IsA("Tool") and FoodList[item.Name] then 
                        item.Parent = workspace 
                    end 
                end
            end
            
        end
    end
end)

local MainSection = MainTab:CreateSection("Main Script Buttom")

local Paragraph = MainTab:CreateParagraph({Title = "⚠️ WARNING", Content = "Don't Spam Your Tool/Use Auto Click Can Get Benned!"})
local Dropdown = MainTab:CreateDropdown({
   Name = "Select Script",
   Options = {"No Cooldown Tool (Fast)", "No Cooldown Tool (Medium)", "No Cooldown Tool (Low)"},
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "Dropdown1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
    local selectedScripts = Options[1]

    if selectedScripts == "No Cooldown Tool (Fast)" then
        loadstring(game:HttpGet("https://pastebin.com/raw/uNaUfZpL"))()
    
    elseif selectedScripts == "No Cooldown Tool (Medium)" then
        loadstring(game:HttpGet("https://pastebin.com/raw/Gz3Kzh7v"))()

    elseif selectedScripts == "No Cooldown Tool (Low)" then
        loadstring(game:HttpGet("https://pastebin.com/raw/UURZKdcb"))()

       end
   end,
})


local MainSection = Bypass:CreateSection("Anti Cheat Remover/Delete")

local Paragraph = Bypass:CreateParagraph({Title = "⚠️ WARNING", Content = "Some Anti Cheats are not bypassed properly so be careful"})

local Toggle = Bypass:CreateToggle({
   Name = "Anti-Cheat Remover (Auto Bypass)",
   CurrentValue = true,
   Flag = "Anti-CheatV2",
   Callback = function()
   end,
})

local Button = Bypass:CreateButton({
    Name = "Anti-Cheat Remover (Plus)",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/c00lhaxOFFICAL/GrayScriptsAntiCheatRemoverV2PLUS/refs/heads/main/V2PLUS"))()
   end
})

local Button = Bypass:CreateButton({
    Name = "Anti-Cheat Remover (Lite)",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/c00lhaxOFFICAL/GrayScriptsAntiCheatRemoverV2LITE/refs/heads/main/GrayGrayGray"))()
   end
})

local MainSection = Bypass:CreateSection("Protection Ingame")

local Paragraph = Bypass:CreateParagraph({Title = "⚠️ WARNING", Content = "if you use Anti TP/Walkspeed script you can't use click tp and other tp"})

-- ==========================================
-- ANTI ADMIN / ANTI BANNED SYSTEM (ZENHUB)
-- DENGAN TOGGLE ON/OFF
-- ==========================================

local AdminIds = {
    10845349168, -- @Neonkoot38
    2379898542,  -- @jolyjoes
    9723024807,  -- @Zathxr
    5320250713,  -- @sqvdxs
    2502559057,  -- @OneShotArts
    310556414    -- @CuteNekoUvU
}

-- Variabel untuk mengontrol status toggle
local antiAdminActive = false

-- Fungsi untuk mengecek apakah ID pemain termasuk dalam daftar admin
local function CheckAdmin(player)
    for _, id in pairs(AdminIds) do
        if player.UserId == id then
            return true, player.Name
        end
    end
    return false
end

-- Fungsi untuk melakukan kick diri sendiri
local function KickSelf(adminName)
    Rayfield:Notify({
    Title = "⚠️ Admin Detected!",
    Content = "Admin '" .. adminName .. "' terdeteksi! Kicking to avoid ban...",
    Duration = 6,
    Image = "triangle-alert",
})
    wait(2) -- Jeda 2 detik agar notifikasi sempat terbaca sebelum kick
    game.Players.LocalPlayer:Kick("Anti-Ban System: Admin (" .. adminName .. ") Detected. Exiting to avoid a ban!")
end

-- Fungsi untuk mengecek semua pemain yang sudah ada di server
local function CheckAllPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local isAdmin, name = CheckAdmin(player)
            if isAdmin then
                KickSelf(name)
                return true
            end
        end
    end
    return false
end

-- ==========================================
-- TOGGLE ANTI-ADMIN
-- ==========================================
-- Catatan: Ganti "MainTab" dengan nama tab Anda jika ingin menaruhnya di tab lain
local Toggle = Bypass:CreateToggle({
    Name = "Admin/Dev Detection",
    CurrentValue = false,
    Flag = "AntiAdmin",
    Callback = function(Value)
        antiAdminActive = Value
        if Value then
            -- Saat toggle dinyalakan, langsung cek pemain yang sudah ada di server
            CheckAllPlayers()
            info("ZENHUB: Anti-Ban System ON - Monitoring for admins...")
        else
            info("ZENHUB: Anti-Ban System OFF")
        end
    end,
})

-- ==========================================
-- DETEKSI PEMAIN BARU JOIN (SELALU AKTIF DI BACKGROUND)
-- ==========================================
game.Players.PlayerAdded:Connect(function(player)
    wait(1) -- Delay 1 detik untuk memastikan data player sudah ter-load
    if antiAdminActive then
        local isAdmin, name = CheckAdmin(player)
        if isAdmin then
            KickSelf(name)
        end
    end
end)


local Button = Bypass:CreateButton({
    Name = "Anti Fling",
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/MhJDcWjR"))()
   end
})

local Button = Bypass:CreateButton({
    Name = "Anti TP/Walkspeed",
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/VttTZyrT"))()
   end
})

local MainSection = Buff:CreateSection("Information/Guide")
local Paragraph = Buff:CreateParagraph({Title = "📢 INFORMATION", Content = "For Walkspeed and Jumppower there are several types of Anti Cheat Bypass (Just Choose One)\n- Cframe & Randomization Method = Recommended!\n- VelocityLinier & HookMetaMethod = Working, But Not Recommended!\n- [Guide] Use Alt Button On Your Keyboard For Hide/Open UI"})

local Paragraph = Buff:CreateParagraph({Title = "🛡️ SYSTEM INFORMATION", Content = "- For the velocity method, since a different approach is used, jumppower will not work\n- To revert your character to its original state when using the velocity method, simply rejoin the server"})

local MainSection = Buff:CreateSection("Walkspeed & JumpPower")
local Dropdown = Buff:CreateDropdown({
   Name = "Select Script",
   Options = {"Walk & Jump & Fly (Cframe Method)", "Walk & Jump (VelocityLinier)", "Walk & Jump (HookMetaMethod", "Walk & Jump (Randomization)"},
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "Dropdown1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
    local selectedScripts = Options[1]

    if selectedScripts == "Walk & Jump & Fly (Cframe Method)" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/s65xKCrMCframe/refs/heads/main/T7h9Q3tfmsMain"))()

    elseif selectedScripts == "Walk & Jump (VelocityLinier)" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/CvnmysQjVXLinier/refs/heads/main/Main2.lua"))()

    elseif selectedScripts == "Walk & Jump (HookMetaMethod" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/NpN75gc4NQHOOK/refs/heads/main/Main.lua"))()

    elseif selectedScripts == "Walk & Jump (Randomization)" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/7HcztJM7XHRandom/refs/heads/main/PZFEFnegiHlua"))()

       end
   end,
})


local MainSection = Team:CreateSection("Choose Team")
local Paragraph = Team:CreateParagraph({Title = "🛡️ INFORMATION", Content = "Choose Team is Fixed Now!"})

-- Pastikan 'MainTab' sudah didefinisikan sebelumnya di script Rayfield Anda
-- Contoh: local MainTab = Rayfield:CreateTab({ Name = "TLK Prison", Icon = "shield" })

local selectedTeamOption = "None (Close Tab)"

-- 1. Buat Dropdown untuk memilih Team (TLK Prison)
local TeamDropdown = Team:CreateDropdown({
    Name = "Select Team",
    Options = {
        "None", 
        "Fugitive", 
        "Prison", 
        "Police", 
        "Civilian (Client)", 
        "ADMIN (Client)", 
        "Hostage (Client)", 
        "Choosing (Client)"
    },
    CurrentOption = {"None"},
    MultipleOptions = false,
    Flag = "TLKPrisonTeamDropdown",
    Callback = function(options)
        -- Rayfield biasanya mengembalikan tabel, jadi kita ambil elemen pertama
        if type(options) == "table" and #options > 0 then
            selectedTeamOption = options[1]
        elseif type(options) == "string" then
            selectedTeamOption = options
        else
            selectedTeamOption = "None"
        end
    end,
})

-- 2. Buat Button untuk mengeksekusi perubahan Team
local ExecuteTeamButton = Team:CreateButton({
    Name = "Execute Team Change",
    Callback = function()
        -- Validasi: Pastikan pengguna memilih tim yang valid
        if selectedTeamOption == "None" or selectedTeamOption == "" then
            Rayfield:Notify({
                Title = "Action Cancelled",
                Content = "Please select a valid team from the dropdown first!",
                Duration = 5,
                Image = "triangle-alert",
            })
            return
        end

        Rayfield:Notify({
            Title = "Processing...",
            Content = "Changing team to: " .. selectedTeamOption,
            Duration = 3,
            Image = "loader",
        })

        task.wait(0.5)

        -- Services
        local Players = game:GetService("Players")
        local Teams = game:GetService("Teams")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local lp = Players.LocalPlayer

        -- Mapping nama opsi dropdown ke nama RemoteEvent dan nama Team di game
        local teamMappings = {
            ["Fugitive"] = { Remote = "ShowguiFugitive", TeamName = "Fugitive" },
            ["Prison"] = { Remote = "Showgui", TeamName = "Prison" },
            ["Police"] = { Remote = "ShowguiGuard", TeamName = "Police" },
            ["Civilian (Client)"] = { Remote = "ShowguiCivilian", TeamName = "Civilian" },
            ["ADMIN (Client)"] = { Remote = "ShowguiAdmin", TeamName = "ADMIN" },
            ["Hostage (Client)"] = { Remote = "ShowguiHostage", TeamName = "Hostage" },
            ["Choosing (Client)"] = { Remote = "ShowguiChoosing", TeamName = "Choosing" }
        }

        local mapping = teamMappings[selectedTeamOption]
        local success = false
        local message = ""

        if mapping then
            local remote = ReplicatedStorage:FindFirstChild(mapping.Remote)
            
            -- Method 1: Coba trigger RemoteEvent
            if remote and remote:IsA("RemoteEvent") then
                local fireSuccess, err = pcall(function()
                    -- Gunakan firesignal jika tersedia di executor Anda
                    if typeof(firesignal) == "function" then
                        firesignal(remote.OnClientEvent)
                    else
                        -- Fallback universal jika firesignal tidak ada
                        remote:FireServer()
                    end
                end)
                
                if fireSuccess then
                    success = true
                    message = "Successfully triggered remote for: " .. selectedTeamOption
                else
                    message = "Failed to fire signal: " .. tostring(err)
                end
            end

            -- Method 2: Fallback - Set Team langsung jika remote tidak ditemukan atau gagal
            if not success then
                local targetTeam = Teams:FindFirstChild(mapping.TeamName)
                if targetTeam then
                    lp.Team = targetTeam
                    lp.TeamColor = targetTeam.TeamColor
                    success = true
                    message = "Successfully moved to " .. mapping.TeamName .. " (Direct Method)"
                else
                    message = "Team '" .. mapping.TeamName .. "' or Remote '" .. mapping.Remote .. "' not found in game!"
                end
            end
        else
            message = "Invalid team mapping for: " .. selectedTeamOption
        end

        -- Notifikasi hasil eksekusi akhir
        if success then
            Rayfield:Notify({
                Title = "Team Change Successful",
                Content = message,
                Duration = 6,
                Image = "check",
            })
        else
            Rayfield:Notify({
                Title = "Team Change Failed",
                Content = message,
                Duration = 6,
                Image = "triangle-alert",
            })
            warn("[TLK Prison] " .. message)
        end
    end
})

local MainSection = Team:CreateSection("Esp Toggle")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local espEnabled = false
local espObjects = {} -- Menyimpan semua BillboardGui ESP
local updateConnection = nil

-- ==========================================
-- Mapping Warna Team
-- ==========================================
local function getTeamColor(player)
    local team = player.Team
    local teamName = team and team.Name or ""
    
    local teamColorMap = {
        ["Fugitive"] = Color3.fromRGB(255, 50, 50),
        ["Prison"]   = Color3.fromRGB(255, 150, 0),
        ["Police"]   = Color3.fromRGB(0, 100, 255),
        ["Civilian"] = Color3.fromRGB(50, 255, 50),
        
        -- === TEAM TAMBAHAN & DIUBAH WARNA NYA ===
        ["Hostage"]  = Color3.fromRGB(255, 0, 255),
        ["Choosing"] = Color3.fromRGB(0, 255, 255),
        ["ADMIN"]    = Color3.fromRGB(255, 215, 0),

        -- === Color Picker Team ===
        ["Red"]      = Color3.fromRGB(255, 50, 50),
        ["Blue"]     = Color3.fromRGB(50, 100, 255),
        ["Green"]    = Color3.fromRGB(50, 255, 50),
        ["Yellow"]   = Color3.fromRGB(255, 255, 50),
        ["Purple"]   = Color3.fromRGB(200, 50, 255),
        ["White"]    = Color3.fromRGB(255, 255, 255),
        ["Black"]    = Color3.fromRGB(50, 50, 50),
    }
    
    for name, color in pairs(teamColorMap) do
        if string.lower(teamName) == string.lower(name) then
            return color
        end
    end
    
    if team and team.TeamColor then
        return team.TeamColor.Color
    end
    
    return Color3.fromRGB(255, 255, 255)
end

-- ==========================================
-- Fungsi untuk Membuat ESP ke satu Player
-- ==========================================
local function createESP(targetPlayer)
    if targetPlayer == lp then return end
    
    local function setupESP(char)
        if not char then return end
        local head = char:WaitForChild("Head", 5)
        local hum = char:WaitForChild("Humanoid", 5)
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if not head or not hum or not hrp then return end
        
        local teamColor = getTeamColor(targetPlayer)
        
        -- Hapus ESP lama (mencegah duplikat)
        if head:FindFirstChild("PlayerESP_GUI") then
            head.PlayerESP_GUI:Destroy()
        end
        if char:FindFirstChild("PlayerESP_HL") then
            char.PlayerESP_HL:Destroy()
        end
        
        -- 1. Highlight (Outline Player)
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerESP_HL"
        highlight.FillColor = teamColor
        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = char
        highlight.Parent = char
        
        -- 2. BillboardGui (Wadah untuk semua info)
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "PlayerESP_GUI"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 140, 0, 60) -- Diperbesar untuk menampung info baru
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.ResetOnSpawn = false
        billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        billboard.Parent = head
        
        -- 3. Nama Player
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
        
        -- 4. Label Jarak (BARU)
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
        
        -- 5. Health Bar Background
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
        
        -- 6. Health Bar Fill
        local hpFill = Instance.new("Frame")
        hpFill.Name = "HealthFill"
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        hpFill.BorderSizePixel = 0
        hpFill.Parent = hpBg
        
        local hpCornerFill = Instance.new("UICorner")
        hpCornerFill.CornerRadius = UDim.new(0, 3)
        hpCornerFill.Parent = hpFill
        
        -- 7. Label HP (BARU) - Contoh: "HP: 100/100"
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
        
        -- 8. Label Team (BARU - opsional, agar lebih informatif)
        local teamLabel = Instance.new("TextLabel")
        teamLabel.Name = "TeamLabel"
        teamLabel.Size = UDim2.new(1, 0, 0, 10)
        teamLabel.Position = UDim2.new(0, 0, 0, 46)
        teamLabel.BackgroundTransparency = 1
        teamLabel.Text = "[" .. (targetPlayer.Team and targetPlayer.Team.Name or "No Team") .. "]"
        teamLabel.TextColor3 = teamColor
        teamLabel.TextStrokeTransparency = 0
        teamLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        teamLabel.Font = Enum.Font.Gotham
        teamLabel.TextSize = 10
        teamLabel.Parent = billboard
        
        -- Simpan referensi untuk update
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
            character = char
        }
    end
    
    if targetPlayer.Character then
        setupESP(targetPlayer.Character)
    end
    
    targetPlayer.CharacterAdded:Connect(function(char)
        if espEnabled then
            task.wait(0.5)
            setupESP(char)
        end
    end)
end

-- ==========================================
-- Fungsi Hapus Semua ESP
-- ==========================================
local function clearAllESP()
    for _, data in pairs(espObjects) do
        pcall(function()
            if data.billboard then data.billboard:Destroy() end
            if data.highlight then data.highlight:Destroy() end
        end)
    end
    espObjects = {}
end

-- ==========================================
-- Fungsi Update: HP + Jarak (Looping)
-- ==========================================
local function startUpdateLoop()
    if updateConnection then updateConnection:Disconnect() end
    
    updateConnection = RunService.RenderStepped:Connect(function()
        -- Dapatkan HRP player lokal
        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        
        for player, data in pairs(espObjects) do
            pcall(function()
                local hum = data.humanoid
                local hrp = data.hrp
                local fill = data.hpFill
                local hpLabel = data.hpLabel
                local distLabel = data.distanceLabel
                
                -- === Update HP Bar & Label ===
                if hum and fill and hpLabel and hum.Parent then
                    local currentHP = math.floor(hum.Health)
                    local maxHP = math.floor(hum.MaxHealth)
                    local percent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    
                    -- Update ukuran bar
                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    
                    -- Update teks HP: "HP: 100/100"
                    hpLabel.Text = string.format("HP: %d/%d", currentHP, maxHP)
                    
                    -- Warna bar berubah: Hijau -> Kuning -> Merah
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
                
                -- === Update Jarak (Meter) ===
                if myHRP and hrp and hrp.Parent and distLabel then
                    local distance = (myHRP.Position - hrp.Position).Magnitude
                    
                    -- Format jarak bulat
                    distLabel.Text = string.format("[%dm]", math.floor(distance))
                    
                    -- Warna jarak: Merah (dekat), Kuning (sedang), Putih (jauh)
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

-- ==========================================
-- Fungsi Toggle ESP ON/OFF
-- ==========================================
local function toggleESP(state)
    espEnabled = state
    
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= lp then
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

-- ==========================================
-- Handle Player Baru Join / Leave
-- ==========================================
Players.PlayerAdded:Connect(function(player)
    if espEnabled and player ~= lp then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        pcall(function()
            if espObjects[player].billboard then espObjects[player].billboard:Destroy() end
            if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
        end)
        espObjects[player] = nil
    end
end)

-- ==========================================
-- UI Toggle (ESP Player)
-- ==========================================
local Toggle = Team:CreateToggle({
   Name = "ESP Player",
   CurrentValue = false,
   Flag = "ESPPlayerToggle",
   Callback = function(Value)
       toggleESP(Value)
   end,
})

-- ==========================================
-- Inisialisasi Awal
-- ==========================================
if lp.Character then
    -- Siap pakai, tinggal toggle untuk aktifkan
end

-- ==========================================
-- Tool ESP (Working) - Dengan Highlight
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local lp = Players.LocalPlayer

-- ==========================================
-- Daftar Tool/Senjata (Hanya yang ada di sini yang akan di-ESP)
-- ==========================================
local toolInfo = {
    ["Pickaxe"]     = { color = Color3.fromRGB(255, 200, 0),   icon = "⛏️" },
    ["Axe"]         = { color = Color3.fromRGB(139, 69, 19),   icon = "🪓" },
    ["PoliceBaton"] = { color = Color3.fromRGB(0, 100, 255),   icon = "👮" },
    ["Shovel"]      = { color = Color3.fromRGB(160, 82, 45),   icon = "🔨" },
    ["Pipe"]        = { color = Color3.fromRGB(150, 150, 150), icon = "🔧" },
    ["Knife"]       = { color = Color3.fromRGB(220, 220, 220), icon = "🔪" },
    ["Crowbar"]     = { color = Color3.fromRGB(255, 80, 80),   icon = "🔴" },
    ["Bat"]         = { color = Color3.fromRGB(101, 67, 33),   icon = "🏏" },
    ["Musket"]      = { color = Color3.fromRGB(80, 80, 80),    icon = "🔫" },
    ["StopSign"]    = { color = Color3.fromRGB(255, 0, 0),     icon = "🛑" },
    ["AK-47"]       = { color = Color3.fromRGB(255, 128, 0),   icon = "❓" },
    ["SprayPaint"]  = { color = Color3.fromRGB(252, 3, 248),   icon = "🎨" },
    ["Taser"]       = { color = Color3.fromRGB(97, 94, 255),   icon = "🔦" },
    ["Screwdriver"] = { color = Color3.fromRGB(180, 180, 180), icon = "⚙️" },
    ["Pliers"]      = { color = Color3.fromRGB(200, 50, 50),   icon = "🔧" },
    ["Handsaw"]     = { color = Color3.fromRGB(139, 90, 43),   icon = "🔩" },
    ["Hammer"]      = { color = Color3.fromRGB(101, 67, 33),   icon = "🔨" },
}

-- ==========================================
-- Variabel ESP
-- ==========================================
local espEnabled = false
local toolESP = {}
local updateConnection = nil
local listenerConnected = false

-- ==========================================
-- Fungsi: Cek apakah item adalah tool/senjata yang terdaftar
-- ==========================================
local function isRegisteredTool(item)
    if not item then return false end
    return toolInfo[item.Name] ~= nil
end

-- ==========================================
-- Fungsi: Cari Handle/Part yang bisa dijadikan anchor
-- ==========================================
local function findAnchorPart(item)
    if item:IsA("Tool") then
        local handle = item:FindFirstChild("Handle")
        if handle and handle:IsA("BasePart") then
            return handle
        end
    end
    
    if item:IsA("Model") then
        local handle = item:FindFirstChild("Handle", true)
        if handle and handle:IsA("BasePart") then
            return handle
        end
        if item.PrimaryPart then
            return item.PrimaryPart
        end
        for _, child in ipairs(item:GetDescendants()) do
            if child:IsA("BasePart") then
                return child
            end
        end
    end
    
    if item:IsA("BasePart") then
        return item
    end
    
    return nil
end

-- ==========================================
-- Fungsi: Buat ESP untuk satu Tool
-- ==========================================
local function createToolESP(tool)
    if not tool or toolESP[tool] then return end
    if not isRegisteredTool(tool) then return end
    
    local anchor = findAnchorPart(tool)
    if not anchor then return end
    
    local toolName = tool.Name
    local info = toolInfo[toolName]
    
    -- ==========================================
    -- 1. HIGHLIGHT (Outline Tool)
    -- ==========================================
    local highlight = Instance.new("Highlight")
    highlight.Name = "ToolESP_HL"
    highlight.FillColor = info.color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = tool -- Highlight menempel ke tool/model
    highlight.Parent = tool
    
    -- ==========================================
    -- 2. BILLBOARD GUI (Nama + Jarak)
    -- ==========================================
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ToolESP_GUI"
    billboard.Adornee = anchor
    billboard.Size = UDim2.new(0, 100, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.ResetOnSpawn = false
    billboard.LightInfluence = 0
    billboard.Parent = anchor
    
    -- Nama Tool
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 12)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = info.icon .. " " .. toolName
    nameLabel.TextColor3 = info.color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 11
    nameLabel.Parent = billboard
    
    -- Jarak
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0, 12)
    distLabel.Position = UDim2.new(0, 0, 0, 12)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "[0m]"
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextSize = 10
    distLabel.Parent = billboard
    
    -- Simpan semua referensi
    toolESP[tool] = {
        billboard = billboard,
        highlight = highlight,
        distLabel = distLabel,
        anchor = anchor
    }
end

-- ==========================================
-- Fungsi: Hapus ESP dari satu Tool
-- ==========================================
local function removeToolESP(tool)
    if toolESP[tool] then
        pcall(function()
            if toolESP[tool].billboard then
                toolESP[tool].billboard:Destroy()
            end
            if toolESP[tool].highlight then
                toolESP[tool].highlight:Destroy()
            end
        end)
        toolESP[tool] = nil
    end
end

-- ==========================================
-- Fungsi: Hapus Semua ESP
-- ==========================================
local function clearAllToolESP()
    for tool, _ in pairs(toolESP) do
        removeToolESP(tool)
    end
end

-- ==========================================
-- Fungsi: Scan semua tool di folder Tools
-- ==========================================
local function scanAllTools()
    local toolsFolder = Workspace:FindFirstChild("Tools")
    if not toolsFolder then return 0 end
    
    local count = 0
    for _, item in ipairs(toolsFolder:GetChildren()) do
        if isRegisteredTool(item) then
            createToolESP(item)
            if toolESP[item] then count = count + 1 end
        end
    end
    
    info("[ESP] Scan complete. Number of tools detected: " .. count)
    return count
end

-- ==========================================
-- Loop Update Jarak
-- ==========================================
local function startUpdateLoop()
    if updateConnection then updateConnection:Disconnect() end
    
    updateConnection = RunService.RenderStepped:Connect(function()
        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end
        
        local toRemove = {}
        
        for tool, data in pairs(toolESP) do
            local success = pcall(function()
                local anchor = data.anchor
                local distLabel = data.distLabel
                local highlight = data.highlight
                
                -- Cek apakah tool masih ada
                if not anchor or not anchor.Parent or not tool.Parent then
                    table.insert(toRemove, tool)
                    return
                end
                
                -- Update jarak
                local distance = (myHRP.Position - anchor.Position).Magnitude
                distLabel.Text = string.format("[%dm]", math.floor(distance))
                
                -- Warna jarak adaptif
                if distance < 10 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                elseif distance < 30 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                else
                    distLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                end
                
                -- Pastikan highlight tetap visible
                if highlight and highlight.Parent then
                    highlight.Enabled = true
                end
            end)
            
            if not success then
                table.insert(toRemove, tool)
            end
        end
        
        -- Hapus ESP dari tool yang sudah tidak ada
        for _, tool in ipairs(toRemove) do
            removeToolESP(tool)
        end
    end)
end

-- ==========================================
-- Deteksi Tool Baru / Tool Hilang
-- ==========================================
local function setupToolFolderListener()
    if listenerConnected then return end
    
    local toolsFolder = Workspace:FindFirstChild("Tools")
    if not toolsFolder then return end
    
    toolsFolder.ChildAdded:Connect(function(child)
        if not espEnabled then return end
        if isRegisteredTool(child) then
            task.wait(0.2)
            createToolESP(child)
        end
    end)
    
    toolsFolder.ChildRemoved:Connect(function(child)
        if toolESP[child] then
            removeToolESP(child)
        end
    end)
    
    listenerConnected = true
end

-- ==========================================
-- Toggle ESP ON/OFF
-- ==========================================
local function toggleToolESP(state)
    espEnabled = state
    
    if state then
        local toolsFolder = Workspace:FindFirstChild("Tools")
        if not toolsFolder then
            toolsFolder = Workspace:WaitForChild("Tools", 15)
        end
        
        if toolsFolder then
            scanAllTools()
            setupToolFolderListener()
            startUpdateLoop()
        end
    else
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        clearAllToolESP()
    end
end

-- ==========================================
-- UI Toggle (ESP Tools)
-- ==========================================
local Toggle = Team:CreateToggle({
   Name = "ESP Tools",
   CurrentValue = false,
   Flag = "ESPToolsToggle",
   Callback = function(Value)
       toggleToolESP(Value)
   end,
})

-- ==========================================
-- Tool ESP (Working) - Dengan Highlight
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local lp = Players.LocalPlayer

-- ==========================================
-- Daftar Tool/Senjata (Hanya yang ada di sini yang akan di-ESP)
-- ==========================================
local toolInfo = {
    ["Drink"]    = { color = Color3.fromRGB(100, 200, 255), icon = "🥤" },
    ["Doughnut"] = { color = Color3.fromRGB(255, 150, 200), icon = "🍩" },
    ["Hamburger"]= { color = Color3.fromRGB(255, 180, 50),  icon = "🍔" },
    ["Food"]     = { color = Color3.fromRGB(255, 100, 100), icon = "🍱" },
    ["Subway"]   = { color = Color3.fromRGB(200, 255, 100), icon = "🥪" },
}

-- ==========================================
-- Variabel ESP
-- ==========================================
local espEnabled = false
local toolESP = {}
local updateConnection = nil
local listenerConnected = false

-- ==========================================
-- Fungsi: Cek apakah item adalah tool/senjata yang terdaftar
-- ==========================================
local function isRegisteredTool(item)
    if not item then return false end
    return toolInfo[item.Name] ~= nil
end

-- ==========================================
-- Fungsi: Cari Handle/Part yang bisa dijadikan anchor
-- ==========================================
local function findAnchorPart(item)
    if item:IsA("Tool") then
        local handle = item:FindFirstChild("Handle")
        if handle and handle:IsA("BasePart") then
            return handle
        end
    end
    
    if item:IsA("Model") then
        local handle = item:FindFirstChild("Handle", true)
        if handle and handle:IsA("BasePart") then
            return handle
        end
        if item.PrimaryPart then
            return item.PrimaryPart
        end
        for _, child in ipairs(item:GetDescendants()) do
            if child:IsA("BasePart") then
                return child
            end
        end
    end
    
    if item:IsA("BasePart") then
        return item
    end
    
    return nil
end

-- ==========================================
-- Fungsi: Buat ESP untuk satu Tool
-- ==========================================
local function createToolESP(tool)
    if not tool or toolESP[tool] then return end
    if not isRegisteredTool(tool) then return end
    
    local anchor = findAnchorPart(tool)
    if not anchor then return end
    
    local toolName = tool.Name
    local info = toolInfo[toolName]
    
    -- ==========================================
    -- 1. HIGHLIGHT (Outline Tool)
    -- ==========================================
    local highlight = Instance.new("Highlight")
    highlight.Name = "ToolESP_HL"
    highlight.FillColor = info.color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = tool -- Highlight menempel ke tool/model
    highlight.Parent = tool
    
    -- ==========================================
    -- 2. BILLBOARD GUI (Nama + Jarak)
    -- ==========================================
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ToolESP_GUI"
    billboard.Adornee = anchor
    billboard.Size = UDim2.new(0, 100, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.ResetOnSpawn = false
    billboard.LightInfluence = 0
    billboard.Parent = anchor
    
    -- Nama Tool
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 12)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = info.icon .. " " .. toolName
    nameLabel.TextColor3 = info.color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 11
    nameLabel.Parent = billboard
    
    -- Jarak
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0, 12)
    distLabel.Position = UDim2.new(0, 0, 0, 12)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "[0m]"
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextSize = 10
    distLabel.Parent = billboard
    
    -- Simpan semua referensi
    toolESP[tool] = {
        billboard = billboard,
        highlight = highlight,
        distLabel = distLabel,
        anchor = anchor
    }
end

-- ==========================================
-- Fungsi: Hapus ESP dari satu Tool
-- ==========================================
local function removeToolESP(tool)
    if toolESP[tool] then
        pcall(function()
            if toolESP[tool].billboard then
                toolESP[tool].billboard:Destroy()
            end
            if toolESP[tool].highlight then
                toolESP[tool].highlight:Destroy()
            end
        end)
        toolESP[tool] = nil
    end
end

-- ==========================================
-- Fungsi: Hapus Semua ESP
-- ==========================================
local function clearAllToolESP()
    for tool, _ in pairs(toolESP) do
        removeToolESP(tool)
    end
end

-- ==========================================
-- Fungsi: Scan semua tool di folder Tools
-- ==========================================
local function scanAllTools()
    local toolsFolder = Workspace:FindFirstChild("Tools")
    if not toolsFolder then return 0 end
    
    local count = 0
    for _, item in ipairs(toolsFolder:GetChildren()) do
        if isRegisteredTool(item) then
            createToolESP(item)
            if toolESP[item] then count = count + 1 end
        end
    end
    
    info("[ESP] Scan complete. Number of tools detected: " .. count)
    return count
end

-- ==========================================
-- Loop Update Jarak
-- ==========================================
local function startUpdateLoop()
    if updateConnection then updateConnection:Disconnect() end
    
    updateConnection = RunService.RenderStepped:Connect(function()
        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end
        
        local toRemove = {}
        
        for tool, data in pairs(toolESP) do
            local success = pcall(function()
                local anchor = data.anchor
                local distLabel = data.distLabel
                local highlight = data.highlight
                
                -- Cek apakah tool masih ada
                if not anchor or not anchor.Parent or not tool.Parent then
                    table.insert(toRemove, tool)
                    return
                end
                
                -- Update jarak
                local distance = (myHRP.Position - anchor.Position).Magnitude
                distLabel.Text = string.format("[%dm]", math.floor(distance))
                
                -- Warna jarak adaptif
                if distance < 10 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                elseif distance < 30 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                else
                    distLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                end
                
                -- Pastikan highlight tetap visible
                if highlight and highlight.Parent then
                    highlight.Enabled = true
                end
            end)
            
            if not success then
                table.insert(toRemove, tool)
            end
        end
        
        -- Hapus ESP dari tool yang sudah tidak ada
        for _, tool in ipairs(toRemove) do
            removeToolESP(tool)
        end
    end)
end

-- ==========================================
-- Deteksi Tool Baru / Tool Hilang
-- ==========================================
local function setupToolFolderListener()
    if listenerConnected then return end
    
    local toolsFolder = Workspace:FindFirstChild("Tools")
    if not toolsFolder then return end
    
    toolsFolder.ChildAdded:Connect(function(child)
        if not espEnabled then return end
        if isRegisteredTool(child) then
            task.wait(0.2)
            createToolESP(child)
        end
    end)
    
    toolsFolder.ChildRemoved:Connect(function(child)
        if toolESP[child] then
            removeToolESP(child)
        end
    end)
    
    listenerConnected = true
end

-- ==========================================
-- Toggle ESP ON/OFF
-- ==========================================
local function toggleToolESP(state)
    espEnabled = state
    
    if state then
        local toolsFolder = Workspace:FindFirstChild("Tools")
        if not toolsFolder then
            toolsFolder = Workspace:WaitForChild("Tools", 15)
        end
        
        if toolsFolder then
            scanAllTools()
            setupToolFolderListener()
            startUpdateLoop()
        end
    else
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        clearAllToolESP()
    end
end

-- ==========================================
-- UI Toggle (ESP Tools)
-- ==========================================
local Toggle = Team:CreateToggle({
   Name = "ESP Food",
   CurrentValue = false,
   Flag = "ESPToolsToggle",
   Callback = function(Value)
       toggleToolESP(Value)
   end,
})

-- ==========================================
-- Tool ESP (Working) - Dengan Highlight
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local lp = Players.LocalPlayer

-- ==========================================
-- Daftar Tool/Senjata (Hanya yang ada di sini yang akan di-ESP)
-- ==========================================
local toolInfo = {
    ["KeyCard"]             = { color = Color3.fromRGB(255, 215, 0),   icon = "🔑" },
    ["BallNChainTool"]      = { color = Color3.fromRGB(80, 80, 80),    icon = "⛓️" },
    ["Broom"]               = { color = Color3.fromRGB(160, 82, 45),   icon = "🧹" },
    ["BlindFold"]           = { color = Color3.fromRGB(50, 50, 50),    icon = "🙈" },
    ["Rope"]                = { color = Color3.fromRGB(210, 180, 140), icon = "🧶" },
    ["Handcuffs (fugitive)"]= { color = Color3.fromRGB(192, 192, 192), icon = "⛓️" },
    ["Flashlight"]          = { color = Color3.fromRGB(255, 255, 150), icon = "🔦" },
    ["Board"]               = { color = Color3.fromRGB(139, 90, 43),   icon = "🖼️" },
}

-- ==========================================
-- Variabel ESP
-- ==========================================
local espEnabled = false
local toolESP = {}
local updateConnection = nil
local listenerConnected = false

-- ==========================================
-- Fungsi: Cek apakah item adalah tool/senjata yang terdaftar
-- ==========================================
local function isRegisteredTool(item)
    if not item then return false end
    return toolInfo[item.Name] ~= nil
end

-- ==========================================
-- Fungsi: Cari Handle/Part yang bisa dijadikan anchor
-- ==========================================
local function findAnchorPart(item)
    if item:IsA("Tool") then
        local handle = item:FindFirstChild("Handle")
        if handle and handle:IsA("BasePart") then
            return handle
        end
    end
    
    if item:IsA("Model") then
        local handle = item:FindFirstChild("Handle", true)
        if handle and handle:IsA("BasePart") then
            return handle
        end
        if item.PrimaryPart then
            return item.PrimaryPart
        end
        for _, child in ipairs(item:GetDescendants()) do
            if child:IsA("BasePart") then
                return child
            end
        end
    end
    
    if item:IsA("BasePart") then
        return item
    end
    
    return nil
end

-- ==========================================
-- Fungsi: Buat ESP untuk satu Tool
-- ==========================================
local function createToolESP(tool)
    if not tool or toolESP[tool] then return end
    if not isRegisteredTool(tool) then return end
    
    local anchor = findAnchorPart(tool)
    if not anchor then return end
    
    local toolName = tool.Name
    local info = toolInfo[toolName]
    
    -- ==========================================
    -- 1. HIGHLIGHT (Outline Tool)
    -- ==========================================
    local highlight = Instance.new("Highlight")
    highlight.Name = "ToolESP_HL"
    highlight.FillColor = info.color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = tool -- Highlight menempel ke tool/model
    highlight.Parent = tool
    
    -- ==========================================
    -- 2. BILLBOARD GUI (Nama + Jarak)
    -- ==========================================
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ToolESP_GUI"
    billboard.Adornee = anchor
    billboard.Size = UDim2.new(0, 100, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.ResetOnSpawn = false
    billboard.LightInfluence = 0
    billboard.Parent = anchor
    
    -- Nama Tool
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 12)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = info.icon .. " " .. toolName
    nameLabel.TextColor3 = info.color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 11
    nameLabel.Parent = billboard
    
    -- Jarak
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0, 12)
    distLabel.Position = UDim2.new(0, 0, 0, 12)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "[0m]"
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextSize = 10
    distLabel.Parent = billboard
    
    -- Simpan semua referensi
    toolESP[tool] = {
        billboard = billboard,
        highlight = highlight,
        distLabel = distLabel,
        anchor = anchor
    }
end

-- ==========================================
-- Fungsi: Hapus ESP dari satu Tool
-- ==========================================
local function removeToolESP(tool)
    if toolESP[tool] then
        pcall(function()
            if toolESP[tool].billboard then
                toolESP[tool].billboard:Destroy()
            end
            if toolESP[tool].highlight then
                toolESP[tool].highlight:Destroy()
            end
        end)
        toolESP[tool] = nil
    end
end

-- ==========================================
-- Fungsi: Hapus Semua ESP
-- ==========================================
local function clearAllToolESP()
    for tool, _ in pairs(toolESP) do
        removeToolESP(tool)
    end
end

-- ==========================================
-- Fungsi: Scan semua tool di folder Tools
-- ==========================================
local function scanAllTools()
    local toolsFolder = Workspace:FindFirstChild("Tools")
    if not toolsFolder then return 0 end
    
    local count = 0
    for _, item in ipairs(toolsFolder:GetChildren()) do
        if isRegisteredTool(item) then
            createToolESP(item)
            if toolESP[item] then count = count + 1 end
        end
    end
    
    info("[ESP] Scan complete. Number of tools detected: " .. count)
    return count
end

-- ==========================================
-- Loop Update Jarak
-- ==========================================
local function startUpdateLoop()
    if updateConnection then updateConnection:Disconnect() end
    
    updateConnection = RunService.RenderStepped:Connect(function()
        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end
        
        local toRemove = {}
        
        for tool, data in pairs(toolESP) do
            local success = pcall(function()
                local anchor = data.anchor
                local distLabel = data.distLabel
                local highlight = data.highlight
                
                -- Cek apakah tool masih ada
                if not anchor or not anchor.Parent or not tool.Parent then
                    table.insert(toRemove, tool)
                    return
                end
                
                -- Update jarak
                local distance = (myHRP.Position - anchor.Position).Magnitude
                distLabel.Text = string.format("[%dm]", math.floor(distance))
                
                -- Warna jarak adaptif
                if distance < 10 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                elseif distance < 30 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                else
                    distLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                end
                
                -- Pastikan highlight tetap visible
                if highlight and highlight.Parent then
                    highlight.Enabled = true
                end
            end)
            
            if not success then
                table.insert(toRemove, tool)
            end
        end
        
        -- Hapus ESP dari tool yang sudah tidak ada
        for _, tool in ipairs(toRemove) do
            removeToolESP(tool)
        end
    end)
end

-- ==========================================
-- Deteksi Tool Baru / Tool Hilang
-- ==========================================
local function setupToolFolderListener()
    if listenerConnected then return end
    
    local toolsFolder = Workspace:FindFirstChild("Tools")
    if not toolsFolder then return end
    
    toolsFolder.ChildAdded:Connect(function(child)
        if not espEnabled then return end
        if isRegisteredTool(child) then
            task.wait(0.2)
            createToolESP(child)
        end
    end)
    
    toolsFolder.ChildRemoved:Connect(function(child)
        if toolESP[child] then
            removeToolESP(child)
        end
    end)
    
    listenerConnected = true
end

-- ==========================================
-- Toggle ESP ON/OFF
-- ==========================================
local function toggleToolESP(state)
    espEnabled = state
    
    if state then
        local toolsFolder = Workspace:FindFirstChild("Tools")
        if not toolsFolder then
            toolsFolder = Workspace:WaitForChild("Tools", 15)
        end
        
        if toolsFolder then
            scanAllTools()
            setupToolFolderListener()
            startUpdateLoop()
        end
    else
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        clearAllToolESP()
    end
end

-- ==========================================
-- UI Toggle (ESP Tools)
-- ==========================================
local Toggle = Team:CreateToggle({
   Name = "ESP Other",
   CurrentValue = false,
   Flag = "ESPToolsToggle",
   Callback = function(Value)
       toggleToolESP(Value)
   end,
})


local MainSection = Other:CreateSection("Script Tool")
local Paragraph = Other:CreateParagraph({Title = "📢 INFORMATION", Content = "All these scripts support this game"})

local Dropdown = Other:CreateDropdown({
   Name = "Select Script",
   Options = {"Infinite Yield", "Multi Tool", "Freecam (Mobile)", "Invisble", 
              "Noclip Tool", "Tool Giver (Client)", "Instant Click E", "Super Ring V6"},
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "Dropdown1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
    local selectedScripts = Options[1]

    if selectedScripts == "Infinite Yield" then
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
    
    elseif selectedScripts == "Multi Tool" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/MultiToolsV1/main/script"))()

    elseif selectedScripts == "Freecam (Mobile)" then
        loadstring(game:HttpGet("https://pastebin.com/raw/QsqZcTAV"))()

    elseif selectedScripts == "Invisble" then
        loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()

    elseif selectedScripts == "Noclip Tool" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IOERHUB/Noclip/refs/heads/main/Testing"))()

    elseif selectedScripts == "Tool Giver (Client)" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua"))()

    elseif selectedScripts == "Instant Click E" then
        loadstring(game:HttpGet("https://pastebin.com/raw/5qXz6a5L"))()

    elseif selectedScripts == "Super Ring V6" then
        loadstring(game:HttpGet("https://pastebin.com/raw/hhyT3gQr"))()

       end
   end,
})

local MainSection = Other:CreateSection("Teleporter Tool")
local Paragraph = Other:CreateParagraph({Title = "📢 INFORMATION", Content = "- Ensure your character is on the ground, if you are hovering, you will die due to the anti-cheat fly detection\n- The teleport duration to reach the destination is 7 seconds"})

-- ==========================================
-- SERVICES
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer

-- ==========================================
-- DAFTAR POSISI TOOL
-- ==========================================
local toolPositions = {
    ["Axe"]         = Vector3.new(206, 3, -611),
    ["PoliceBaton"] = Vector3.new(148, 3, -109),
    ["Shovel"]      = Vector3.new(292, 3, 40),
    ["Pipe"]        = Vector3.new(259, -27, -441),
    ["Knife"]       = Vector3.new(216, 16, -223),
    ["Crowbar"]     = Vector3.new(316, 4, -48),
    ["Bat"]         = Vector3.new(411, 19, -94),
    ["Musket"]      = Vector3.new(322, 3, -459),
    ["StopSign"]    = Vector3.new(551, 5, -380),
    ["AK-47"]       = Vector3.new(42, 3, -89),
    ["SprayPaint"]  = Vector3.new(335, -27, -426),
    ["Taser"]       = Vector3.new(42, 3, -93),
    ["Screwdriver"] = Vector3.new(459, -6, -88),
    ["Pliers"]      = Vector3.new(459, -6, -88),
    ["Handsaw"]     = Vector3.new(459, -6, -88),
    ["Hammer"]      = Vector3.new(459, -6, -88)
}

-- Mengambil nama-nama tool untuk Dropdown
local toolNames = {}
for name, _ in pairs(toolPositions) do
    table.insert(toolNames, name)
end
table.sort(toolNames)

-- ==========================================
-- VARIABEL KONTROL TELEPORT
-- ==========================================
local currentTween = nil
local currentLoopActive = false

-- ==========================================
-- FUNGSI TELEPORT (TweenService + Spam 7 Detik)
-- ==========================================
local function teleportToTool(toolName)
    -- Batalkan proses teleport sebelumnya jika masih berjalan
    if currentTween then
        pcall(function() currentTween:Cancel() end)
        currentTween = nil
    end
    
    -- Hentikan loop sebelumnya
    if currentLoopActive then
        currentLoopActive = false
        task.wait(0.1) -- Beri jeda agar loop lama benar-benar berhenti
    end

    local char = lp.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    local pos = toolPositions[toolName]
    if not pos then return end

    local targetCFrame = CFrame.new(pos)
    
    -- Set flag loop aktif
    currentLoopActive = true
    local startTime = tick()
    local totalDuration = 7       -- Total waktu spam: 7 detik
    local tweenDuration = 2.5     -- Durasi per tween: 1.5 detik (jangan cepat-cepat)

    task.spawn(function()
        while currentLoopActive and (tick() - startTime < totalDuration) do
            -- Cek apakah karakter masih valid
            if not hrp.Parent or not hum.Parent then 
                currentLoopActive = false
                break 
            end
            
            -- Buat tween baru dengan durasi 1.5 detik (pergerakan lambat/halus)
            local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
            currentTween:Play()
            
            -- Tunggu hingga tween selesai atau waktu total 7 detik habis
            local tweenDone = false
            local conn
            conn = currentTween.Completed:Connect(function()
                tweenDone = true
                if conn then conn:Disconnect() end
            end)
            
            -- Loop menunggu dengan interval kecil
            local waitStart = tick()
            while not tweenDone and currentLoopActive and (tick() - startTime < totalDuration) do
                task.wait(0.1)
                -- Jika waktu tunggu melebihi durasi tween, paksa keluar untuk membuat tween baru
                if tick() - waitStart >= tweenDuration then
                    break
                end
            end
            
            if conn then conn:Disconnect() end
        end
        
        -- Reset setelah 7 detik selesai
        currentLoopActive = false
        currentTween = nil
    end)
end

-- ==========================================
-- UI SETUP (Dropdown)
-- ==========================================
-- CATATAN: Pastikan variabel 'Tab' sudah didefinisikan oleh UI Library kamu.
local Dropdown = Other:CreateDropdown({
   Name = "Teleport to Tool",
   Options = toolNames,
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "ToolTeleportDropdown",
   Callback = function(Options)
       local selectedTool = Options[1]
       if selectedTool then
           teleportToTool(selectedTool)
       end
   end,
})

-- ==========================================
-- SERVICES
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer

-- ==========================================
-- DAFTAR POSISI TOOL
-- ==========================================
local toolPositions = {
    ["Hamburger"]         = Vector3.new(257, 3, -601),
    ["Doughnut"] = Vector3.new(589, 3, -326),
    ["Subway"]      = Vector3.new(394, -26, -301),
    ["Drink"]        = Vector3.new(459, 5, 32),
    ["Food"]       = Vector3.new(105, 3, -48),
}

-- Mengambil nama-nama tool untuk Dropdown
local toolNames = {}
for name, _ in pairs(toolPositions) do
    table.insert(toolNames, name)
end
table.sort(toolNames)

-- ==========================================
-- VARIABEL KONTROL TELEPORT
-- ==========================================
local currentTween = nil
local currentLoopActive = false

-- ==========================================
-- FUNGSI TELEPORT (TweenService + Spam 7 Detik)
-- ==========================================
local function teleportToTool(toolName)
    -- Batalkan proses teleport sebelumnya jika masih berjalan
    if currentTween then
        pcall(function() currentTween:Cancel() end)
        currentTween = nil
    end
    
    -- Hentikan loop sebelumnya
    if currentLoopActive then
        currentLoopActive = false
        task.wait(0.1) -- Beri jeda agar loop lama benar-benar berhenti
    end

    local char = lp.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    local pos = toolPositions[toolName]
    if not pos then return end

    local targetCFrame = CFrame.new(pos)
    
    -- Set flag loop aktif
    currentLoopActive = true
    local startTime = tick()
    local totalDuration = 7       -- Total waktu spam: 7 detik
    local tweenDuration = 2.5     -- Durasi per tween: 1.5 detik (jangan cepat-cepat)

    task.spawn(function()
        while currentLoopActive and (tick() - startTime < totalDuration) do
            -- Cek apakah karakter masih valid
            if not hrp.Parent or not hum.Parent then 
                currentLoopActive = false
                break 
            end
            
            -- Buat tween baru dengan durasi 1.5 detik (pergerakan lambat/halus)
            local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
            currentTween:Play()
            
            -- Tunggu hingga tween selesai atau waktu total 7 detik habis
            local tweenDone = false
            local conn
            conn = currentTween.Completed:Connect(function()
                tweenDone = true
                if conn then conn:Disconnect() end
            end)
            
            -- Loop menunggu dengan interval kecil
            local waitStart = tick()
            while not tweenDone and currentLoopActive and (tick() - startTime < totalDuration) do
                task.wait(0.1)
                -- Jika waktu tunggu melebihi durasi tween, paksa keluar untuk membuat tween baru
                if tick() - waitStart >= tweenDuration then
                    break
                end
            end
            
            if conn then conn:Disconnect() end
        end
        
        -- Reset setelah 7 detik selesai
        currentLoopActive = false
        currentTween = nil
    end)
end

-- ==========================================
-- UI SETUP (Dropdown)
-- ==========================================
-- CATATAN: Pastikan variabel 'Tab' sudah didefinisikan oleh UI Library kamu.
local Dropdown = Other:CreateDropdown({
   Name = "Teleport to Food",
   Options = toolNames,
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "ToolTeleportDropdown",
   Callback = function(Options)
       local selectedTool = Options[1]
       if selectedTool then
           teleportToTool(selectedTool)
       end
   end,
})

-- ==========================================
-- SERVICES
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer

-- ==========================================
-- DAFTAR POSISI TOOL
-- ==========================================
local toolPositions = {
    ["KeyCard"]             = Vector3.new(217, 31, -222),
    ["BallNChainTool"]      = Vector3.new(135, 1, -27),
    ["Broom"]               = Vector3.new(63, 3, 15),
    ["BlindFold"]           = Vector3.new(51, 3, -113),
    ["Rope"]                = Vector3.new(54, 3, -141),
    ["Handcuffs (fugitive)"]= Vector3.new(415, 19, -96),
    ["Flashlight"]          = Vector3.new(432, 19, -99),
    ["Board"]               = Vector3.new(274, 3, -104)
}

-- Mengambil nama-nama tool untuk Dropdown
local toolNames = {}
for name, _ in pairs(toolPositions) do
    table.insert(toolNames, name)
end
table.sort(toolNames)

-- ==========================================
-- VARIABEL KONTROL TELEPORT
-- ==========================================
local currentTween = nil
local currentLoopActive = false

-- ==========================================
-- FUNGSI TELEPORT (TweenService + Spam 7 Detik)
-- ==========================================
local function teleportToTool(toolName)
    -- Batalkan proses teleport sebelumnya jika masih berjalan
    if currentTween then
        pcall(function() currentTween:Cancel() end)
        currentTween = nil
    end
    
    -- Hentikan loop sebelumnya
    if currentLoopActive then
        currentLoopActive = false
        task.wait(0.1) -- Beri jeda agar loop lama benar-benar berhenti
    end

    local char = lp.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    local pos = toolPositions[toolName]
    if not pos then return end

    local targetCFrame = CFrame.new(pos)
    
    -- Set flag loop aktif
    currentLoopActive = true
    local startTime = tick()
    local totalDuration = 7       -- Total waktu spam: 7 detik
    local tweenDuration = 2.5     -- Durasi per tween: 1.5 detik (jangan cepat-cepat)

    task.spawn(function()
        while currentLoopActive and (tick() - startTime < totalDuration) do
            -- Cek apakah karakter masih valid
            if not hrp.Parent or not hum.Parent then 
                currentLoopActive = false
                break 
            end
            
            -- Buat tween baru dengan durasi 1.5 detik (pergerakan lambat/halus)
            local tweenInfo = TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
            currentTween:Play()
            
            -- Tunggu hingga tween selesai atau waktu total 7 detik habis
            local tweenDone = false
            local conn
            conn = currentTween.Completed:Connect(function()
                tweenDone = true
                if conn then conn:Disconnect() end
            end)
            
            -- Loop menunggu dengan interval kecil
            local waitStart = tick()
            while not tweenDone and currentLoopActive and (tick() - startTime < totalDuration) do
                task.wait(0.1)
                -- Jika waktu tunggu melebihi durasi tween, paksa keluar untuk membuat tween baru
                if tick() - waitStart >= tweenDuration then
                    break
                end
            end
            
            if conn then conn:Disconnect() end
        end
        
        -- Reset setelah 7 detik selesai
        currentLoopActive = false
        currentTween = nil
    end)
end

-- ==========================================
-- UI SETUP (Dropdown)
-- ==========================================
-- CATATAN: Pastikan variabel 'Tab' sudah didefinisikan oleh UI Library kamu.
local Dropdown = Other:CreateDropdown({
   Name = "Teleport to Other",
   Options = toolNames,
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "ToolTeleportDropdown",
   Callback = function(Options)
       local selectedTool = Options[1]
       if selectedTool then
           teleportToTool(selectedTool)
       end
   end,
})


local MainSection = Misc:CreateSection("Information")
local Paragraph = Misc:CreateParagraph({Title = "⚒️ CREATOR SCRIPT", Content = "- Owner: Zeutronxsite\n- Developer: Zyruuux\n- Programmer: 4Streakzx & 3Streakzx\n- Builder Script: Therepositori\n- Tester Script: Exterminate0"})

local Paragraph = Misc:CreateParagraph({Title = "🛡️ INFORMATION", Content = "- Created Team: ZeutronX\n- Max Version: Final Update\n- Status: ⚪ Discountinue"})

local MainSection = Theme:CreateSection("Choose Theme")
local Paragraph = Theme:CreateParagraph({Title = "📢 INFORMATION", Content = "All these themes are built-in from Rayfield"})
-- Dropdown Theme Selector
local ThemeDropdown = Theme:CreateDropdown({
    Name = "Select Theme",
    Options = {
        "Default", 
        "AmberGlow", 
        "Bloom", 
        "Amethyst", 
        "DarkBlue", 
        "Green", 
        "Light", 
        "Ocean"
    },
    CurrentOption = {"Default"}, -- Tema awal
    MultipleOptions = false,     -- Hanya bisa pilih satu tema
    Flag = "ThemeSelector",      -- Identifier unik untuk config
    Callback = function(Options)
        -- Options adalah tabel, karena MultipleOptions = false, kita ambil index pertama [1]
        local selectedTheme = Options[1]
        
        -- Mencocokkan string pilihan dengan fungsi ModifyTheme
        if selectedTheme == "Default" then
            Window.ModifyTheme('Default')
        elseif selectedTheme == "AmberGlow" then
            Window.ModifyTheme('AmberGlow')
        elseif selectedTheme == "Bloom" then
            Window.ModifyTheme('Bloom')
        elseif selectedTheme == "Amethyst" then
            Window.ModifyTheme('Amethyst')
        elseif selectedTheme == "DarkBlue" then
            Window.ModifyTheme('DarkBlue')
        elseif selectedTheme == "Green" then
            Window.ModifyTheme('Green')
        elseif selectedTheme == "Light" then
            Window.ModifyTheme('Light')
        elseif selectedTheme == "Ocean" then
            Window.ModifyTheme('Ocean')
        end
        
        print("Theme changed to: " .. selectedTheme)
    end,
})

local MainSection = Target:CreateSection("Choose Target")
local Paragraph = Target:CreateParagraph({Title = "📢 INFORMATION", Content = "- Choose Your Target (ESP only, does not include teleport)\n- Use teleport to the player to eliminate them\n- Kill Them/Your Target Use Keybind or auto Kill Toggle\n- Refresh Username Target if a new player joins"})
local Paragraph = Target:CreateParagraph({Title = "🛡️ INFORMATION", Content = "One Hit Need More Weapons, 3-5 Weapons for One-Hit Kills"})

-- ==========================================
-- SERVICES & VARIABLES
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local CurrentTarget = nil      -- Player yang sedang di-ESP
local TargetData = nil         -- Data ESP objek target
local UpdateConnection = nil   -- Connection untuk update loop
local CharacterConnection = nil
local RemovingConnection = nil

-- ==========================================
-- Mapping Warna Team (Untuk Highlight)
-- ==========================================
local function getTeamColor(player)
    local team = player.Team
    local teamName = team and team.Name or ""
    
    local teamColorMap = {
        ["Fugitive"] = Color3.fromRGB(255, 50, 50),
        ["Prison"]   = Color3.fromRGB(255, 150, 0),
        ["Police"]   = Color3.fromRGB(0, 100, 255),
        ["Civilian"] = Color3.fromRGB(50, 255, 50),
        ["Hostage"]  = Color3.fromRGB(139, 0, 0),
        ["Red"]      = Color3.fromRGB(255, 50, 50),
        ["Blue"]     = Color3.fromRGB(50, 100, 255),
        ["Green"]    = Color3.fromRGB(50, 255, 50),
        ["Yellow"]   = Color3.fromRGB(255, 255, 50),
        ["Purple"]   = Color3.fromRGB(200, 50, 255),
        ["White"]    = Color3.fromRGB(255, 255, 255),
        ["Black"]    = Color3.fromRGB(50, 50, 50),
    }
    
    for name, color in pairs(teamColorMap) do
        if string.lower(teamName) == string.lower(name) then
            return color
        end
    end
    
    if team and team.TeamColor then
        return team.TeamColor.Color
    end
    
    return Color3.fromRGB(255, 255, 255)
end

-- ==========================================
-- Fungsi Hapus ESP Target
-- ==========================================
local function clearTargetESP()
    if UpdateConnection then
        UpdateConnection:Disconnect()
        UpdateConnection = nil
    end
    if CharacterConnection then
        CharacterConnection:Disconnect()
        CharacterConnection = nil
    end
    
    if TargetData then
        pcall(function()
            if TargetData.billboard then TargetData.billboard:Destroy() end
            if TargetData.highlight then TargetData.highlight:Destroy() end
        end)
        TargetData = nil
    end
    CurrentTarget = nil
end

-- ==========================================
-- Fungsi Membuat ESP ke Target Player
-- ==========================================
local function setupTargetESP(char)
    if not char then return end
    local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 3)
    local hum = char:FindFirstChild("Humanoid") or char:WaitForChild("Humanoid", 3)
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 3)
    if not head or not hum or not hrp then return end
    
    local teamColor = getTeamColor(CurrentTarget)
    local targetColor = Color3.fromRGB(255, 50, 50) -- Warna merah khusus target
    
    -- Hapus ESP lama jika ada (mencegah duplikat)
    if head:FindFirstChild("PlayerESP_GUI") then
        head.PlayerESP_GUI:Destroy()
    end
    if char:FindFirstChild("PlayerESP_HL") then
        char.PlayerESP_HL:Destroy()
    end
    
    -- 1. Highlight (Outline Player)
    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerESP_HL"
    highlight.FillColor = targetColor
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.FillTransparency = 0.6
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = char
    highlight.Parent = char
    
    -- 2. BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerESP_GUI"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 150, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.ResetOnSpawn = false
    billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    billboard.Parent = head
    
    -- 3. Nama Player dengan Prefix [🎯Target]
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 14)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "[Target] " .. CurrentTarget.Name
    nameLabel.TextColor3 = targetColor
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 13
    nameLabel.Parent = billboard
    
    -- 4. Label Jarak
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
    
    -- 5. Health Bar Background
    local hpBg = Instance.new("Frame")
    hpBg.Name = "HealthBg"
    hpBg.Size = UDim2.new(0, 130, 0, 6)
    hpBg.Position = UDim2.new(0.5, -65, 0, 26)
    hpBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    hpBg.BorderSizePixel = 0
    hpBg.Parent = billboard
    
    local hpCornerBg = Instance.new("UICorner")
    hpCornerBg.CornerRadius = UDim.new(0, 3)
    hpCornerBg.Parent = hpBg
    
    -- 6. Health Bar Fill
    local hpFill = Instance.new("Frame")
    hpFill.Name = "HealthFill"
    hpFill.Size = UDim2.new(1, 0, 1, 0)
    hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    hpFill.BorderSizePixel = 0
    hpFill.Parent = hpBg
    
    local hpCornerFill = Instance.new("UICorner")
    hpCornerFill.CornerRadius = UDim.new(0, 3)
    hpCornerFill.Parent = hpFill
    
    -- 7. Label HP
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
    
    -- Simpan referensi
    TargetData = {
        billboard = billboard,
        highlight = highlight,
        hpFill = hpFill,
        hpLabel = hpLabel,
        distanceLabel = distanceLabel,
        nameLabel = nameLabel,
        humanoid = hum,
        hrp = hrp,
        character = char
    }
end

-- ==========================================
-- Fungsi Update Loop (HP + Jarak) - Khusus 1 Target
-- ==========================================
local function startTargetUpdateLoop()
    if UpdateConnection then UpdateConnection:Disconnect() end
    
    UpdateConnection = RunService.RenderStepped:Connect(function()
        if not CurrentTarget or not TargetData then return end
        
        pcall(function()
            local hum = TargetData.humanoid
            local hrp = TargetData.hrp
            local fill = TargetData.hpFill
            local hpLabel = TargetData.hpLabel
            local distLabel = TargetData.distanceLabel
            
            -- Validasi: jika humanoid/hrp sudah di-destroy, bersihkan ESP
            if not hum or not hum.Parent or not hrp or not hrp.Parent then
                clearTargetESP()
                return
            end
            
            -- === Update HP Bar & Label ===
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
            
            -- === Update Jarak (Meter) ===
            local myChar = lp.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            
            if myHRP then
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
    end)
end

-- ==========================================
-- Fungsi Utama: Set Target Player
-- ==========================================
local function setTarget(player)
    clearTargetESP()
    
    if not player or player == lp then return end
    
    CurrentTarget = player
    
    -- Setup ESP ke character saat ini
    if player.Character then
        setupTargetESP(player.Character)
        startTargetUpdateLoop()
    end
    
    -- Listener untuk respawn character
    CharacterConnection = player.CharacterAdded:Connect(function(char)
        if CurrentTarget == player then
            task.wait(0.5)
            setupTargetESP(char)
            startTargetUpdateLoop()
        end
    end)
end

-- ==========================================
-- Handle Jika Target Leave Game
-- ==========================================
RemovingConnection = Players.PlayerRemoving:Connect(function(player)
    if CurrentTarget == player then
        clearTargetESP()
    end
end)

-- ==========================================
-- UI: Get Player Names untuk Dropdown
-- ==========================================
local function getPlayerNames()
    local names = {"None"}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp then
            table.insert(names, plr.Name)
        end
    end
    return names
end

-- ==========================================
-- UI ELEMENTS
-- =========================================

-- Dropdown Nama Player (Target Selector)
local TargetDropdown = Target:CreateDropdown({
   Name = "Select Target",
   Options = getPlayerNames(),
   CurrentOption = {"None"},
   MultipleOptions = false,
   Flag = "TargetDropdownFlag",
   Callback = function(Options)
       local selectedName = Options[1]
       if not selectedName or selectedName == "None" then
           clearTargetESP()
       else
           local target = Players:FindFirstChild(selectedName)
           if target then
               setTarget(target)
           else
               clearTargetESP()
           end
       end
   end,
})

-- Button Refresh Daftar Player
local RefreshButton = Target:CreateButton({
   Name = "Refresh Player List",
   Callback = function()
       local newNames = getPlayerNames()
       TargetDropdown:Refresh(newNames, false)
   end,
})

-- Keybind
local Keybind = Target:CreateKeybind({
    Name = "One Hit (Target)",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "Keybind1",
    Callback = function(Keybind)
        pcall(function()
                if Plr.Character and Plr.Backpack then
                    
                    -- 1. Equip SEMUA tool dari Backpack ke Character (Kecuali yang ada di IgnoredItems)
                    for _, tool in pairs(Plr.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and not IgnoredItems[tool.Name] then
                            tool.Parent = Plr.Character
                        end
                    end
                    
                    -- 2. Auto attack SEMUA tool yang ada di Character 1x saja (Kecuali yang ada di IgnoredItems)
                    for _, tool in pairs(Plr.Character:GetChildren()) do
                        if tool:IsA("Tool") and not IgnoredItems[tool.Name] then
                            tool:Activate()
                        end
                    end
                Rayfield:Notify({
                    Title = "⚔️ Information Alert",
                    Content = "One Hit has been triggered!",
                    Duration = 3,
                    Image = "swords",
                })
            end
        end)
    end
})

-- Script Auto Attack
local Plr = game:GetService("Players").LocalPlayer

workspace.FallenPartsDestroyHeight = -50000

-- Daftar item yang diabaikan (Bukan senjata / Tool pendukung)
local IgnoredItems = {
    -- Makanan & Minuman
    ["Drink"] = true, 
    ["Doughnut"] = true, 
    ["Hamburger"] = true, 
    ["Food"] = true, 
    ["Subway"] = true,
    
    -- Benda lain / Non-Weapon
    ["KeyCard"] = true, 
    ["BallNChainTool"] = true, 
    ["Broom"] = true, 
    ["BlindFold"] = true, 
    ["Rope"] = true, 
    ["Handcuffs (fugitive)"] = true, 
    ["Flashlight"] = true, 
    ["Board"] = true, 
    ["Grab"] = true
}

local MainSection = Target:CreateSection("Teleport Player")
local Paragraph = Target:CreateParagraph({Title = "📢 INFORMATION", Content = "Teleporting to the player takes 10 seconds, and if the player changes location, the teleport will follow them"})

local Button = Target:CreateButton({
    Name = "Teleporter Player",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Teleporter-Player/refs/heads/main/Working"))()
   end
})

local MainSection = Theme:CreateSection("Teleport")
local Paragraph = Theme:CreateParagraph({Title = "📢 INFORMATION", Content = "- Ensure your character is on the ground, if you are hovering, you will die due to the anti-cheat fly detection\n- The teleport duration to reach the destination is 7 seconds"})

local Button = Theme:CreateButton({
    Name = "Teleporter",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyptrue/Teleporter/refs/heads/main/Next"))()
   end
})

local MainSection = Misc:CreateSection("More Settings")
local Button = Misc:CreateButton({
    Name = "Destroy UI/Interface",
    Callback = function()
    Rayfield:Notify({
                    Title = "⚠️ Warning Detected!",
                    Content = "The script will self-destruct in 7 seconds!",
                    Duration = 7,
                    Image = "shield-alert",
                })
        wait(7)
    Rayfield:Destroy()
   end
})

local Button = Misc:CreateButton({
    Name = "Reset Character",
    Callback = function()
        Rayfield:Notify({
            Title = "⚠️ Warning Detected!",
            Content = "You will die in 3 seconds",
            Duration = 3,
            Image = "shield-alert",
        })
        
        -- Gunakan task.delay agar tidak memblokir thread utama/UI
        task.delay(3, function()
            local lp = game:GetService("Players").LocalPlayer
            local char = lp.Character
            
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    hum.Health = 0
                end
            end
        end)
    end
})
