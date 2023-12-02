////////   "ParamsPlus\HeliTransport.sqf"   ///////////
private ["_caller","_position","_target","_is3D","_id","_unit", "_sideUnit", "_pos", "_location", "_mrkr", "_airType", "_airName"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
_searchRadius = 300;
_friendlySide = side _caller;
_neutralSide = CIVILIAN;
_enemyAntiAir = if (_friendlySide isEqualTo "WEST") then { ["O_T_APC_Tracked_02_AA_ghex_F","O_APC_Tracked_02_AA_F","O_static_AA_F","O_Soldier_AA_F","O_soldierU_AA_F","O_T_Soldier_AA_F","O_A_soldier_AA_F"] } else { ["B_T_APC_Tracked_01_AA_F","B_APC_Tracked_01_AA_F","B_static_AA_F","B_T_Static_AA_F","B_soldier_AA_F","B_T_Soldier_AA_F","B_W_Soldier_AA_F"] };
_sideUnit 		= 	side _caller;
_sourcePoint 	= 	_caller;
_randDir 		= 	getDir vehicle _sourcePoint;
_randDist 		= 	(random 100) + 1000;
_airStart 		=	[(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir)), 100];
_randDir2 		= 	getDir vehicle _sourcePoint - 180;
_airEnd 		=	[(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir2)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir2)), 60];

_airType = switch (_sideUnit) do 
	{
		case west: 			{"B_Heli_Light_01_F"};
		case east: 			{"O_Heli_Light_02_F"};
		case resistance: 	{"O_Heli_Light_02_v2_F"};
		case civilian: 		{"O_Heli_Light_02_unarmed_F"};
	};

_airName = switch (_sideUnit) do 
	{
		case west: 			{"Transport_West"};
		case east: 			{"Transport_East"};
		case resistance: 	{"Transport_Guer"};
		case civilian: 		{"Transport_Civ"};
	};

if (!isNil {missionNamespace getVariable _airName}) exitWith {
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Transport Currently In Progress!</t>"];
};

_mrkrcolor = switch (_sideUnit) do 
	{
	     case west:			{"ColorBLUFOR"};
	     case east:			{"ColorOPFOR"};
	     case resistance:	{"ColorGUER"};
	     case civilian:		{"ColorCIV"};
	};

_marker = createMarkerLocal [format ["%1_Start",_airName],_airStart];
_marker setMarkerTypeLocal "mil_start";
_marker setMarkerShapeLocal "Icon";  
_marker setMarkerTextLocal _airName;
_marker setMarkerSizeLocal [.75,.75];
_marker setMarkerAlphaLocal .75;
_marker setMarkerColorLocal _mrkrcolor;	

_reldir = _airStart getDir _caller;

_marker setMarkerDirLocal _reldir;

if (_position isEqualTo []) then { 

uisleep 0.25;
location = false;
openmap [true,false];
titleText["Map location", "PLAIN"];
PAPABEAR=[_sideUnit,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name _caller];

onMapSingleClick "onMapSingleClick ''; mappos1 = _pos; location = true";		
waitUntil {sleep 1; (!visiblemap OR location OR !alive _caller)};
	if (!location OR !alive _caller) exitWith {
	mappos1 = nil;
	PAPABEAR=[_sideUnit,"HQ"]; PAPABEAR SideChat "Map location canceled";
	hintSilent parseText format["<t size='1.25' color='#ff0000'>Map location canceled</t>"];
	titletext ["","plain"];
	}; 

	_SafePos = mappos1; //[mappos1, 0, 50, 10, 0, 20, 0] call BIS_fnc_findSafePos;

	if (_SafePos distance uss_freedom < 200) then {

		_position = getPos uss_freedom;

	} else {

		_position = _SafePos;
	};
	
	_mrkr = createMarkerLocal [format ["%1_Dest",_airName],_position];
	_mrkr setMarkerType "mil_pickup";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal "LZ";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;

	uisleep 2;
	titletext ["","plain",0.2];
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mapclicked position successful</t>"];
	uisleep 1;
	hintSilent "";
	openmap [false,false];
		
} else { 

	_SafePos = _position; //[_position, 0, 50, 10, 0, 20, 0] call BIS_fnc_findSafePos;

	if (_SafePos distance uss_freedom < 200) then {

		_position = getPos uss_freedom;

	} else {

		_position = _SafePos;
	};

	_mrkr = createMarkerLocal [format ["%1_Dest",_airName],_position];
	_mrkr setMarkerType "mil_pickup";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal "LZ";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;

	uisleep 2;
	titletext ["","plain",0.2];
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Marked position successful</t>"];
	uisleep 1;
	hintSilent "";
};

