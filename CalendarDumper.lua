local frame = CreateFrame("FRAME") -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED") -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT") -- Fired when about to log out
local localizationData = {}
local holidayInfo = {}
local pvpInfo = {}
local dungeonInfo = {}
local raidInfo = {}

local formatOutput = "table" -- table or string
local eventList = ""

if HolidayLocalization == nil then
	HolidayLocalization = {}
end

if DungeonLocalization == nil then
	DungeonLocalization = {}
end

function dumpTable(table, depth)
  if (depth > 200) then
    print("Error: Depth > 200 in dumpTable()")
    return
  end
  for k,v in pairs(table) do
    if (type(v) == "table") then
      print(string.rep("  ", depth)..k..":")
      dumpTable(v, depth+1)
    else
      print(string.rep("  ", depth)..k..": ",v)
    end
  end
end

-- Dump Holiday information based on Holiday Type (H = Holiday, P = PVP)
function dumpHoliday(holidayType, holidayName, cmonthOffset, cmonthDay, cindex)
	local holidayInfoData
	local holidayInfoDump = {}
	holidayInfoData = C_Calendar.GetHolidayInfo(cmonthOffset,cmonthDay,cindex)
	if formatOutput == "table" then
		if holidayType == "H" then
			holidayInfo[holidayName] = {["name"]=holidayInfoData["name"], ["description"]=holidayInfoData["description"]} --["texture"]=holidayInfoData["texture"]
		elseif holidayType == "P" then
			pvpInfo[holidayName] = {["name"]=holidayInfoData["name"], ["description"]=holidayInfoData["description"]} --["texture"]=holidayInfoData["texture"]
		end
	elseif formatOutput == "string" then
		if holidayType == "H" then
			table.insert(holidayInfo, {["L."..holidayName.."Name"] = holidayInfoData["name"], ["L."..holidayName.."Description"] = holidayInfoData["description"]})
		elseif holidayType == "P" then
			table.insert(pvpInfo, {["L."..holidayName.."Name"] = holidayInfoData["name"], ["L."..holidayName.."Description"] = holidayInfoData["description"]})
		end
	end
end

function dumpDungeons(dungeons)
	for _, dungeon in next, dungeons do
		local dungeonName = dungeon["title"]
		if formatOutput == "table" then
			dungeonInfo[dungeonName:gsub(' ', '')] = {["name"]=dungeonName}
		elseif formatOutput == "string" then
			table.insert(dungeonInfo, {["L."..dungeonName.."Name"] =dungeonName})
		end
	end
end

function dumpRaids(raids)
	for _, raid in next, raids do
		local raidName = raid["title"]
		if formatOutput == "table" then
			raidInfo[raidName:gsub(' ', '')] = {["name"]=raidName}
		elseif formatOutput == "string" then
			table.insert(raidInfo, {["L."..raidName.."Name"] =raidName})
		end
	end
end

function frame:OnEvent(event, arg1)
	local getLocalString = tostring(GetLocale())
	if event == "ADDON_LOADED" and arg1 == "CalendarDumper" then
	print("Current Language: "..getLocalString)
	elseif event == "PLAYER_LOGOUT" then
		--Save to SavedVariables
		HolidayLocalization[getLocalString] = {["CalendarHolidays"] = holidayInfo, ["CalendarPVP"] = pvpInfo}
		DungeonLocalization[getLocalString] = {["Dungeons"] = dungeonInfo, ["Raids"] = raidInfo}
	end
end
frame:SetScript("OnEvent", frame.OnEvent)

