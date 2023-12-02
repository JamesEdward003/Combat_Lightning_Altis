// heliEnd.sqf //
private ["_heli"];
_heli = _this select 0;

_airName = switch (playerSide) do 
	{
		case west: 			{"Transport_West"};
		case east: 			{"Transport_East"};
		case resistance: 	{"Transport_Guer"};
		case civilian: 		{"Transport_Civ"};
	};

//waitUntil {count (fullCrew [_heli, "cargo"]) < 1};

if (!isNil {missionNamespace getVariable _airName}) then {
	deleteMarker _airName;
	deleteMarker format ["%1_Start",_airName];
	deleteMarker format ["%1_Dest",_airName];
	_RallyProfile = missionNamespace getVariable _airName;
	_CampFireID = _RallyProfile select 0;
	CampFire = _CampFireID call BIS_fnc_objectFromNetId;
	deleteVehicle CampFire;
	_heliPadID = _RallyProfile select 1;
	heliPad = _heliPadID call BIS_fnc_objectFromNetId;
	deleteVehicle heliPad;
	{deletevehicle _x} foreach (crew _heli) + [_heli];
	missionNamespace setVariable [_airName,nil];
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1 ready for reassignment!</t>", _airName];
};

PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat format["%1 ready for reassignment!", _airName];
