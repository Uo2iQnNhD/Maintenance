local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

--// Create Window
local Window = Library:CreateWindow({
	Title = "Super Zeutron",
	Subtitle = "Powered By Exterminate0 & Zeutron Team",
	Accent = Color3.fromRGB(255, 255, 255), -- Default White Accent
	
	Tags = {
		{
			Text = "The Hollow",
			Color = Color3.fromRGB(255, 204, 0),
			TextColor = Color3.fromRGB(0, 0, 0)
		},
		{
			Text = "LATEST UPDATE",
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

------------------------------------------------------
-- CHANGELOG TAB
------------------------------------------------------
ChangelogTab:CreateSection("Information & Version")

ChangelogTab:CreateParagraph({
	Title = "🔁 RBX-V/LATEST UPDATE",
	Content = "- [+] Added Script Flee the Facility [Get UGC]\n- [+] Added Flee the Facility [Get UGC]\n- [+] Added Doors [Get UGC]\n- [+] Fixed Some Bugs"
})


ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
	Title = "❌ RBX-V???",
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
