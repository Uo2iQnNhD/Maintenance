--[[ ZETHUB | JAILBREAK | V-jv2vZBaP ]]
-- Migrated from Rayfield to Custom ZETHUB Library

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

--// Create Window
local Window = Library:CreateWindow({
	Title = "ZETHUB | JAILBREAK",
	Subtitle = "V-jv2vZBaP • By Exterminate0",
	Accent = Color3.fromRGB(255, 255, 255), -- Default White Accent
	
	Tags = {
		{
			Text = "Jailbreak",
			Color = Color3.fromRGB(255, 204, 0),
			TextColor = Color3.fromRGB(0, 0, 0)
		},
		{
			Text = "V-rJUZBy7E",
			Color = Color3.fromRGB(46, 230, 110),
			TextColor = Color3.fromRGB(0, 0, 0)
		},
	},
})

--// Initial Notification
task.delay(1, function()
	Library:Notify(
		"Thank you for using this script!",
		6,
		"System Alert",
		"bell"
	)
end)

------------------------------------------------------
-- TABS
------------------------------------------------------
local ChangelogTab = Window:CreateTab("Changelog", "file-text")
local MainTab = Window:CreateTab("Main Scripts", "crosshair")
local SettingsTab = Window:CreateTab("Settings", "settings")

------------------------------------------------------
-- CHANGELOG TAB
------------------------------------------------------
ChangelogTab:CreateSection("Information & Version")

ChangelogTab:CreateParagraph({
	Title = "🔁 V-jv2vZBaP",
	Content = "- [+] Added Scripts GUI And Auto Farm\n- [+] Added Changelog\n- [+] Added Theme and Destroy features\n- [+] Added More Details & Icons\n- [!] Fixed Some Bugs"
})

ChangelogTab:CreateParagraph({
	Title = "🔁 V-rJUZBy7E",
	Content = "- [+] Added Scripts GUI And Auto Farm\n- [+] Added Changelog\n- [+] Added Theme and Destroy features\n- [+] Added More Details & Icons\n- [!] Fixed Some Bugs"
})

ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
	Title = "❌ V-q3Z2ts9a",
	Content = "Unknown, Coming Soon!"
})

------------------------------------------------------
-- MAIN SCRIPTS TAB
------------------------------------------------------
MainTab:CreateSection("Scripts UI/GUI")

MainTab:CreateParagraph({
	Title = "🛡️ System Information",
	Content = "These scripts are safe and tested.\nNote: All these scripts are not owned by me."
})

local selectedScript = "None"

local function runMainScript(optionName)
	if optionName == "Rendex [FREE]" then
		Library:Notify("Executing Rendex...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/ImNotWhyLclc/Rendex/main/Loader.luau", true))()
		end)

	elseif optionName == "Flow [KEYLESS]" then
		Library:Notify("Executing Flow...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/5946add9ab91f1e04cb005346a8b1968.lua", true))()
		end)

	elseif optionName == "Sexsation [FREE]" then
		Library:Notify("Executing Sexsation...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/730854e5b6499ee91deb1080e8e12ae3.lua"))()
		end)

	elseif optionName == "Iliomium [FREE]" then
		Library:Notify("Executing Iliomium...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://pastebin.com/raw/dUAj0Vpx"))()
		end)

	elseif optionName == "Spark [KEYLESS]" then
		Library:Notify("Executing Spark...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/ultimatep568/Spark-Hub/refs/heads/main/SparkHub_Loader.lua"))()
		end)
	end
end

MainTab:CreateDropdown({
	Name = "Select Script",
	Icon = "box",
	Options = {
		"None",
		"Rendex [FREE]",
		"Flow [KEYLESS]",
		"Sexsation [FREE]",
		"Iliomium [FREE]",
		"Spark [KEYLESS]"
	},
	Default = "None",
	Flag = "MainScriptDropdown",
	Callback = function(option)
		selectedScript = option
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Script",
	Icon = "play",
	Callback = function()
		if selectedScript == "None" then
			Library:Notify("Please select a script first!", 5, "Error", "x-circle")
			return
		end
		
		runMainScript(selectedScript)
	end,
})

