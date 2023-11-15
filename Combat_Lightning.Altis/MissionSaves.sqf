// "MissionSaves.sqf" //

_MissionSaves = "MissionSaves" call BIS_fnc_getParamValue;
if !(_MissionSaves isEqualTo 2) exitWith {};

_MissionSaves = switch true do
{
	case 1: {[false, false]};	// saving disabled, doesn't autosave
	case 2: {[false, true]};	// saving disabled, does autosave
	case 3: {[true, false]};	// saving enabled, doesn't autosave
	case 4: {[true, true]};		// saving enabled, does autosave
};
enableSaving _MissionSaves;

waitUntil { !isNil {player getVariable "LoadoutDone"} };

[playerSide, "HQ"] commandChat format ["%1 be sure to save game!",name player];