_enemyArray = [];

_enemyArray = _position nearEntities [["Air", "Car", "Motorcycle", "Tank", "Man"], _searchRadius];

{
	if ((side _x == _friendlySide) || (side _x == _neutralSide)) then {
	
		_enemyArray = _enemyArray - [_x];
	};

} count _enemyArray;

_enemyAntiAirArray = [];

{
	if (typeOf _x in _enemyAntiAir) then {
	
		_enemyAntiAirArray = _enemyAntiAirArray + [_x];
	};
	
} count _enemyArray;

if (((count _enemyArray) > 10) or ((count _enemyAntiAirArray) > 0)) then {

	hintSilent parseText format ["<t size = '1.5' color = '#FF0000'>Transport Be ForeWarned!</t><br/><br/>Too many enemies close! ( 10 per 50m )<br/>or<br/>Anti-Air close! ( 300 meters )<br/><br/>Secure the area before requesting transport!"];
};

_flightPath = _airStart getDir _position;		

_ch = [_airStart, _flightPath, _airType, side _caller] call BIS_fnc_spawnVehicle;

(_ch select 0) engineOn true;

(_ch select 0) flyInHeight 100;

(_ch select 0) setVehicleLock "UNLOCKED";
	
[(_ch select 0)] execVM "paramsplus\vehicleMarker.sqf";

(_ch select 0) addEventHandler ["GetIn",{ if (_this select 1 == "cargo") then { (_this select 2) allowDamage false; } } ]; 
(_ch select 0) addEventHandler ["GetOut",{ if (_this select 1 == "cargo") then { (_this select 2) allowDamage true; } } ];
	
{deleteVehicle _x} forEach crew (_ch select 0) - [driver (_ch select 0)];

{_x addEventHandler ["HandleDamage", {false}]} forEach (crew (_ch select 0)) + [(_ch select 0)];
{_x allowDamage false} forEach (crew (_ch select 0)) + [(_ch select 0)];
{addswitchableunit _x} forEach (crew (_ch select 0));

{(driver (_ch select 0)) disableAI _x} forEach ["autocombat","target","autotarget"];

(_ch select 0) spawn { 
_this addbackpackcargoGlobal ["B_AssaultPack_cbr",1]; 
_this addbackpackcargoGlobal ["B_AssaultPack_rgr",1];                     sleep 0.1;
_bpk1 = (everyBackpack _this) select ( count (everyBackpack _this) - 1 ); 
_bpk2 = (everyBackpack _this) select ( count (everyBackpack _this) - 2 ); sleep 0.1; 
_bpk1 addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer_Red",4]; 
_bpk1 addItemCargoGlobal ["optic_SOS",1]; 
_bpk1 addItemCargoGlobal ["bipod_03_F_blk",1]; 
_bpk1 addItemCargoGlobal ["FirstAidKit",8]; 
_bpk2 addMagazineCargoGlobal ["5Rnd_127x108_APDS_Mag",12]; 
_bpk2 addItemCargoGlobal ["optic_LRPS",1]; 
_bpk2 addItemCargoGlobal ["FirstAidKit",8]; 
};

