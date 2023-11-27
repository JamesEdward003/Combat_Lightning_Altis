params ["_mirrors",["_mirrorEHs",[]]];

if (isServer) then {
	MIL_fnc_Mirror_AddEventHandlers = compileFinal preprocessFileLineNumbers "MIL_Mirror\addEventHandlers.sqf";
	MIL_fnc_Mirror_BrokenGlass = compileFinal preprocessFileLineNumbers "MIL_Mirror\createBrokenGlass.sqf";
	MIL_fnc_Mirror_Reflection = compileFinal preprocessFileLineNumbers "MIL_Mirror\reflection.sqf";
	MIL_fnc_Mirror_CancelMirror = compileFinal preprocessFileLineNumbers "MIL_Mirror\cancelMirror.sqf";
	
	{
		publicVariable _x;
	} forEach [
		"MIL_fnc_Mirror_AddEventHandlers",
		"MIL_fnc_Mirror_BrokenGlass",
		"MIL_fnc_Mirror_Reflection",
		"MIL_fnc_Mirror_CancelMirror"
	];

	///////
	//Create hit counter for mirror.
	///////

	{
		_x setVariable [format["%1_hits",_x],0,true];
	} forEach _mirrors;
	
	missionNamespace setVariable ["MIL_fnc_MirrorInitialised",true,true];
};

if (hasInterface) then {
	waitUntil {missionNamespace getVariable ["MIL_fnc_MirrorInitialised",false]};
	
	{
		_returnEHs = [_x] call MIL_fnc_Mirror_AddEventHandlers;
		_returnReflection = [_x] call MIL_fnc_Mirror_Reflection;
		_mirrorEHs pushBack (_returnEHs + [_returnReflection]);
		sleep 0.1;
	} forEach _mirrors;
};

player setVariable ["MirrorEHs",_mirrorEHs,false];