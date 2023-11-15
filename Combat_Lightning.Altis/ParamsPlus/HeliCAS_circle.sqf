////////   "ParamsPlus\HeliCAS_circle.sqf"   ///////////
private ["_caller","_position","_target","_is3D","_id","_unit", "_sideUnit", "_pos", "_location", "_mrkr", "_airType", "_airName"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
_searchRadius = 300;
_friendlySide = side _caller;
_neutralSide = CIVILIAN;
fly_circle=false;
_enemyAntiAir = if (_friendlySide isEqualTo "WEST") then { ["O_T_APC_Tracked_02_AA_ghex_F","O_APC_Tracked_02_AA_F","O_static_AA_F","O_Soldier_AA_F","O_soldierU_AA_F","O_T_Soldier_AA_F","O_A_soldier_AA_F"] } else { ["B_T_APC_Tracked_01_AA_F","B_APC_Tracked_01_AA_F","B_static_AA_F","B_T_Static_AA_F","B_soldier_AA_F","B_T_Soldier_AA_F","B_W_Soldier_AA_F"] };
_sideUnit 		= 	side _caller;
_sourcePoint 	= 	_caller;
_randDir 		= 	getDir vehicle _sourcePoint - 180;
_randDist 		= 	(random 100) + 1000;
_airStart 		=	[(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir)), 100];
_randDir2 		= 	getDir vehicle _sourcePoint;
_airEnd 		=	[(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir2)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir2)), 60];

_airType = switch (_sideUnit) do 
	{
		case west: 			{"B_Heli_Attack_01_F"}; // B_Heli_Attack_01_dynamicLoadout_F // B_Heli_Attack_01_F
		case east: 			{"O_Heli_Light_02_F"}; // O_Heli_Light_02_v2_F // O_Heli_Attack_02_F // 	O_Heli_Attack_02_black_F // O_Heli_Attack_02_dynamicLoadout_F // O_Heli_Attack_02_dynamicLoadout_black_F
		case resistance: 	{"O_Heli_Attack_02_v2_F"}; 
		case civilian: 		{"O_Heli_Light_02_unarmed_F"};
	};

_airName = switch (_sideUnit) do 
	{
		case west: 			{"AttackHelo_West"};
		case east: 			{"AttackHelo_East"};
		case resistance: 	{"AttackHelo_Guer"};
		case civilian: 		{"AttackHelo_Civ"};
	};

