local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

--// Create Window
local Window = Library:CreateWindow({
	Title = "Super Zeutron Hub",
	Subtitle = "Powered By Exterminate0 & Zeutron Team",
	Accent = Color3.fromRGB(255, 247, 0), -- Default White Accent
	
	Tags = {
		{
			Text = "MVSD DUELS",
			Color = Color3.fromRGB(255, 204, 0),
			TextColor = Color3.fromRGB(0, 0, 0)
		},
		{
			Text = "V-f4CKn2bK",
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
	Title = "🔁 V-sonKmbZZ",
	Content = "- [+] Added Script Zephyr [HUB]\n- [+] Added Zephyr Farm [Auto]\n- [+] Added PepiGuzman [HUB]\n- [+] Fixed Some Bugs\n- [+] Added PepiGuzman [HUB]"
})

ChangelogTab:CreateParagraph({
	Title = "🔁 V-f4CKn2bK",
	Content = "- [+] Added Package Script\n- [+] Fixed Some Bugs"
})

ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
	Title = "❌ V-urNFN5gn",
	Content = "Unknown, Coming Soon!"
})

------------------------------------------------------
-- MAIN SCRIPTS TAB
------------------------------------------------------
MainTab:CreateSection("Main Menu")

MainTab:CreateParagraph({
	Title = "🛡️ System Information",
	Content = "These scripts are safe and tested.\nNote: All these scripts are not owned by me"
})

local selectedScript = "None"

local function runMainScript(optionName)
	if optionName == "Zephyr [HUB]" then
		Library:Notify("Executing Zephyr [HUB]...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/script.lua", true))()
		end)

	elseif optionName == "Zephyr Farm [Auto]" then
		Library:Notify("Executing Zephyr Farm [Auto]...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/versions/Autofarm.lua", true))()
		end)

	elseif optionName == "PepiGuzman [HUB]" then
		Library:Notify("Executing PepiGuzman [HUB]...", 4, "Status", "check")
		task.wait(0.5)
        Library:Notify("Key: PepiGuzmanShop", 20, "Information", "bell")
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/xxz18902-arch/Mvsd/refs/heads/main/obfuscated_script-1785806102417.lua"))()
		end)

	elseif optionName == "FrostRose [HUB]" then
		Library:Notify("Executing FrostRose [HUB]", 4, "Information", "x")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Kusa1leaf/Mvsd_Frostrose/refs/heads/main/Frostrose_Mvsd"))()
		end)

	elseif optionName == "MONO [HUB]" then
		Library:Notify("Executing MONO [HUB]", 4, "Information", "x")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://gist.githubusercontent.com/PALIPAM67/d758fd42a0c1cd05b34a467fe2a07762/raw/Babuinka_2288"))()
		end)
	end
end

MainTab:CreateDropdown({
	Name = "Select Script",
	Icon = "box",
	Options = {
		"None",
		"Zephyr [HUB]",
		"Zephyr Farm [Auto]",
		"PepiGuzman [HUB]",
		"FrostRose [HUB]",
		"MONO [HUB]"
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

MainTab:CreateSection("Package Script")

MainTab:CreateParagraph({
	Title = "🛡️ System Information",
	Content = "This script is a script combination of various scripts (will cause lag)"
})

local selectedScript = "None"

local function runMainScript2(optionName)
	if optionName == "Zephyr [HUB] + Mono [HUB] + Animation" then
		Library:Notify("Executing The Package...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/TheRealAvrwm/Zephyr-V2/refs/heads/main/script.lua", true))()
            wait(1)
            loadstring(game:HttpGet("https://gist.githubusercontent.com/PALIPAM67/d758fd42a0c1cd05b34a467fe2a07762/raw/Babuinka_2288"))()
            wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/BundleAnimations.lua"))()
		end)
	end
end

MainTab:CreateDropdown({
	Name = "Select Script",
	Icon = "box",
	Options = {
		"None",
		"Zephyr [HUB] + Mono [HUB] + Animation",
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
		
		runMainScript2(selectedScript)
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
	Name = "Go Back to Zeutron Hub",
	Icon = "home",
	Callback = function()
		Library:Notify("Loading Zeutron Hub...", 3, "Navigation", "refresh-cw")
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
