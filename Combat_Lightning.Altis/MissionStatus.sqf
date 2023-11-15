// execVM "MissionStatus.sqf"; //
_MissionStatus = "MissionStatus" call BIS_fnc_getParamValue;
if !(_MissionStatus isEqualTo 2) exitWith {};

if isMultiPlayer exitWith {

	call BIS_fnc_showMissionStatus;

	[playerSide, "HQ"] commandChat "Mission Status (Right Side of Monitor) - Enabled!";
}


