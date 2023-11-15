///////// _this execVM "ParamsPlus\cargoDrop.sqf"; //////////
if ( "CargoDrop" call BIS_fnc_getParamValue isEqualTo 1 ) exitWith {};
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
_mrkrcolor = [];

switch (side _caller) do {

    case west:			{_mrkrcolor = "ColorBlue"};
    case east:			{_mrkrcolor = "ColorRed"};
    case resistance:	{_mrkrcolor = "ColorGreen"};
    case civilian:		{_mrkrcolor = "ColorYellow"};
};

_mrkrname = [];

_mrkrname = format ["mrkr_%1", round(random 10000)];

[_caller, "Requesting ammo drop at the designated coordinates"] remoteExecCall ["commandChat", 0];

playSound3D ["A3\dubbing_f\modules\supports\drop_request.ogg", _caller];

if (_position isEqualTo []) then { 

	objective = false;
	sleep 0.25;
	openmap [true,false];
	sleep 0.25;
	titleText ['<t color=''#ffdd22'' size=''2''>MAPCLICK COORDINATES!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

	onMapSingleClick "onMapSingleClick ''; mappos = _pos; objective = true";		
	waitUntil {sleep 1; (!visiblemap OR objective OR !alive _caller)};
	if (!objective OR !alive _caller) exitWith {
	mappos = nil;
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Map position cancelled</t>"];
	titletext ["","plain"];
	};
		  
	_mrkr = createMarkerLocal [_mrkrname, mappos];
	_mrkr setMarkerTypeLocal "mil_objective";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal " Supplies";
	_mrkr setMarkerSizeLocal [1,1];
	_mrkr setMarkerColorLocal _mrkrcolor;
	_mrkr setMarkerDirLocal (getDir _caller);
	
	titletext ["","plain",0.2];
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Map position successful</t>"];

	_position = [(getMarkerPos _mrkrname) select 0,(getMarkerPos _mrkrname) select 1,0];
		
	uisleep 1;
	openmap [false,false];

} else {
	
	uisleep 6;

	_mrkr = createMarkerLocal [_mrkrname, _position];
	_mrkr setMarkerTypeLocal "mil_objective";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal " Supplies";
	_mrkr setMarkerSizeLocal [1,1];
	_mrkr setMarkerColorLocal _mrkrcolor;
	_mrkr setMarkerDirLocal (getDir _caller);

	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Marker position successful</t>"];

	_position = _position;
};

if (_position isEqualTo []) exitWith {
	[_caller, "Request canceled"] remoteExecCall ["commandChat", 0];
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Position Out Of Range!</t>"];
	playSound3D ["A3\dubbing_f\modules\supports\drop_destroyed.ogg", _caller];
	deleteMarker _mrkrname;
};

_randDir 			= 	getDir vehicle _caller;
_randDist 			= 	(random 100) + 2000;
_airStart 			=	[(_position select 0) + (_randDist * sin(_randDir)), (_position select 1) + (_randDist * cos(_randDir)), 120];
_randDir2 			= 	getDir vehicle _caller - 180;
_airEnd 			=	[(_position select 0) + (_randDist * sin(_randDir2)), (_position select 1) + (_randDist * cos(_randDir2)), 120];
//_airTypes 		= 	B_T_VTOL_01_infantry_F // B_Heli_Light_01_F // B_Heli_Light_01_stripped_F // B_Heli_Transport_01_F // B_Heli_Transport_01_camo_F ////DLC > B_Heli_Transport_03_F // B_Heli_Transport_03_unarmed_F
//_airTypes			=	O_T_VTOL_02_infantry_dynamicLoadout_F // O_Heli_Light_02_F // O_Heli_Light_02_unarmed_F // O_Heli_Light_02_v2_F ////DLC > O_Heli_Transport_04_F 
_airType = [];

switch (side _caller) do {

	case west: 			{_airType = "B_T_VTOL_01_infantry_F"};
	case east: 			{_airType = "O_T_VTOL_02_infantry_dynamicLoadout_F"};
	case resistance: 	{_airType = "I_C_Plane_Civil_01_F"};
	case civilian: 		{_airType = "C_Plane_Civil_01_F"};
};
_airName = [];

_airName = switch (side _caller) do {

	case west: 			{"CargoDrop_West"};
	case east: 			{"CargoDrop_East"};
	case resistance: 	{"CargoDrop_Guer"};
	case civilian: 		{"CargoDrop_Civ"};
};
_cargoType = [];

switch (side _caller) do {

	case west: 			{_cargoType = "B_supplyCrate_F"};
	case east: 			{_cargoType = "O_supplyCrate_F"};
	case resistance: 	{_cargoType = "I_supplyCrate_F"};
	case civilian: 		{_cargoType = "Box_GEN_Equip_F"};
};
_airGrp = [];
_airGrp = format ["%1_Group",_airName];
_cargoID = [];
_cargoID = format ["Cargo_%1", round(random 10000)];

if (!isNil {missionNamespace getVariable _airGrp}) exitWith {
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Cargo Drop Currently In Progress!</t>"];
	deleteMarker _mrkrname;
};

missionNamespace setVariable [_airGrp,true];

playSound3D ["A3\dubbing_f\modules\supports\drop_acknowledged.ogg", _caller];

[_airStart, _airEnd, 120, "NORMAL", _airType, west] call BIS_fnc_ambientFlyby;

_airName = nearestObject [_airStart,_airType];

_airName setDestination [getMarkerPos _mrkrname, "VEHICLE PLANNED", true];

_airName moveTo (getMarkerPos _mrkrname);

[_airName] execVM "paramsplus\vehicleMarker.sqf";

waitUntil {(_airName distance2d (getMarkerPos _mrkrname)) <= 240};

_cargo = createVehicle [_cargoType, [getPosATL _airName select 0,getPosATL _airName select 1,(getPosATL _airName select 2)-3], [], 0, "NONE"];  

//_cargoID = _cargo call BIS_fnc_netId;
//_cargo setVehicleVarName format ["%1",_cargoID]; _cargoID = _cargo;

//hint format ["%1",(getPosATL _cargoID)];
//[_caller, _cargo] call BIS_fnc_curatorobjectedited;  
//_cargo setDamage 1;
//deleteVehicle _cargo;
//uisleep 6;
//((getPosATL _cargo) isNotEqualTo [])
//(_cargoID isEqualTo (_cargo call BIS_fnc_netId))
//(!isNull _cargo)
//((typeOf _cargo) isEqualTo _cargoType)
//if ((isNull _cargo) OR (missionNamespace getVariable _airGrp isNotEqualTo nil)) then {

if ((!isNil "_cargo") AND {alive _cargo}) then {

	_cargo disableCollisionWith _airName;

	_cargo allowDamage false;

	_para = createVehicle ["B_Parachute_02_F", (_cargo modelToWorld [0,0,2]), [], 0, "FLY"];

	_cargo attachTo [_para,[0,0,0]];

	_offDir = _cargo getRelDir _position;

	1 setWindDir _offDir; 1 setWindStr 1; 1 setWindForce 1; 10 setGusts 1;

	uisleep 6;

	playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];

	[_cargo,_mrkrname,_airGrp] spawn {

		params ["_cargo","_mrkrname","_airGrp"];

		waitUntil {((getPosATL _cargo) select 2) < 1};

		detach _cargo;

		_cargo setVectorUp [0,0,1];

	  	["AmmoboxInit", [_cargo, true, {true}]] spawn BIS_fnc_arsenal; 

		"SmokeShellgreen" createVehicle getPosATL _cargo;

		"F_40mm_White" createVehicle [getPosATL _cargo select 0,getPosATL _cargo select 1,+100];

		_mrkrname setMarkerPos getPosATL _cargo;

		_mrkrname setMarkerTextLocal "Ammo";

		missionNamespace setVariable [_airGrp ,nil];

		titleText ['<t color=''#ffdd22'' size=''2''>AMMO DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
	};

} else {

	_notice = {

		params ["_caller","_cargo","_mrkrname","_airGrp"];

		playSound3D ["A3\dubbing_f\modules\supports\drop_destroyed.ogg", _caller];

		deleteMarker _mrkrname;

		if (isNil _airGrp) then {

			titleText ['<t color=''#ffdd22'' size=''2''>REQUEST AMMO DROP AGAIN!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

		} else {

			titleText ['<t color=''#ffdd22'' size=''2''>AMMO DROP HAS BEEN DESTROYED!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
		};

	};

	[_caller,_cargo,_mrkrname,_airGrp] spawn _notice;

	_caller addAction ["<t color='#00FFFF'>Report Destroyed Ammo Drop</t>", {

	params ["_target", "_caller", "_actionId", "_arguments"];

	[_caller,_this select 3 select 0,_this select 3 select 1,_this select 3 select 2] spawn (_this select 3 select 3);

	missionNamespace setVariable [(_this select 3 select 2),nil];

	_caller removeAction _actionId;
	},
  	[_cargo,_mrkrname,_airGrp,_notice],
  	10,
  	false,
  	true,
  	"",
  	"",
  	-1,
  	true,
  	"",
  	""];
};

