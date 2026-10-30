local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/HX5cd2ms4-Release.luau"))()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

--// Create Window
local Window = Library:CreateWindow({
	Title = "Super Zeutron",
	Subtitle = "Powered by Exterminate0 & Zeutron Team",
	Accent = Color3.fromRGB(255, 255, 255),

	Tags = {
		{
			Text = "Violence District",
			Color = Color3.fromRGB(255, 70, 70),
			TextColor = Color3.fromRGB(255, 255, 255)
		},
		{
			Text = "LASTEST UPDATE",
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
		"Notification Alert",
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
	Title = "🔁 V-YNRbnuCQ",
	Content = "- [+] Added Scripts GUI And Auto Farm\n- [+] Added Changelog\n- [+] Added Theme and Destroy"
})

ChangelogTab:CreateParagraph({
	Title = "🔁 V-Ez6UbKcj",
	Content = "- [+] Added More Scripts\n- [+] Fixed Scripts Not Working\n- [+] Fixed Zeutron Bugs"
})

ChangelogTab:CreateParagraph({
	Title = "🔁 RBX-V/LATEST UPDATE",
	Content = "- [+] Updated Script Bolong HUB\n- [+] Added More Icons & Details\n- [!] Fixed Some Bugs"
})

ChangelogTab:CreateSection("Next Update & Version")

ChangelogTab:CreateParagraph({
	Title = "❌ RBX-V???",
	Content = "Unknown, Coming Soon!"
})

------------------------------------------------------
-- MAIN SCRIPTS TAB
------------------------------------------------------
MainTab:CreateSection("Main Menu")

MainTab:CreateParagraph({
	Title = "🛡️ System Information",
	Content = "These scripts are safe and have been tested.\n- All these scripts are not mine."
})

-- =========================================================
-- HELPER MULTI DROPDOWN
-- Jika helper ini sudah ada di script kamu, hapus bagian ini
-- agar tidak duplikat.
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

	-- Format array: { "Script A", "Script B" }
	if #input > 0 then
		for _, v in ipairs(input) do
			if type(v) == "string" and not seen[v] then
				seen[v] = true
				table.insert(out, v)
			end
		end

		return out
	end

	-- Format dictionary:
	-- { ["Script A"] = true, ["Script B"] = true }
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
-- MULTI DROPDOWN SCRIPTS
-- =========================================================

local BOLONG_SCRIPT_OPTIONS = {
	"BolongHub [FREE]",
	"WisnuHub [FREE]",
	"W424HUB [FREE]",
	"4LynxX [FREE]",
}

local BOLONG_SCRIPT_DATA = {
	["BolongHub [FREE]"] = {
		url = "https://raw.githubusercontent.com/RillBoys/bolong.cat/refs/heads/main/main/Loader",
		useCache = true,
	},

	["WisnuHub [FREE]"] = {
		url = "https://raw.githubusercontent.com/zeutronxsite/TjcqcZ2KDistrictV2/refs/heads/main/AcCVkYFU",
		useCache = nil,
	},

	["W424HUB [FREE]"] = {
		url = "https://raw.githubusercontent.com/zeutronxsite/N8GYFQc7DestrictV3/refs/heads/main/nTon3cet",
		useCache = nil,
	},

	["4LynxX [FREE]"] = {
		url = "https://raw.githubusercontent.com/zeutronxsite/2CHCDGJVDistictV3/refs/heads/main/GxHqbZZLua",
		useCache = nil,
	},
}

local selectedBolongScripts = {}

local function runBolongScript(optionName)
	local data = BOLONG_SCRIPT_DATA[optionName]

	if not data then
		Library:Notify("Script not found: " .. tostring(optionName), 5, "Error", "x-circle")
		return false
	end

	Library:Notify("Executing " .. optionName .. "...", 4, "Status", "check")
	task.wait(0.5)

	local ok, err = pcall(function()
		if data.useCache ~= nil then
			loadstring(game:HttpGet(data.url, data.useCache))()
		else
			loadstring(game:HttpGet(data.url))()
		end
	end)

	if not ok then
		Library:Notify(
			tostring(optionName) .. " failed: " .. tostring(err),
			5,
			"Error",
			"x-circle"
		)

		return false
	end

	return true
end

MainTab:CreateMultiDropdown({
	Name = "Select Scripts",
	Icon = "layers",
	Options = BOLONG_SCRIPT_OPTIONS,
	Default = {},
	Placeholder = "None selected",
	Flag = "BolongHubMulti",
	Tooltip = "Select one or more scripts to execute",
	Callback = function(list)
		selectedBolongScripts = toSelectionList(list)
	end,
})

MainTab:CreateButton({
	Name = "Execute Selected Scripts",
	Icon = "play",
	Tooltip = "Run all selected scripts",
	Callback = function()
		if type(selectedBolongScripts) ~= "table" or #selectedBolongScripts == 0 then
			Library:Notify("Please select at least one script!", 5, "Error", "x-circle")
			return
		end

		local count = #selectedBolongScripts

		Library:Notify(
			"Executing " .. count .. " script(s)...",
			4,
			"Status",
			"check"
		)

		task.spawn(function()
			local successCount = 0
			local failCount = 0

			for i, scriptName in ipairs(selectedBolongScripts) do
				local ok = runBolongScript(scriptName)

				if ok then
					successCount = successCount + 1
				else
					failCount = failCount + 1
				end

				if i < count then
					task.wait(1.2)
				end
			end

			if failCount == 0 then
				Library:Notify(
					"All selected scripts executed successfully!",
					6,
					"Executed Scripts",
					"check"
				)
			else
				Library:Notify(
					"Finished: " .. successCount .. " success, " .. failCount .. " failed.",
					6,
					"Execution Result",
					"alert-triangle"
				)
			end
		end)
	end,
})

MainTab:CreateSection("Auto Farm")

MainTab:CreateParagraph({
	Title = "🛡️ System Information",
	Content = "This feature is coming soon!"
})
