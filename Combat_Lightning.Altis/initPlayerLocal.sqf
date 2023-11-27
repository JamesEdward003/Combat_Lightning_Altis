// initPlayerLocal.sqf //
enableRadio false;
enableSentences false;
{_x disableConversation true} forEach units group player;

[playerSide, "HQ"] commandChat "Initiating InitPlayer!";

player addEventHandler ["HandleRating", {
	params ["_unit", "_rating"];
	_unit addRating 100;
}];
 
player addEventHandler ["Respawn", {
	player addEventHandler ["HandleRating", {
		params ["_unit", "_rating"];
		_unit addRating (0 - (rating _unit))
	}];
}];

player addEventHandler ["HandleScore", {
	params ["_unit", "_object", "_score"];
	_unit addScore 100;
}];

player addEventHandler ["Respawn", {
	player addEventHandler ["HandleScore", {
		params ["_unit", "_object", "_score"];
		_unit addScore (0 - (score _unit))
	}];
}];

player addEventHandler ["FiredNear", {
	params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
	{deleteVehicle _x} forEach nearestObjects [_unit, ["#particlesource"], 100];
}];

if isMultiplayer then {
	
	player addEventHandler ["Killed",
	{
	   ["Initialize", [player]] call BIS_fnc_EGSpectator;
	}];


	player addEventHandler ["Respawn",
	{
	   ["Terminate"] call BIS_fnc_EGSpectator;
	}];
};

player addAction ["<t color='#00FFFF'>Heal Self</t>","HealSelf.sqf",[],10,false,true,"","((_target == _this) and (getDammage _target) > 0.3)"];
player addAction ["<t color='#00FFFF'>Heal Player</t>","HealPlayer.sqf",[],10,false,true,"","((_target == _this) and (getDammage _target) > 0.6)"];

//player addAction ["Open Garage", {_pos = getPos BIS_garage_center;BIS_fnc_garage_center = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];["Open", true] call BIS_fnc_garage;}];

//call compile preprocessFileLineNumbers "initRevive.sqf";

call compile preprocessFileLineNumbers "briefing.sqf";
        	
call compile preprocessFileLineNumbers "bon_recruit_units\init.sqf";

call compile preprocessFileLineNumbers "Alt_TeleportPlayer.sqf";

call compile preprocessFileLineNumbers "Alt_TeleportGroup.sqf";

call compile preprocessFileLineNumbers "mortarBag.sqf";

call compile preprocessFileLineNumbers "group_manager.sqf";

call compile preprocessFileLineNumbers "Holster__Weapon.sqf";

if ( "Artillery" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommArtillery"} ) then
	{	
		[player,"Artillery"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommArtillery", true];	
	};
};
if ( "Missile" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommMissile"} ) then
	{	
		[player,"Missile"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommMissile", true];	
	};
};
if ( "LaserMissile" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommLaserMissile"} ) then
	{	
		[player,"LaserMissile"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommLaserMissile", true];	
	};
};
if ( "Mortar" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommMortar"} ) then
	{	
		[player,"Mortar"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommMortar", true];	
	};
};
if ( "MortarBag" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommMortarBag"} ) then
	{	
		[player,"MortarBag"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommMortarBag", true];	
	};
};
if ( "ParaTeam" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommParaTeam"} ) then
	{	
		[player,"ParaTeam"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommParaTeam", true];	
	};
};
if ( "ParaDrop" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommParaDrop"} ) then
	{	
		[player,"ParaDrop"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommParaDrop", true];	
	};
};
if ( "HaloJump" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommHaloJump"} ) then
	{	
		[player,"HaloJump"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommHaloJump", true];	
	};
};
if ( "HaloJumpGroup" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommHaloJumpGroup"} ) then
	{	
		[player,"HaloJumpGroup"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommHaloJumpGroup", true];	
	};
};
if ( "CargoDrop" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommCargoDrop"} ) then
	{	
		[player,"CargoDrop"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommCargoDrop", true];	
	};
};
if ( "AirSupport" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommAirSupport"} ) then
	{	
		[player,"AirSupport"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommAirSupport", true];	
	};
};
if ( "AirLift" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommAirLift"} ) then
	{	
		[player,"AirLift"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommAirLift", true];	
	};
};
if ( "AirLift2" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommAirLift2"} ) then
	{	
		[player,"AirLift2"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommAirLift2", true];	
	};
};
if ( "WindSpeed" call BIS_fnc_getParamValue isEqualTo 2 ) then
{ 
	if ( isNil{player getVariable "CommWindSpeed"} ) then
	{	
		[player,"WindSpeed"] call BIS_fnc_addCommMenuItem;
		player setVariable ["CommWindSpeed", true];	
	};
};
if ( "GroupManager" call BIS_fnc_getParamValue isEqualTo 2 ) then
{	
	execVM "Group_Manager.sqf";
	player setVariable ["CommGroupManager", true];	
};
enableRadio true;
enableSentences true;
{_x disableConversation false} forEach units group player;

