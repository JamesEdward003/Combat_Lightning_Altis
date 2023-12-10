//  "BaseStart.sqf"  //
{ _x disableAi "MOVE" } forEach units group player;

addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if (!isNil "BIS_CP_initDone" && _mapIsOpened) then {	
		{ _x enableAi "MOVE" } forEach units group player;
		[["BaseInfo","BaseManager"],20,"",35,"",true,true,false,false] call BIS_fnc_advHint;
		//["<t color='#2cb88e' size='.88'>You have selected the Base Start parameter.<br />You will start at the base!</t>",0,.01,10,1] spawn BIS_fnc_dynamicText;
		//hintsilent format ["%1",_thisEventHandler];
		removeMissionEventHandler ["Map", _thisEventHandler];
	};
}];
if (("BI_CP_startLocation" call BIS_fnc_getParamValue) isEqualTo 1) then {

	if (("BIS_CP_locationSelection" call BIS_fnc_getParamValue) isEqualTo 0) then {
	["<t color='#FFCC33' size='1.2'>You are being teleported to the target location.<br />Select your target location!</t>",0,.01,30,1] spawn BIS_fnc_dynamicText;
	};
	waitUntil {!isNil "BIS_CP_initDone"};

	private _pos = getPos (leader group player);
	_wp = (group player) addWaypoint [_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "WEDGE";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointStatements ["true","{_x doFollow player} forEach units group this"];

	{_x action ["WEAPONONBACK", _x]} forEach units group player;

	[playerSide, "HQ"] commandChat "Open/Close map to enable ai movement!";

	[["SquadInfo","SquadManager"],20,"",35,"",true,true,false,false] call BIS_fnc_advHint;

	_respawncount = switch (playerSide) do {
		case west: 			{"respawn_count_west"};
		case east: 			{"respawn_count_east"};
		case resistance: 	{"respawn_count_guerrila"};
		case civilian:		{"respawn_count_civilian"};
	};
	_respawn = switch (playerSide) do {
		case west: 			{"respawn_west"};
		case east: 			{"respawn_east"};
		case resistance: 	{"respawn_guerrila"};
		case civilian:		{"respawn_civilian"};
	};
	_helipad = switch (playerSide) do {
		case west: 			{"respawn_west_helipad"};
		case east: 			{"respawn_east_helipad"};
		case resistance: 	{"respawn_guerrila_helipad"};
		case civilian:		{"respawn_civilian_helipad"};
	};
	_hpad = switch (playerSide) do {
		case west: 			{"hpad"};
		case east: 			{"hpad2"};
		case resistance: 	{"hpad3"};
		case civilian:		{"hpad5"};
	};
	_mrkrColor = switch (playerSide) do {
		case west: 			{"colorBLUFOR"};
		case east: 			{"colorOPFOR"};
		case resistance: 	{"colorIndependent"};
		case civilian:		{"ColorCivilian"};
	};  
	if (!(isNil {missionNamespace getVariable _respawncount})) then
		{
		_cnt = missionNamespace getVariable _respawncount;
		_mrkrname = format ["%1_%2",_respawn,_cnt];
		deleteMarker str _mrkrname;

		_respawnname = missionNamespace getVariable _respawn;
		_respawnID = _respawnname call BIS_fnc_objectFromNetId;				
		_respawnID call BIS_fnc_removeRespawnPosition;

		_helipadID = missionNamespace getVariable _helipad;
		_helipadname = _helipadID call BIS_fnc_objectFromNetId;
		deleteVehicle _helipadname;

		_cnt = _cnt + 1;
		
		_mrkrname = format ["%1_%2",_respawn,_cnt];
        _mrkr = createMarkerLocal [str _mrkrname, _pos];
        _mrkr setMarkerTypeLocal "respawn_inf";
        _mrkr setMarkerShapeLocal "Icon";
        _mrkr setMarkerTextLocal str _mrkrname;
        _mrkr setMarkerSizeLocal [1,1];
        _mrkr setMarkerColorLocal _mrkrColor;

		_respawnname = format ["%1_%2",_respawn,_cnt];
		_respawnname = [missionNamespace,str _mrkrname,_respawn] call BIS_fnc_addRespawnPosition;
		missionNamespace setVariable [_respawn, _respawnname, true];
		missionNamespace setVariable [_respawncount, _cnt, true];

	} else {		

		_cnt = 1;

		_mrkrname = format ["%1_%2",_respawn,_cnt];
        _mrkr = createMarkerLocal [str _mrkrname, _pos];
        _mrkr setMarkerTypeLocal "respawn_inf";
        _mrkr setMarkerShapeLocal "Icon";
        _mrkr setMarkerTextLocal str _mrkrname;
        _mrkr setMarkerSizeLocal [1,1];
        _mrkr setMarkerColorLocal _mrkrColor;

		_respawnname = format ["%1_%2",_respawn,_cnt];
		_respawnname = [missionNamespace,str _mrkrname,_respawn] call BIS_fnc_addRespawnPosition;
		//hintsilent format ["%1",_respawnname];
		missionNamespace setVariable [_respawn, _respawnname, true];
		missionNamespace setVariable [_respawncount, _cnt, true];
	};
	if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {{_x action ["nvGoggles", _x]} forEach units group player;};

} else {

	if (("BIS_CP_locationSelection" call BIS_fnc_getParamValue) isEqualTo 0) then {
	["<t color='#FFCC33' size='1.2'>You have selected the Base Start parameter.<br />You are being teleported to the target location first.<br />Select your target location!</t>",0,.01,10,1] spawn BIS_fnc_dynamicText;
};

fnc_teleportGroup = 
{
	params ["_group", "_position"];

	private _leader = leader _group;
	
	{
		private _dir = _leader getDir _x;
		private _dist = _x distance2D _leader;
		_x setPos (_position getPos [_dist, _dir]);
	}
	forEach units _group - [_leader];
	
	_leader setPos (_position getPos [0, 0]);
};

private _pos = getPos (leader group player);

waitUntil {!isNil "BIS_CP_initDone"};

[group player,_pos] call fnc_teleportGroup;

_dirTo = [(leader group player),BIS_CP_targetLocationPos] call BIS_fnc_dirTo;

{_x setDir _dirTo} forEach units group player;

_wp = (group player) addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointFormation "WEDGE";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","{_x doFollow player} forEach units group this"];

{_x action ["WEAPONONBACK", _x]} forEach units group player;

//waitUntil {!isNil "BIS_CP_initDone"};

[playerSide, "HQ"] commandChat "Open/Close map to enable ai movement!";

[["SquadInfo","SquadManager"],20,"",35,"",true,true,false,false] call BIS_fnc_advHint;

_respawncount = switch (playerSide) do {
	case west: 			{"respawn_count_west"};
	case east: 			{"respawn_count_east"};
	case resistance: 	{"respawn_count_guerrila"};
	case civilian:		{"respawn_count_civilian"};
};
_respawn = switch (playerSide) do {
	case west: 			{"respawn_west"};
	case east: 			{"respawn_east"};
	case resistance: 	{"respawn_guerrila"};
	case civilian:		{"respawn_civilian"};
};
_helipad = switch (playerSide) do {
	case west: 			{"respawn_west_helipad"};
	case east: 			{"respawn_east_helipad"};
	case resistance: 	{"respawn_guerrila_helipad"};
	case civilian:		{"respawn_civilian_helipad"};
};
_hpad = switch (playerSide) do {
	case west: 			{"hpad"};
	case east: 			{"hpad2"};
	case resistance: 	{"hpad3"};
	case civilian:		{"hpad5"};
};
_mrkrColor = switch (playerSide) do {
	case west: 			{"colorBLUFOR"};
	case east: 			{"colorOPFOR"};
	case resistance: 	{"colorIndependent"};
	case civilian:		{"ColorCivilian"};
};  
if (!(isNil {missionNamespace getVariable _respawncount})) then
	{
	_cnt = missionNamespace getVariable _respawncount;
	_mrkrname = format ["%1_%2",_respawn,_cnt];
	deleteMarker str _mrkrname;

	_respawnname = missionNamespace getVariable _respawn;
	_respawnID = _respawnname call BIS_fnc_netId;				
	_respawnID call BIS_fnc_removeRespawnPosition;

	_helipadID = missionNamespace getVariable _helipad;
	_helipadname = _helipadID call BIS_fnc_objectFromNetId;
	deleteVehicle _helipadname;

	_cnt = _cnt + 1;
	
	_mrkrname = format ["%1_%2",_respawn,_cnt];
    _mrkr = createMarkerLocal [str _mrkrname, _pos];
    _mrkr setMarkerTypeLocal "respawn_inf";
    _mrkr setMarkerShapeLocal "Icon";
    _mrkr setMarkerTextLocal str _mrkrname;
    _mrkr setMarkerSizeLocal [1,1];
    _mrkr setMarkerColorLocal _mrkrColor;

	_respawnname = format ["%1_%2",_respawn,_cnt];
	_respawnname = [missionNamespace,str _mrkrname,_respawn] call BIS_fnc_addRespawnPosition;
	missionNamespace setVariable [_respawn, _respawnname, true];
	missionNamespace setVariable [_respawncount, _cnt, true];

} else {		

	_cnt = 1;
	_mrkrname = format ["%1_%2",_respawn,_cnt];
    _mrkr = createMarkerLocal [str _mrkrname, _pos];
    _mrkr setMarkerTypeLocal "respawn_inf";
    _mrkr setMarkerShapeLocal "Icon";
    _mrkr setMarkerTextLocal str _mrkrname;
    _mrkr setMarkerSizeLocal [1,1];
    _mrkr setMarkerColorLocal _mrkrColor;

	_respawnname = format ["%1_%2",_respawn,_cnt];
	_respawnname = [missionNamespace,str _mrkrname,_respawn] call BIS_fnc_addRespawnPosition;
	//hintsilent format ["%1",_respawnname];
	missionNamespace setVariable [_respawn, _respawnname, true];
	missionNamespace setVariable [_respawncount, _cnt, true];
};
if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {{_x action ["nvGoggles", _x]} forEach units group player;};

};

if (BIS_CP_preset_showInsertion == 1) then {
	_mrkrDir = [markerPos "insertion_pos",markerPos "ao_marker"] call BIS_fnc_dirTo;
	"insertion_pos" setMarkerDirLocal _mrkrDir;
};

_pads = [];
_pads = [0,0,0] nearobjects ["HeliH",(worldSize / 2) * 1.4142];
for "_i" from 0 to count _pads - 1 do
{
	_pad = _pads select _i;
	_markername = "hpad" + str _i;
	_markerstr = createMarkerLocal [_markername,position _pad];
	_markerstr setMarkerShapeLocal "ICON";
	_markerstr setMarkerTypeLocal "c_air";
};

["ao_marker", true, kouris] execVM "Z_RandomHousePositionCircleEdge.sqf";

uisleep 10;

if (kouris distance uss_freedom < 200) then {

	["ao_marker", true, kouris] execVM "Z_RandomHousePositionCircleEdge.sqf";
};

/*
disableSerialization;
player setDir 0;
interval = 0;
_disp = findDisplay 46 createDisplay "RscDisplayEmpty";
_ctrl = _disp ctrlCreate ["RscSlider", -1];
_ctrl ctrlSetPosition [safeZoneX + 0.1, 1, safeZoneW - 0.2, 0.1];
_ctrl ctrlSetActiveColor [1,0,0,1];
_ctrl ctrlCommit 0;
_ctrl sliderSetPosition 0;
_ctrl sliderSetRange [0,1];
_ctrl sliderSetSpeed [0.1,0.5];
_ctrl ctrlAddEventHandler ["SliderPosChanged", {interval = _this select 1}];
ctrlSetFocus _ctrl;
box = "Land_VR_Shape_01_cube_1m_F" createVehicle [0,0,0];
controlPointASL = AGLToASL (player getRelPos [70, -30]) vectorAdd [0, 0, 30];
fromPosASL = AGLToASL (player getRelPos [10, -45]);
toPosASL = AGLToASL (player getRelPos [10, 45]);
fromControlPointOffset = controlPointASL vectorDiff fromPosASL;
toControlPointOffset = toPosASL vectorDiff controlPointASL;
onEachFrame
{
	hintSilent format ["Interval: %1", interval];
	box setVelocityTransformation
	[
		fromPosASL vectorAdd (fromControlPointOffset vectorMultiply interval),
		controlPointASL vectorAdd (toControlPointOffset vectorMultiply interval),
		[0,0,0],
		[0,0,0],
		[0,1,0],
		[1,0,0],
		[0,0,1],
		[0,1,0],
		interval
	];
};
*/