local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

--// Create Window
local Window = Library:CreateWindow({
	Title = "Super Zeutron Hub",
	Subtitle = "Powered By Exterminate0 & Zeutron Team",
	Accent = Color3.fromRGB(255, 255, 255), -- Default White Accent
	
	Tags = {
		{
			Text = "The Hollow",
			Color = Color3.fromRGB(255, 204, 0),
			TextColor = Color3.fromRGB(0, 0, 0)
		},
		{
			Text = "V-p5MGimEZ",
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
	Title = "🔁 V-p5MGimEZ",
	Content = "- [+] Added Script Flee the Facility [Get UGC]\n- [+] Added Flee the Facility [Get UGC]\n- [+] Added Doors [Get UGC]\n- [+] Fixed Some Bugs"
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
	if optionName == "Flee the Facility [Main]" then
		Library:Notify("Executing Flee the Facility [Main]...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/gerka842-afk/Flee-the-Facility/main/Flee-the-Facility"))()
		end)

	elseif optionName == "Flee the Facility [Get UGC]" then
		Library:Notify("Executing Flee the Facility [Get UGC]...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://pastefy.app/qzR9vOkZ/raw"))()
		end)

	elseif optionName == "Doors [Get UGC]" then
		Library:Notify("Executing Doors [Get UGC]...", 4, "Status", "check")
		task.wait(0.5)
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkDoorsKing/More/main/Doors_RC"))()
		end)

	elseif optionName == "Coming Soon [???]" then
		Library:Notify("Other scripts will be coming soon", 4, "Information", "x")
		task.wait(0.5)
		pcall(function()
		end)

	elseif optionName == "Coming Soon" then
		Library:Notify("Other scripts will be coming soon", 4, "Information", "x")
		task.wait(0.5)
		pcall(function()
		end)
	end
end

MainTab:CreateDropdown({
	Name = "Select Script",
	Icon = "box",
	Options = {
		"None",
		"Flee the Facility [Main]",
		"Flee the Facility [Get UGC]",
		"Doors [Get UGC]",
		"Coming Soon [???]",
		"Coming Soon"
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