------------------------------------------------------
-- AUTO FARM SECTION
------------------------------------------------------
MainTab:CreateSection("Auto Farm")

MainTab:CreateParagraph({
	Title = "💰 Auto Farm Systems",
	Content = "Automate money grinding and arresting players."
})

local selectedFarmScript = "None"

local function runFarmScript(optionName)
	if optionName == "Blitz [FREE]" then
		Library:Notify("Executing Blitz Farm...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/BlitzIsKing/UniversalFarm/main/Loader/Regular'))()
		end)

	elseif optionName == "Snowy [KEYLESS]" then
		Library:Notify("Executing Snowy Farm...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/4ad6a2d2335968486879c1b1a2dcefc6937ea63c8acb88e703a1ec95a4a146ea/download"))()
		end)

	elseif optionName == "Project Auto [KEYLESS]" then
		Library:Notify("Executing Project Auto...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoRobV6'))()
			wait(2)
			loadstring(game:HttpGet('http://scripts.projectauto.xyz/AutoArrestV4'))()
		end)
	end
end

MainTab:CreateDropdown({
	Name = "Select Farm Script",
	Icon = "activity",
	Options = {
		"None",
		"Blitz [FREE]",
		"Snowy [KEYLESS]",
		"Project Auto [KEYLESS]"
	},
	Default = "None",
	Flag = "FarmScriptDropdown",
	Callback = function(option)
		selectedFarmScript = option
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Farm",
	Icon = "play",
	Callback = function()
		if selectedFarmScript == "None" then
			Library:Notify("Please select a farm script first!", 5, "Error", "x-circle")
			return
		end
		
		runFarmScript(selectedFarmScript)
	end,
})

------------------------------------------------------
-- SETTINGS TAB (THEME & DESTROY)
------------------------------------------------------
SettingsTab:CreateSection("Appearance")

SettingsTab:CreateParagraph({
	Title = "🎨 Theme Colors",
	Content = "Change the accent color of the interface.\n(Note: Rayfield themes mapped to closest RGB)"
})

-- Map Rayfield Themes to RGB for the new library
local themeColors = {
	Default = Color3.fromRGB(255, 255, 255),
	AmberGlow = Color3.fromRGB(250, 150, 75),
	Bloom = Color3.fromRGB(250, 160, 180),
	Amethyst = Color3.fromRGB(130, 80, 180),
	DarkBlue = Color3.fromRGB(0, 120, 210),
	Green = Color3.fromRGB(70, 130, 70),
	Light = Color3.fromRGB(100, 150, 200),
	Ocean = Color3.fromRGB(0, 140, 140),
}

local currentTheme = "Default"

SettingsTab:CreateDropdown({
	Name = "Select Theme",
	Icon = "palette",
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
	Default = "Default",
	Flag = "ThemeSelector",
	Callback = function(themeName)
		currentTheme = themeName
		local color = themeColors[themeName] or themeColors.Default
		
		-- Apply accent color globally
		Library:SetAccent(color)
		
		Library:Notify("Theme changed to: " .. themeName, 3, "System", "check")
	end,
})

SettingsTab:CreateSection("More Settings")

SettingsTab:CreateButton({
	Name = "Go Back to Universal Hub",
	Icon = "home",
	Callback = function()
		Library:Notify("Loading Universal Hub...", 3, "Navigation", "refresh-cw")
		task.wait(1)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/L3aun246-Universal.lua"))()
		end)
	end,
})

SettingsTab:CreateButton({
	Name = "Destroy Interface",
	Icon = "trash-2",
	Callback = function()
		Library:Notify("Self-destructing in 7 seconds...", 7, "Warning", "shield-alert")
		task.wait(7)
		
		-- Attempt to destroy via library method if exists, otherwise just hide/close
		if type(Library.Destroy) == "function" then
			Library:Destroy()
		else
			-- Fallback: Hide all windows manually if Destroy isn't implemented perfectly yet
			for _, w in ipairs(Library._windows or {}) do
				if type(w.Destroy) == "function" then
					w:Destroy()
				end
			end
		end
	end,
})