-- Dump current VIEWED month and following 1 month holidays
local function CalendarDumpCommands(msg, editbox)
	if msg == 'wotlk' then
		eventList = "wotlk"
		print("Setting output to WotLK events")
	else
		print("Setting output to Classic events")
	end
	-- local getMonthInfo = C_Calendar.GetMonthInfo()
	-- print("-------------------------------------")
	-- C_Calendar.SetAbsMonth(1, 2023) -- January
	-- dumpHoliday("H","DarkmoonFaireMulgore",0,1,2)
	-- dumpHoliday("P","WarsongGulch",0,6,2) -- PVP Holiday (Only needed once)
	-- dumpHoliday("P","ArathiBasin",0,13,1) -- PVP Holiday (Only needed once)
	-- dumpHoliday("H","StranglethornFishingExtravaganza",0,15,2)
	-- dumpHoliday("H","LunarFestival",0,20,1)
	-- if eventList == "wotlk" then dumpHoliday("P","StrandOfTheAncients",0,20,2) end -- PVP Holiday (Only needed once)
	-- if eventList == "wotlk" then dumpHoliday("P","IsleOfConquest",0,27,2) end -- PVP Holiday (Only needed once)
	-- print("Dumped January Holidays")
	
	-- C_Calendar.SetAbsMonth(2, 2023) -- February
	-- dumpHoliday("P","AlteracValley",0,3,2) -- PVP Holiday (Only needed once)
	-- dumpHoliday("H","LoveisintheAir",0,6,2)
	-- if eventList == "wotlk" then dumpHoliday("P","EyeOfTheStorm",0,10,4) end -- PVP Holiday (Only needed once)
	-- print("Dumped February Holidays")

	-- C_Calendar.SetAbsMonth(3, 2023) -- March
	-- print("Dumped March Holidays")
		
	-- C_Calendar.SetAbsMonth(4, 2023) -- April
	-- dumpHoliday("H","Noblegarden",0,9,1)
	-- print("Dumped April Holidays")
	
	-- C_Calendar.SetAbsMonth(5, 2023) -- May
	-- dumpHoliday("H","ChildrensWeek",0,1,1)
	-- print("Dumped May Holidays")
	
	-- C_Calendar.SetAbsMonth(6, 2023) -- June
	-- dumpHoliday("H","DarkmoonFaireElwynn",0,4,1)
	-- dumpHoliday("H","MidsummerFireFestival",0,21,1)
	-- print("Dumped June Holidays")
	
	-- C_Calendar.SetAbsMonth(7, 2023) -- July
	-- dumpHoliday("H","FireworksSpectacular",0,5,3)
	-- print("Dumped July Holidays")
	
	-- C_Calendar.SetAbsMonth(8, 2023) -- August
	-- print("Dumped August Holidays")
	
	-- C_Calendar.SetAbsMonth(9, 2023) -- September
	-- if eventList == "wotlk" then dumpHoliday("H","Brewfest",0,20,1) end
	-- dumpHoliday("H","HarvestFestival",0,26,1)
	-- print("Dumped September Holidays")

	-- C_Calendar.SetAbsMonth(10, 2023) -- October
	-- dumpHoliday("H","HallowsEnd",0,18,1)
	-- print("Dumped October Holidays")
	
	-- C_Calendar.SetAbsMonth(11, 2023) -- November
	-- if eventList == "wotlk" then dumpHoliday("H","DayOfTheDead",0,1,2) end
	-- if eventList == "wotlk" then dumpHoliday("H","PilgrimsBounty",0,21,1) end
	-- print("Dumped November Holidays")
	
	-- C_Calendar.SetAbsMonth(12, 2023) -- December
	-- dumpHoliday("H","WintersVeil", 0,15,1)
	-- print("Dumped December Holidays")
	-- print("-------------------------------------")

	dumpRaids(C_Calendar.EventGetTextures(0))
	print("Dumped raid names")

	dumpDungeons(C_Calendar.EventGetTextures(1))
	print("Dumped dungeon names")

	print("-------------------------------------")
	print("Dumping complete!")
	print("Make sure to EXIT at this time (reload does not save changes)")
end

SLASH_CALENDARDUMP1, SLASH_CALENDARDUMP2 = '/cd', '/calendardump'

SlashCmdList["CALENDARDUMP"] = CalendarDumpCommands