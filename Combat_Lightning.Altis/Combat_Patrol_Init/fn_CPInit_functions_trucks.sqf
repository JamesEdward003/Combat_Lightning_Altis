BIS_fnc_CPObjSetup {
{#line 1 "A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj1Setup.sqf"
BIS_CP_supportClasses = switch (BIS_CP_enemySide) do {
case WEST: {["B_Truck_01_ammo_F", "B_Truck_01_fuel_F", "B_Truck_01_Repair_F"]};
case EAST: {["O_Truck_03_ammo_F", "O_Truck_03_fuel_F", "O_Truck_03_repair_F"]};
case RESISTANCE: {["I_Truck_02_ammo_F", "I_Truck_02_fuel_F", "I_Truck_02_box_F"]};
};

_roads = BIS_CP_targetLocationPos nearRoads BIS_CP_radius_core;
_pos = [];
_dir = 0;
_vehType = BIS_CP_supportClasses select 1;
if (count _roads > 0) then {
_road = selectRandom _roads;
_connectedRoads = roadsConnectedTo _road;
_pos = position _road;
if (count _connectedRoads > 0) then {
_dir = _road getDir ((roadsConnectedTo _road) select 0);
} else {
_dir = random 360;
};
} else {
_pos = [BIS_CP_targetLocationPos, random BIS_CP_radius_core, random 360] call BIS_fnc_relPos;
_pos = [_pos, _vehType] call BIS_fnc_CPFindEmptyPosition;
_dir = random 360;
};
_tgt = createVehicle [_vehType, _pos, [], 0, "CAN_COLLIDE"];
_tgt setDir _dir;
_tgt setVehicleLock "LOCKED";
missionNamespace setVariable ["BIS_CP_objective_vehicle1", _tgt, TRUE];

_roads = (BIS_CP_targetLocationPos nearRoads BIS_CP_radius_core) select {_x distance BIS_CP_objective_vehicle1 > 150};
_pos = [];
_dir = 0;
_vehType = BIS_CP_supportClasses select 0;
if (count _roads > 0) then {
_road = selectRandom _roads;
_pos = position _road;
if (count roadsConnectedTo _road > 0) then {_dir = _road getDir ((roadsConnectedTo _road) select 0)} else {_dir = random 360};
} else {
_pos = [BIS_CP_targetLocationPos, random BIS_CP_radius_core, random 360] call BIS_fnc_relPos;
_pos = [_pos, _vehType] call BIS_fnc_CPFindEmptyPosition;
_dir = random 360;
};
_tgt = createVehicle [_vehType, _pos, [], 0, "CAN_COLLIDE"];
_tgt setDir _dir;
_tgt setVehicleLock "LOCKED";
_tgt addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 2];
missionNamespace setVariable ["BIS_CP_objective_vehicle2", _tgt, TRUE];}
};

BIS_fnc_CPObjSetupClient {
{#line 1 "A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj1SetupClient.sqf"
waitUntil {!isNull (missionNamespace getVariable ["BIS_CP_objective_vehicle1", objNull]) && !isNull (missionNamespace getVariable ["BIS_CP_objective_vehicle2", objNull])};

_null = [] spawn {
if ({damage _x > 0.5 && !canMove _x} count [BIS_CP_objective_vehicle1, BIS_CP_objective_vehicle2] == 0) then {
[{(damage BIS_CP_objective_vehicle1 > 0.5 && !canMove BIS_CP_objective_vehicle1) || (damage BIS_CP_objective_vehicle2 > 0.5 && !canMove BIS_CP_objective_vehicle2)}, 1] call BIS_fnc_CPWaitUntil;
playSound ((selectRandom ["cp_partial_objective_accomplished_1", "cp_partial_objective_accomplished_2", "cp_partial_objective_accomplished_3"]) + BIS_CP_protocolSuffix);
};
};}
};

