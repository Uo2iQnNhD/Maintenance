local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

--// Create Window
local Window = Library:CreateWindow({
	Title = "Super Zeutron Hub",
	Subtitle = "Powered By Exterminate0 & Zeutron Team",
	Accent = Color3.fromRGB(255, 247, 0), -- Default Yellow Accent

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
	Content = "- [+] Added Package Script\n- [+] Fixed Some Bugs\n- [+] Added Multi-dropdown & Deleted Packaged"
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
	Content = "These scripts are safe and tested.\nNote: All these scripts are not owned by me\nTip: Use MULTI-SELECT to run several scripts at once."
})

--// Daftar script yang dipilih (multi-select) -> table array of string
local selectedScripts = {}

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

--// MULTI-DROPDOWN: pilih lebih dari 1 script
MainTab:CreateMultiDropdown({
	Name = "Select Scripts",
	Icon = "layers",
	Options = {
		"Zephyr [HUB]",
		"Zephyr Farm [Auto]",
		"PepiGuzman [HUB]",
		"FrostRose [HUB]",
		"MONO [HUB]",
	},
	Default = {},                 -- table kosong = tidak ada yang terpilih
	Placeholder = "None selected",
	Flag = "MainScriptMulti",     -- flag UNIK (tidak bentrok dengan package)
	Callback = function(list)
		selectedScripts = list    -- list = table array of string
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Scripts",
	Icon = "play",
	Callback = function()
		if type(selectedScripts) ~= "table" or #selectedScripts == 0 then
			Library:Notify("Please select at least one script!", 5, "Error", "x-circle")
			return
		end

		local count = #selectedScripts
		Library:Notify("Executing " .. count .. " script(s)...", 4, "Status", "check")

		-- Jalankan berurutan di thread terpisah agar UI tidak freeze
		task.spawn(function()
			for i, name in ipairs(selectedScripts) do
				runMainScript(name)
				if i < count then
					task.wait(1.2) -- jeda aman antar hub
				end
			end
			Library:Notify("All selected scripts executed.", 4, "Done", "check-circle")
		end)
	end,
})