if (!isNil {missionNamespace getVariable _airName}) exitWith {
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Support Currently In Progress!</t>"];
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

if (_position isEqualTo []) then { 

uisleep 0.25;
location = false;
openmap [true,false];
titleText["Map location", "PLAIN"];
PAPABEAR=[_sideUnit,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name _caller];

onMapSingleClick "onMapSingleClick ''; mappos4 = _pos; location = true";		
waitUntil {sleep 1; (!visiblemap OR location OR !alive _caller)};
	if (!location OR !alive _caller) exitWith {
	mappos4 = nil;
	PAPABEAR=[_sideUnit,"HQ"]; PAPABEAR SideChat "Support canceled";
	hintSilent parseText format["<t size='1.25' color='#ff0000'>Support canceled</t>"];
	titletext ["","plain"];
	}; 

	_mrkr = createMarkerLocal [format ["%1_Dest",_airName],mappos4];
	_mrkr setMarkerType "mil_start";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal "Area of Attack";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;	

	_location = nearestLocation [mappos4, ["Name","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal"], 10000];

	_locationPos = locationPosition _location;

	_reldira = _airStart getDir mappos4;

	_marker setMarkerDirLocal _reldira;

	_reldirb = mappos4 getDir _locationPos;

	_mrkr setMarkerDirLocal _reldirb;

	_position = _locationPos;

	uisleep 2;
	titletext ["","plain",0.2];
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mapclicked position successful</t>"];
	uisleep 1;
	hintSilent "";
	openmap [false,false];
		
} else { 

	_mrkr = createMarkerLocal [format ["%1_Dest",_airName],_position];
	_mrkr setMarkerType "mil_start";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal "Area of Attack";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;	

	_location = nearestLocation [_position, ["Name","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal"], 10000];

	_locationPos = locationPosition _location;

	_reldira = _airStart getDir _position;

	_marker setMarkerDirLocal _reldira;

	_reldirb = _position getDir _locationPos;

	_mrkr setMarkerDirLocal _reldirb;

	_position = _locationPos;

	uisleep 2;
	titletext ["","plain",0.2];
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Marked position successful</t>"];
	uisleep 1;
	hintSilent "";
};

/*
hintSilent parseText format["<t size='1.25' color='#00FFFF'>Nearest position = %1</t>",_location];
uisleep 8;
hintSilent "";
*/

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

if (((count _enemyArray) > 100) or ((count _enemyAntiAirArray) > 10)) exitWith {

	hintSilent parseText format ["<t size = '1.5' color = '#FF0000'>Support Not Available!</t><br/><br/>Anti-Air close! ( 300 meters )<br/><br/>Find clear area before request!"];

	deleteMarker _marker;

	deleteMarker _mrkr;
};

_flightPath = _airStart getDir _position;		

_ch = [_airStart, _flightPath, _airType, side _caller] call BIS_fnc_spawnVehicle;

(_ch select 0) engineOn true;

(_ch select 0) flyInHeight 100;

(_ch select 0) setVehicleLock "UNLOCKED";
	
[(_ch select 0)] execVM "paramsplus\vehicleMarker.sqf";

(_ch select 0) addEventHandler ["GetIn",{ if ((_this select 1 == "driver") or (_this select 1 == "gunner")) then { (_this select 2) allowDamage false; } } ]; 
(_ch select 0) addEventHandler ["GetOut",{ if ((_this select 1 == "driver") or (_this select 1 == "gunner")) then { (_this select 2) allowDamage true; } } ];
	
//{deleteVehicle _x} forEach crew (_ch select 0) - [driver (_ch select 0)];

{_x addEventHandler ["HandleDamage", {false}]} forEach (crew (_ch select 0)) + [(_ch select 0)];
{_x allowDamage false} forEach (crew (_ch select 0)) + [(_ch select 0)];
{addswitchableunit _x} forEach (crew (_ch select 0));

//currentPilot (_ch select 0) disableAI "radioProtocol";
//currentPilot (_ch select 0) setUnitCombatMode "BLUE";
//{(driver (_ch select 0)) disableAI _x} forEach ["autocombat","target","autotarget"];
//(driver (_ch select 0)) setUnitCombatMode "BLUE";
//(gunner (_ch select 0)) disableAI "radioProtocol";
//(gunner (_ch select 0)) setUnitCombatMode "RED";

for "_i" from count waypoints (_ch select 2) - 1 to 0 step -1 do
    {
        deleteWaypoint [(_ch select 2), _i];
    };

_CampFire = createVehicle ["Sign_Arrow_Large_F", _position, [], 0, "CAN_COLLIDE"]; // Campfire_burning_F ProtectionZone_F
_CampFire setVehiclePosition [_position, [], 0, "CAN_COLLIDE"];
_CampFireID = _CampFire call BIS_fnc_netId;
_heliPad = createVehicle ["Sign_Arrow_Large_F", _CampFire modelToWorld [0,-3,60], [], 0, "CAN_COLLIDE"]; // Land_HelipadCircle_F
_heliPad setVehiclePosition [_CampFire modelToWorld [0,-3,60], [], 0, "CAN_COLLIDE"];
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
_wp0 setWaypointType "MOVE";	
_wp0 setWaypointBehaviour "AWARE";
_wp0 setWaypointCombatMode "YELLOW";
_wp0 setWaypointSpeed "NORMAL";
_wp0 setWaypointStatements ["true","(gunner (vehicle this)) setCombatBehaviour 'COMBAT';fly_circle=true;publicVariable 'fly_circle';"];

waitUntil {fly_circle};

[getPos _heliPad,300,360,80,60,360,(_ch select 0),_airEnd] execVM "ParamsPlus\fly_circle_H.sqf";