BIS_fnc_CPObjTasksSetup {
{#line 1 "A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj1TasksSetup.sqf"
_null = [] spawn {
[BIS_CP_grpMain, "BIS_CP_taskSurvive", ["STR_A3_combatpatrol_mission_14", "STR_A3_combatpatrol_mission_15", ""], nil, FALSE, nil, FALSE, "Heal", FALSE] call BIS_fnc_taskCreate;
[BIS_CP_grpMain, "BIS_CP_taskMain", ["STR_A3_combatpatrol_mission_59", ["STR_A3_combatpatrol_mission_18", BIS_CP_targetLocationName], ""], nil, FALSE, nil, TRUE, "Attack"] call BIS_fnc_taskCreate;
sleep 0.5;
[BIS_CP_grpMain, ["BIS_CP_task1", "BIS_CP_taskMain"], ["STR_A3_combatpatrol_mission_61", "STR_A3_combatpatrol_mission_60", ""], nil, TRUE, 2, nil, "Target"] call BIS_fnc_taskCreate;
[BIS_CP_grpMain, ["BIS_CP_task2", "BIS_CP_taskMain"], ["STR_A3_combatpatrol_mission_63", "STR_A3_combatpatrol_mission_62", ""], nil, FALSE, 2, nil, "Target"] call BIS_fnc_taskCreate;
[BIS_CP_grpMain, "BIS_CP_taskExfil", ["STR_A3_combatpatrol_mission_16", "STR_A3_combatpatrol_mission_17", ""], BIS_CP_exfilPos, FALSE, 1, FALSE, "Exit", TRUE] call BIS_fnc_taskCreate;
};}
};

BIS_fnc_CPObjBriefingSetup = {
{#line 1 "A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj1BriefingSetup.sqf"
player createDiaryRecord ["Diary", [localize "STR_A3_combatpatrol_mission_7", localize "STR_A3_combatpatrol_mission_41"]];
player createDiaryRecord ["Diary", [localize "STR_A3_showcase_infantry_briefing_execution_title", (localize "STR_A3_combatpatrol_mission_42") + "<br/>" + (localize "STR_A3_combatpatrol_mission_43") + "<br/>" + (localize "STR_A3_combatpatrol_mission_44")]];
player createDiaryRecord ["Diary", [localize "STR_A3_showcase_infantry_briefing_mission_title", localize "STR_A3_combatpatrol_mission_45"]];
player createDiaryRecord ["Diary", [localize "STR_A3_showcase_infantry_briefing_situation_title", localize "STR_A3_combatpatrol_mission_46"]];}
};

BIS_fnc_CPObjHandle = {
{#line 1 "A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj1Handle.sqf"
_null = [] spawn {
[{damage BIS_CP_objective_vehicle1 > 0.5 && !canMove BIS_CP_objective_vehicle1}, 1] call BIS_fnc_CPWaitUntil;
if !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE]) then {
["BIS_CP_task1", "Succeeded"] call BIS_fnc_taskSetState;
};
BIS_CP_alarm = TRUE;
};
_null = [] spawn {
[{damage BIS_CP_objective_vehicle2 > 0.5 && !canMove BIS_CP_objective_vehicle2}, 1] call BIS_fnc_CPWaitUntil;
if !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE]) then {
["BIS_CP_task2", "Succeeded"] call BIS_fnc_taskSetState;
};
BIS_CP_alarm = TRUE;
};
_null = [] spawn {
sleep 5;
[{("BIS_CP_task1" call BIS_fnc_taskCompleted) && ("BIS_CP_task2" call BIS_fnc_taskCompleted)}, 1] call BIS_fnc_CPWaitUntil;
sleep 0.5;
if !(missionNamespace getVariable ["BIS_CP_objectiveFailed", FALSE]) then {
missionNamespace setVariable ["BIS_CP_objectiveDone", TRUE, TRUE];
["BIS_CP_taskMain", "Succeeded"] call BIS_fnc_taskSetState;
};
};}
};

BIS_fnc_CPObjHeavyLosses {
{#line 1 "A3\Functions_F_Patrol\CombatPatrol\Objectives\fn_CPObj1HeavyLosses.sqf"
if !("BIS_CP_taskMain" call BIS_fnc_taskCompleted) then {
missionNamespace setVariable ["BIS_CP_objectiveFailed", TRUE, TRUE];
if !("BIS_CP_task1" call BIS_fnc_taskCompleted) then {
["BIS_CP_task1", "Canceled", FALSE] call BIS_fnc_taskSetState;
};
if !("BIS_CP_task2" call BIS_fnc_taskCompleted) then {
["BIS_CP_task2", "Canceled", FALSE] call BIS_fnc_taskSetState;
};
["BIS_CP_taskMain", "Canceled"] call BIS_fnc_taskSetState;
};}
};


//_tgt1 = getPosATL BIS_CP_objective_vehicle1;
//_tgt2 = getPosATL BIS_CP_objective_vehicle2;