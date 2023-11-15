//  extratask2.sqf  //
if (!isServer) exitWith {};

_null3 = [] spawn {
sleep 1;
	0 = [] spawn {
		[west,["task3"],["Destroy enemy anti-air and tank","Destroy enemy anti-air and tank",""], getPosATL envee3 ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{(!(alive envee3) AND !(alive envee4))};
		["task3", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[west,["task4"],["Destroy high-value-target","Destroy high-value-target",""], getPosATL Akhanteros ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{!(alive Akhanteros)};
		["task4", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[resistance,["task3"],["Destroy enemy anti-air and tank","Destroy enemy anti-air and tank",""], getPosATL envee3 ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{(!(alive envee3) AND !(alive envee4))};
		["task3", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[resistance,["task4"],["Destroy high-value-target","Destroy high-value-target",""], getPosATL Akhanteros ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{!(alive Akhanteros)};
		["task4", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[civilian,["task3"],["Destroy enemy anti-air and tank","Destroy enemy anti-air and tank",""], getPosATL envee3 ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{(!(alive envee3) AND !(alive envee4))};
		["task3", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[civilian,["task4"],["Destroy high-value-target","Destroy high-value-target",""], getPosATL Akhanteros ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{!(alive Akhanteros)};
		["task4", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
};
_null4 = [] spawn {while {not isnull envee3} do {"envee3" setMarkerPos getPos envee3; sleep 0.5;}; };
_null5 = [] spawn {while {not isnull envee4} do {"envee4" setMarkerPos getPos envee4; sleep 0.5;}; };

