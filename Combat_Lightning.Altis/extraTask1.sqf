//  extratask1.sqf  //
if (!isServer) exitWith {};
/*	
[west, "parentTask2", ["This is the parent task 2.", "Parent task 2", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
[west, ["subTask2", "parentTask2"], ["This is the subTask 2.", "subTask2", "cookiemarker2"], objNull, 1, 3, true] call BIS_fnc_taskCreate;
*/
_null0 = [] spawn {
sleep 1;
	0 = [] spawn {
		[west, ["task0"], ["Meet with Kouris", "Meet with Kouris", ""], getPosATL Kouris,"Created",10,true,"talk1",true] remoteExec ["BIS_fnc_taskCreate", 0];
		waitUntil{sleep 1;(({isPlayer _x && _x distance2d (getPos Kouris) < 2} count (if ismultiplayer then {playableunits} else {switchableunits}) > 0));};
		[west, ["subtask0", "task0"], ["Intel in BackPack", "Intel in BackPack", ""], getPosATL Kouris,"Created",10,true,"listen",true] remoteExec ["BIS_fnc_taskCreate", 0];
		waitUntil{sleep 1;(({isPlayer _x && _x distance (getPos Kouris) < 3} count (if ismultiplayer then {playableunits} else {switchableunits}) > 0));};
		["task0", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

	};
	waitUntil{((["task0"] call BIS_fnc_taskCompleted) AND (["subtask0"] call BIS_fnc_taskCompleted))};
	0 = [] spawn {
		[west,["task1"],["Destroy enemy tanks","Destroy enemy tanks",""], getPosATL envee1,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		["TaskAssigned", ["Destroy Tanks!", 5]] call BIS_fnc_showNotification;
		waitUntil{(!(alive envee1) AND !(alive envee2))};
		["task1", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[west,["task2"],["Destroy high-value-target","Destroy high-value-target",""], getPosATL Attar,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{!(alive Attar)};
		["task2", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[resistance,["task1"],["Destroy enemy anti-air and mobile-arty","Destroy enemy anti-air and mobile-arty",""], getPosATL envee1,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{(!(alive envee1) AND !(alive envee2))};
		["task1", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[resistance,["task2"],["Destroy high-value-target","Destroy high-value-target",""], getPosATL Attar ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{!(alive Attar)};
		["task2", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[civilian,["task1"],["Destroy enemy anti-air and mobile-arty","Destroy enemy anti-air and mobile-arty",""], getPosATL envee1,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{(!(alive envee1) AND !(alive envee2))};
		["task1", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
	0 = [] spawn {
		[civilian,["task2"],["Destroy high-value-target","Destroy high-value-target",""], getPosATL Attar,1,2,true,"destroy"] call BIS_fnc_taskCreate;
		waitUntil{!(alive Attar)};
		["task2", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	};
};

_null1 = [] spawn {while {not isnull envee1} do {"envee1" setMarkerPos getPos envee1; sleep 0.5;}; };
_null2 = [] spawn {while {not isnull envee2} do {"envee2" setMarkerPos getPos envee2; sleep 0.5;}; };

