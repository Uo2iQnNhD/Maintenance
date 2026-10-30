-- =========================================================
-- SERVICES
-- =========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- =========================================================
-- LOAD LIBRARY
-- =========================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

if type(Library) ~= "table" then
    error("[ZethHub] Library failed to load.", 0)
end

-- =========================================================
-- NOTIFICATION HELPER (Rayfield Style)
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

    local ok = pcall(function()
        Library:Notify(cfg)
    end)

    -- Fallback to old style if library doesn't support table yet
    if not ok then
        task.spawn(function()
            pcall(function()
                Library:Notify(content, duration, title, icon)
            end)
        end)
    end
end

-- =========================================================
-- REMOTE SCRIPT EXECUTOR HELPER
-- =========================================================
local function executeScript(url, scriptName)
    if not url or url == "" then
        notify("Error", "Script URL not found for: " .. tostring(scriptName), 5, "x-circle")
        return
    end

    notify("Executed Scripts", "Scripts Successfully Executed!", 6, "check-circle")
    task.wait(0.5)

    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    if not ok then
        notify(
            "Execution Error",
            "Failed to run " .. tostring(scriptName) .. "\n" .. tostring(err),
            6,
            "x-circle"
        )
    end
end

-- =========================================================
-- WINDOW SETUP
-- =========================================================
local InitialAccent = Color3.fromRGB(255, 0, 0)

if type(Library.SetAccent) == "function" then
    Library:SetAccent(InitialAccent)
end

if type(Library.SetRainbow) == "function" then
    Library:SetRainbow(false)
end

Library.ToggleKey = Enum.KeyCode.K

local Window = Library:CreateWindow({
    Title = "Super Zeutron",
    Subtitle = "By Exterminate0 & Zeutron Team",
    Accent = InitialAccent,

    -- Warna close button / confirm modal
    CloseColor = Color3.fromRGB(255, 80, 80),
    CloseHoverColor = Color3.fromRGB(255, 120, 120),
    ClosePressedColor = Color3.fromRGB(190, 50, 50),
    CloseTextColor = Color3.fromRGB(255, 255, 255), -- opsional
        
    Tags = {
        {
            Text = "Steal An Egg",
            Color = Color3.fromRGB(255, 204, 0),
            TextColor = Color3.fromRGB(0, 0, 0),
        },
        {
            Text = "LATEST UPDATE",
            Color = Color3.fromRGB(46, 230, 110),
            TextColor = Color3.fromRGB(0, 0, 0),
        },
    },
})

if not Window then
    error("[ZethHub] Failed to create Window.", 0)
end

