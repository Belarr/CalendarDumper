# CalendarDumper
Calendar Dumper addon for World of Warcraft WotLK that extracts localized calendar strings for each Holiday and PVP event for use in ClassicCalendar

## Use
Log in and run /cd (classic|wotlk), then exit the game. Data will not save properly if you /reload.

## Output
The output is saved to "CalendarDumper.lua" in the following folder: WTF\Account\\<account\>\\<realm\>\\<character name\>\SavedVariables

The resulting format is as follows:

```
Localization = {
	[<4 letter locale string>] = {
		["CalendarPVP"] = {
			[<Event Name>] = {
				["name"] = "Example Name",
				["description"] = "Example Description",
			},
		},
		["CalendarHolidays"] = {
			[<Event Name>] = {
				["name"] = "Example Name",
				["description"] = "Example Description",
		},
	},
}
```

## Events captured for Classic

**Holidays:**
- DarkmoonFaireElwynn
- DarkmoonFaireMulgore
- StranglethornFishingExtravaganza
- LunarFestival
- LoveisintheAir
- Noblegarden
- ChildrensWeek
- MidsummerFireFestival
- FireworksSpectacular
- HarvestFestival
- HallowsEnd
- WintersVeil

**PVP Holidays:**
- WarsongGulch
- ArathiBasin
- AlteracValley

## Additional events captured for WotLK

**Holidays:**
- Brewfest
- DayOfTheDead
- PilgrimsBounty
- 
**PVP Holidays:**
- EyeOfTheStorm
- IsleOfConquest
- StrandOfTheAncients

## Supported Locales
- "frFR": French (France)
- "deDE": German (Germany)
- "enUS": English (America)
- "enGB": English (Great Britain)
	- "enGB" defaults to "enUS"
- "koKR": Korean (Korea)
- "zhCN": Chinese (China) (simplified)
- "zhTW": Chinese (Taiwan) (traditional)
- "ruRU": Russian (Russia)
- "esES": Spanish (Spain)
- "esMX": Spanish (Mexico)
- "ptBR": Portuguese (Brazil)
