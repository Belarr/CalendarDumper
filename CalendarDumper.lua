local frame = CreateFrame("FRAME") -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED") -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT") -- Fired when about to log out
local localizationData = {}
local holidayInfo = {}
local pvpInfo = {}
local formatOutput = "string" -- table or string
if Localization == nil then
	Localization = {}
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
			table.insert(holidayInfo, ["L."..holidayName.."Name"] = holidayInfoData["name"])
			table.insert(holidayInfo, ["L."..holidayName.."Description"] = holidayInfoData["description"])
		elseif holidayType == "P" then
			table.insert(pvpInfo, ["L."..holidayName.."Name"] = holidayInfoData["name"])
			table.insert(pvpInfo, ["L."..holidayName.."Description"] = holidayInfoData["description"])
		end
	end
end

function frame:OnEvent(event, arg1)
	local getLocalString = tostring(GetLocale())
	if event == "ADDON_LOADED" and arg1 == "CalendarDumper" then
	print("Current Language: "..getLocalString)
	elseif event == "PLAYER_LOGOUT" then
		--Save to SavedVariables
		--CalendarHolidays = holidayInfo
		--CalendarPVP = pvpInfo
		Localization[getLocalString] = {["CalendarHolidays"] = holidayInfo, ["CalendarPVP"] = pvpInfo}
		--Localization = localizationData
	end
end
frame:SetScript("OnEvent", frame.OnEvent)

-- Dump current VIEWED month and following 1 month holidays
local function MyAddonCommands(msg, editbox)
	local getMonthInfo = C_Calendar.GetMonthInfo()
	if getMonthInfo["month"] == 1 and getMonthInfo["year"] == 2023 then
		-- January/February
		dumpHoliday("H","DarkmoonFaireMulgore",0,1,2)
		dumpHoliday("H","StranglethornFishingExtravaganza",0,15,2)
		dumpHoliday("H","LunarFestival",0,20,1)
		dumpHoliday("H","LoveisintheAir",1,6,2)
		print("Dumped January/February Holidays")
		
		-- Dump PVP Holidays (ONLY NEEDED ONCE)
		dumpHoliday("P","WarsongGulch",0,6,2)
		dumpHoliday("P","ArathiBasin",0,13,1)	
		dumpHoliday("P","AlteracValley",1,3,2)
		print("Dumped PVP Holidays")
	elseif getMonthInfo["month"] == 4 and getMonthInfo["year"] == 2023 then
		-- April/May
		dumpHoliday("H","Noblegarden",0,9,1)
		dumpHoliday("H","ChildrensWeek",1,3,1)
		print("Dumped April/May Holidays")
	elseif getMonthInfo["month"] == 6 and getMonthInfo["year"] == 2023 then
		-- June/July
		dumpHoliday("H","DarkmoonFaireElwynn",0,4,1)
		dumpHoliday("H","MidsummerFireFestival",0,21,1)
		dumpHoliday("H","FireworksSpectacular",1,5,3)
		print("Dumped June/July Holidays")
	elseif getMonthInfo["month"] == 9 and getMonthInfo["year"] == 2023 then
		-- September
		dumpHoliday("H","HarvestFestival",0,26,1)
		print("Dumped September Holidays")
	elseif getMonthInfo["month"] == 10 and getMonthInfo["year"] == 2023 then
		-- October
		dumpHoliday("H","HallowsEnd",0,18,1)
		print("Dumped October Holidays")
	elseif getMonthInfo["month"] == 12 and getMonthInfo["year"] == 2023 then
		-- December
		dumpHoliday("H","WintersVeil", 0,15,1)
		print("Dumped December Holidays")
	end
end

SLASH_CALENDARDUMP1, SLASH_CALENDARDUMP2 = '/cd', '/calendardump'

SlashCmdList["CALENDARDUMP"] = MyAddonCommands