-- =========================================================
-- THEME PRESETS & HELPER
-- =========================================================
local THEME_PRESETS = {
    Default = {
        Accent = Color3.fromRGB(50, 138, 220),
        Rainbow = false,
    },
    AmberGlow = {
        Accent = Color3.fromRGB(255, 170, 85),
        Rainbow = true,
    },
    Bloom = {
        Accent = Color3.fromRGB(255, 140, 170),
        Rainbow = true,
    },
    Amethyst = {
        Accent = Color3.fromRGB(150, 100, 200),
        Rainbow = true,
    },
    DarkBlue = {
        Accent = Color3.fromRGB(0, 150, 240),
        Rainbow = true,
    },
    Green = {
        Accent = Color3.fromRGB(100, 180, 100),
        Rainbow = true,
    },
    Light = {
        Accent = Color3.fromRGB(255, 255, 255),
        Rainbow = true,
    },
    Ocean = {
        Accent = Color3.fromRGB(0, 160, 160),
        Rainbow = true,
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
        notify("Theme Error", "Theme not found: " .. tostring(themeName), 5, "x-circle")
        return
    end

    if type(Library.SetRainbow) == "function" then
        Library:SetRainbow(preset.Rainbow)
    end

    if type(Library.SetAccent) == "function" then
        Library:SetAccent(preset.Accent)
    end

    if Window and not Window._destroyed and type(Window.SetAccent) == "function" then
        Window:SetAccent(preset.Accent)
    end

    notify("Theme", "Successfully changed theme to " .. themeName, 4, "check-circle")
end

-- =========================================================
-- INITIAL NOTIFY
-- =========================================================
notify("Notification Alert", "Thank you for using this scripts", 6, "bell")

-- =========================================================
-- TABS
-- =========================================================
local ChangelogTab = Window:CreateTab("Changelog", "newspaper")
local MainTab = Window:CreateTab("Main Scripts", "sword")
local ThemeTab = Window:CreateTab("Theme & Settings", "palette")

-- =========================================================
-- CHANGELOG TAB
-- =========================================================
ChangelogTab:CreateSection("Information & Version")

ChangelogTab:CreateParagraph({
    Title = "🔁 V-A9ESKII",
    Content = {
        "- [+] Added Scripts GUI And Auto farm",
        "- [+] Add Changelog",
        "- [+] Add Theme and Destroy",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "🔁 V-8A9ESKII",
    Content = {
        "- [+] Added Scripts Sena [HUB]",
        "- [+] Added More Details",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "🔁 V-vVaLjCVc",
    Content = {
        "- [+] Added Scripts AXON [HUB]",
        "- [+] Added Pet Spawner [1],[2],[3]",
        "- [+] Fixed Some Bugs",
        "- [+] Added Gifter Gamepass & Pet Spawner 4",
    },
    Icon = "file-text",
})

ChangelogTab:CreateParagraph({
    Title = "🔁 RBX-V/LATEST UPDATE",
    Content = {
        "- [+] Added Scripts Venyx [HUB]",
        "- [+] Added YinYang Theme",
        "- [+] Fixed Some Bugs",
    },
    Icon = "file-text",
})

ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
    Title = "❌ RBX-V???",
    Content = "Unknown, Coming Soon!",
    Icon = "clock",
})

-- =========================================================
-- MAIN SCRIPTS TAB
-- =========================================================
MainTab:CreateSection("Main Menu")

MainTab:CreateParagraph({
    Title = "🛡️ System Information",
    Content = {
        "This Scripts Is safe and has been tested",
        "- All these scripts are not mine",
    },
    Icon = "shield",
})

-- =========================================================
-- HELPER MULTI DROPDOWN EXECUTION
-- =========================================================

local function toSelectionList(input)
	if type(input) == "string" then
		return { input }
	end

	if type(input) ~= "table" then
		return {}
	end

	if #input > 0 then
		return input
	end

	local out = {}
	for _, v in pairs(input) do
		if type(v) == "string" then
			table.insert(out, v)
		end
	end

	return out
end

local function sendNotify(title, message, duration, icon)
	if type(notify) == "function" then
		notify(title, message, duration, icon)
	elseif type(Library) == "table" and type(Library.Notify) == "function" then
		Library:Notify(message, duration, title, icon)
	end
end

local function executeScriptList(selection, urlMap)
	local list = toSelectionList(selection)

	if #list == 0 then
		sendNotify("Error", "Please select at least one script!", 5, "x-circle")
		return
	end

	local validCount = 0
	for _, name in ipairs(list) do
		if type(name) == "string" and urlMap[name] then
			validCount = validCount + 1
		end
	end

	if validCount == 0 then
		sendNotify("Error", "Selected script has no valid URL!", 5, "x-circle")
		return
	end

	sendNotify("Status", "Executing " .. validCount .. " script(s)...", 4, "check")

	task.spawn(function()
		local done = 0

		for _, name in ipairs(list) do
			local url = type(name) == "string" and urlMap[name] or nil

			if url then
				done = done + 1

				local ok, err = pcall(function()
					if type(executeScript) == "function" then
						executeScript(url, name)
					else
						loadstring(game:HttpGet(url))()
					end
				end)

				if not ok then
					sendNotify(
						"Error",
						tostring(name) .. " failed: " .. tostring(err),
						5,
						"x-circle"
					)
				end

				if done < validCount then
					task.wait(1.2)
				end
			else
				sendNotify(
					"Error",
					"URL not found: " .. tostring(name),
					5,
					"x-circle"
				)
			end
		end

		sendNotify("Done", "All selected scripts executed.", 4, "check-circle")
	end)
end

-- =========================================================
-- MAIN SCRIPTS - MULTI DROPDOWN
-- =========================================================

local MAIN_SCRIPTS_OPTIONS = {
	"NIGHT [HUB & KEYLESS]",
	"LENNON [HUB & KEYLESS]",
	"MIRANDA [HUB & KEYLESS]",
	"Chilli [HUB & FREE]",
	"Sena [UPD]",
	"Sena [NEW]",
	"Venyx [HUB]",
	"AXON [HUB & KEYLESS]",
	"LIMBO [FREE]",
}

local MAIN_SCRIPTS_URLS = {
	["NIGHT [HUB & KEYLESS]"] = "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealEggOnly.luau",
	["LENNON [HUB & KEYLESS]"] = "https://flowauth.net/v1/ui/584e23b68f5f361081321954763ab5e5.lua",
	["MIRANDA [HUB & KEYLESS]"] = "https://flowauth.net/v1/ui/5f7a6b969f81332d7994e3b5eb71c686.lua",
	["Chilli [HUB & FREE]"] = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua",
	["Sena [UPD]"] = "https://senahub.xyz/raw/loader",
	["Sena [NEW]"] = "https://senahub.xyz/senaloader",
	["Venyx [HUB]"] = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub",
	["AXON [HUB & KEYLESS]"] = "https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua",
	["LIMBO [FREE]"] = "https://limbohub.my.id/loader.lua",
}

local selectedMainScripts = {}

MainTab:CreateMultiDropdown({
	Name = "Select Scripts",
	Icon = "layers",
	Options = MAIN_SCRIPTS_OPTIONS,
	Default = {},
	Placeholder = "None selected",
	Flag = "MainScriptMulti",
	Tooltip = "Select one or more main scripts to execute",
	Callback = function(list)
		selectedMainScripts = toSelectionList(list)
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Scripts",
	Icon = "play",
	Tooltip = "Execute all selected main scripts",
	Callback = function()
		executeScriptList(selectedMainScripts, MAIN_SCRIPTS_URLS)
	end,
})

-- =========================================================
-- PET SPAWNER & MORE - MULTI DROPDOWN
-- =========================================================

MainTab:CreateSection("Pet Spawner & More")

MainTab:CreateParagraph({
	Title = "📚 Guide Information",
	Content = {
		"This Scripts Is safe and has been tested",
		"- All these scripts are not mine",
		"- This script is client-side only and not the real thing, so don't get your hopes up too high",
	},
	Icon = "book-open",
})

local PET_SPAWNER_OPTIONS = {
	"PET SPAWNER 1 [FREE & CLIENT]",
	"PET SPAWNER 2 [FREE & CLIENT]",
	"PET SPAWNER 3 [KEYLESS & CLIENT]",
	"PET SPAWNER 4 [KEYLESS & CLIENT]",
	"GIFTER GAMEPASS [KEYLESS & CLIENT]",
}

local PET_SPAWNER_URLS = {
	["PET SPAWNER 1 [FREE & CLIENT]"] = "https://raw.githubusercontent.com/zenvex4/StealAnEgg/refs/heads/main/Loader.lua",
	["PET SPAWNER 2 [FREE & CLIENT]"] = "https://raw.githubusercontent.com/INF-Hub-PL/StealAEggScript/refs/heads/main/Pet_SpawnerV1",
	["PET SPAWNER 3 [KEYLESS & CLIENT]"] = "https://scriptversekey.xyz/s/steal-an-egg-pet-spawner",
	["PET SPAWNER 4 [KEYLESS & CLIENT]"] = "https://pastefy.app/t06eyyrw/raw",
	["GIFTER GAMEPASS [KEYLESS & CLIENT]"] = "https://pastefy.app/CkaV7ET8/raw",
}

local selectedPetScripts = {}

MainTab:CreateMultiDropdown({
	Name = "Select Scripts",
	Icon = "layers",
	Options = PET_SPAWNER_OPTIONS,
	Default = {},
	Placeholder = "None selected",
	Flag = "PetScriptMulti",
	Tooltip = "Select one or more pet spawners/extra scripts",
	Callback = function(list)
		selectedPetScripts = toSelectionList(list)
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Scripts",
	Icon = "play",
	Tooltip = "Execute all selected pet spawner scripts",
	Callback = function()
		executeScriptList(selectedPetScripts, PET_SPAWNER_URLS)
	end,
})
