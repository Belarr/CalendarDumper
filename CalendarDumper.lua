local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
local holidayInfo = {};
local pvpInfo = {};
	
function dumpHoliday(cmonthOffset,cmonthDay,cindex)
	local holidayInfoData;
	local holidayInfoDump = {};
	holidayInfoData = C_Calendar.GetHolidayInfo(cmonthOffset,cmonthDay,cindex);
	holidayInfoDump = {["name"]=holidayInfoData["name"], ["description"]=holidayInfoData["description"], ["texture"]=holidayInfoData["texture"]};
	return holidayInfoDump;
end

function frame:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "CalendarDumper" then
	elseif event == "PLAYER_LOGOUT" then
		-- Save to SavedVariables
		CalendarHolidays = holidayInfo;
		CalendarPVP = pvpInfo;
	end
end
frame:SetScript("OnEvent", frame.OnEvent);

-- Dump current VIEWED month and following 1 month holidays
local function MyAddonCommands(msg, editbox)
	local getMonthInfo = C_Calendar.GetMonthInfo();
	if getMonthInfo["month"] == 1 and getMonthInfo["year"] == 2023 then
		-- January/February
		holidayInfo["DARKMOON_FAIRE_TB"] = dumpHoliday(0,1,2);
		holidayInfo["STRANGLETHORN_FISHING_EXTRAVAGANZA"] = dumpHoliday(0,15,2);
		holidayInfo["LUNAR_FESTIVAL"] = dumpHoliday(0,20,1);
		holidayInfo["LOVE_IS_IN_THE_AIR"] = dumpHoliday(1,6,2);
		print("Dumped January/February Holidays");
		
		-- Dump PVP Holidays (ONLY NEEDED ONCE)
		pvpInfo["WARSONG_GULCH"] = dumpHoliday(0,6,2);
		pvpInfo["ARATHI_BASIN"] = dumpHoliday(0,13,1);	
		pvpInfo["ALTERAC_VALLEY"] = dumpHoliday(1,3,2);
		print("Dumped PVP Holidays");
	elseif getMonthInfo["month"] == 4 and getMonthInfo["year"] == 2023 then
		-- April/May
		holidayInfo["NOBLEGARDEN"] = dumpHoliday(0,9,1);
		holidayInfo["CHILDRENS_WEEK"] = dumpHoliday(1,3,1);
		print("Dumped April/May Holidays");
	elseif getMonthInfo["month"] == 6 and getMonthInfo["year"] == 2023 then
		-- June/July
		holidayInfo["MIDSUMMER_FIRE_FESTIVAL"] = dumpHoliday(0,21,1);
		holidayInfo["FIREWORKS_SPECTACULAR"] = dumpHoliday(1,5,3);
		print("Dumped June/July Holidays");
	elseif getMonthInfo["month"] == 9 and getMonthInfo["year"] == 2023 then
		-- September
		holidayInfo["HARVEST_FESTIVAL"] = dumpHoliday(0,26,1)
		print("Dumped September Holidays");
	elseif getMonthInfo["month"] == 10 and getMonthInfo["year"] == 2023 then
		-- October
		holidayInfo["HALLOWS_END"] = dumpHoliday(0,18,1);
		print("Dumped October Holidays");
	elseif getMonthInfo["month"] == 12 and getMonthInfo["year"] == 2023 then
		-- December
		holidayInfo["HALLOWS_END"] = dumpHoliday(0,15,1);
		print("Dumped December Holidays");
	end
end

SLASH_CALENDARDUMP1, SLASH_CALENDARDUMP2 = '/cd', '/calendardump'

SlashCmdList["CALENDARDUMP"] = MyAddonCommands