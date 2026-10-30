--[[ ZETHUB | JAILBREAK | V-jv2vZBaP ]]
-- Migrated from Rayfield to Custom ZETHUB Library

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
			Text = "Jailbreak",
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
	Title = "🔁 V-jv2vZBaP",
	Content = "- [+] Added Scripts GUI And Auto Farm\n- [+] Added Changelog\n- [+] Added Theme and Destroy features\n- [+] Added More Details & Icons\n- [!] Fixed Some Bugs"
})

ChangelogTab:CreateParagraph({
	Title = "🔁 RBX-V/LATEST UPDATE",
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

-- =========================================================
-- HELPER UNTUK MULTI DROPDOWN
-- =========================================================

local function toSelectionList(input)
	if type(input) == "string" then
		return { input }
	end

	if type(input) ~= "table" then
		return {}
	end

	local out = {}
	local seen = {}

	-- Jika berbentuk array: { "Script A", "Script B" }
	if #input > 0 then
		for _, v in ipairs(input) do
			if type(v) == "string" and not seen[v] then
				seen[v] = true
				table.insert(out, v)
			end
		end

		return out
	end

	-- Jika berbentuk dictionary/hash:
	-- { ["Script A"] = true, ["Script B"] = true }
	-- atau { [1] = "Script A", [2] = "Script B" }
	for k, v in pairs(input) do
		if type(k) == "string" and v == true and not seen[k] then
			seen[k] = true
			table.insert(out, k)
		elseif type(v) == "string" and not seen[v] then
			seen[v] = true
			table.insert(out, v)
		end
	end

	return out
end

-- =========================================================
-- MAIN SCRIPTS - MULTI DROPDOWN
-- =========================================================

local selectedMainScripts = {}

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

MainTab:CreateMultiDropdown({
	Name = "Select Scripts",
	Icon = "layers",
	Options = {
		"Rendex [FREE]",
		"Flow [KEYLESS]",
		"Sexsation [FREE]",
		"Iliomium [FREE]",
		"Spark [KEYLESS]",
	},
	Default = {},
	Placeholder = "None selected",
	Flag = "MainScriptMulti",
	Tooltip = "Select one or more scripts",
	Callback = function(list)
		selectedMainScripts = toSelectionList(list)
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Scripts",
	Icon = "play",
	Tooltip = "Run all selected main scripts",
	Callback = function()
		if type(selectedMainScripts) ~= "table" or #selectedMainScripts == 0 then
			Library:Notify("Please select at least one script!", 5, "Error", "x-circle")
			return
		end

		local count = #selectedMainScripts
		Library:Notify("Executing " .. count .. " main script(s)...", 4, "Status", "check")

		task.spawn(function()
			for i, scriptName in ipairs(selectedMainScripts) do
				local ok, err = pcall(function()
					runMainScript(scriptName)
				end)

				if not ok then
					Library:Notify(
						tostring(scriptName) .. " failed: " .. tostring(err),
						5,
						"Error",
						"x-circle"
					)
				end

				if i < count then
					task.wait(1.2)
				end
			end

			Library:Notify("All selected main scripts executed.", 4, "Done", "check-circle")
		end)
	end,
})

------------------------------------------------------
-- AUTO FARM SECTION
------------------------------------------------------

MainTab:CreateSection("Auto Farm")

MainTab:CreateParagraph({
	Title = "💰 Auto Farm Systems",
	Content = "Automate money grinding and arresting players.",
})

local selectedFarmScripts = {}

local function runFarmScript(optionName)
	if optionName == "Blitz [FREE]" then
		Library:Notify("Executing Blitz Farm...", 4, "Status", "check")
		task.wait(0.5)

		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/BlitzIsKing/UniversalFarm/main/Loader/Regular"))()
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
			loadstring(game:HttpGet("http://scripts.projectauto.xyz/AutoRobV6"))()
			task.wait(2)
			loadstring(game:HttpGet("http://scripts.projectauto.xyz/AutoArrestV4"))()
		end)
	end
end

MainTab:CreateMultiDropdown({
	Name = "Select Farm Scripts",
	Icon = "activity",
	Options = {
		"Blitz [FREE]",
		"Snowy [KEYLESS]",
		"Project Auto [KEYLESS]",
	},
	Default = {},
	Placeholder = "None selected",
	Flag = "FarmScriptMulti",
	Tooltip = "Select one or more auto farm scripts",
	Callback = function(list)
		selectedFarmScripts = toSelectionList(list)
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Farms",
	Icon = "play",
	Tooltip = "Run all selected auto farm scripts",
	Callback = function()
		if type(selectedFarmScripts) ~= "table" or #selectedFarmScripts == 0 then
			Library:Notify("Please select at least one farm script!", 5, "Error", "x-circle")
			return
		end

		local count = #selectedFarmScripts
		Library:Notify("Executing " .. count .. " farm script(s)...", 4, "Status", "check")

		task.spawn(function()
			for i, scriptName in ipairs(selectedFarmScripts) do
				local ok, err = pcall(function()
					runFarmScript(scriptName)
				end)

				if not ok then
					Library:Notify(
						tostring(scriptName) .. " failed: " .. tostring(err),
						5,
						"Error",
						"x-circle"
					)
				end

				if i < count then
					task.wait(1.2)
				end
			end

			Library:Notify("All selected farm scripts executed.", 4, "Done", "check-circle")
		end)
	end,
})