for "_i" from count waypoints (_ch select 2) - 1 to 0 step -1 do
    {
        deleteWaypoint [(_ch select 2), _i];
    };
for "_i" from count waypoints (group _caller) - 1 to 0 step -1 do
		{
    	deleteWaypoint [(group _caller), _i];
	}; 

_CampFire = createVehicle ["Campfire_burning_F", _position, [], 0, "CAN_COLLIDE"];
_CampFire setVehiclePosition [_position, [], 0, "CAN_COLLIDE"];
_CampFireID = _CampFire call BIS_fnc_netId;
_heliPad = createVehicle ["Land_HelipadCircle_F", _CampFire modelToWorld [0,-3,0], [], 0, "CAN_COLLIDE"];
_heliPad setVehiclePosition [_CampFire modelToWorld [0,-3,0], [], 0, "CAN_COLLIDE"];
_heliPadID = _heliPad call BIS_fnc_netId;

missionNamespace setVariable [_airName,[_CampFireID,_heliPadID]];

[(_ch select 0),_airName] spawn {
	private ["_heli","_airName"];
	params ["_heli","_airName"];

	waitUntil {!alive _heli};

	if (!isNil {missionNamespace getVariable _airName}) then {
		deleteMarker _airName;
		deleteMarker format ["%1_Start",_airName];
		deleteMarker format ["%1_Dest",_airName];
		_RallyProfile = missionNamespace getVariable _airName;
		_CampFireID = _RallyProfile select 0;
		_CampFire = _CampFireID call BIS_fnc_objectFromNetId;
		deleteVehicle _CampFire;
		_heliPadID = _RallyProfile select 1;
		_heliPad = _heliPadID call BIS_fnc_objectFromNetId;
		deleteVehicle _heliPad;
		{deletevehicle _x} foreach (crew _heli) + [_heli];
		missionNamespace setVariable [_airName,nil];
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1 ready for reassignment!</t>", _airName];
	};
};
PAPABEAR=[side _caller,"HQ"]; PAPABEAR SideChat format ["%1 to your position %2", _airName, name _caller];

_wp0 = (_ch select 2) addwaypoint [getPos _heliPad, 0];
_wp0 setWaypointPosition [getPosASL _heliPad, -1];
_wp0 waypointAttachVehicle _heliPad;
_wp0 setWaypointType "LOAD";	
_wp0 setWaypointBehaviour "AWARE";
_wp0 setWaypointCombatMode "YELLOW";
_wp0 setWaypointSpeed "NORMAL";
_wp0 setWaypointStatements ["true",""];

_wpp0 = (group _caller) addwaypoint [getPos _heliPad, 0];
_wpp0 setWaypointPosition [getPosASL _heliPad, -1];
_wpp0 waypointAttachVehicle _heliPad;
_wpp0 setWaypointType "GETIN";	
_wpp0 setWaypointBehaviour "AWARE";
_wpp0 setWaypointCombatMode "YELLOW";
_wpp0 setWaypointSpeed "NORMAL";
_wpp0 setWaypointStatements ["true",""];

[(group _caller), 0] synchronizeWaypoint [[(_ch select 2), 0]];

waitUntil {((_ch select 0) distance2d _heliPad < 200)};
(driver (_ch select 0)) move getPos _heliPad;
(driver (_ch select 0)) commandMove getPos _heliPad;
(_ch select 0) land "GET IN";
[(_ch select 0)] execVM "paramsplus\heliGunners.sqf";
[(_ch select 0)] execVM "paramsplus\heliDest.sqf";
//waitUntil {count (units (group _caller) select {_x in crew (_ch select 0)}) isEqualTo count units (group _caller)};

_wp1 = (_ch select 2) addwaypoint [_airEnd, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointBehaviour "AWARE";
_wp1 setWaypointCombatMode "YELLOW";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointStatements ["true","[vehicle this] execVM 'paramsplus\heliEnd.sqf'"]; 	
