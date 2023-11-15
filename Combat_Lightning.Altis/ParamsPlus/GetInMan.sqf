//// ParamsPlus\GetInMan.sqf ////
private ["_unit"];
params ["_unit"];

if ( ("GetInManMode" call BIS_fnc_getParamValue) isEqualTo 1 ) exitWith {};

_unit addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	_unit allowDamage FALSE;
	[_vehicle] execVM "ParamsPlus\vehicleMarker.sqf";
	[_vehicle] execVM "ParamsPlus\heliBombs.sqf";
}];

_unit addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];
	_unit setBehaviour "COMBAT";_unit allowDamage FALSE;
	[_unit,_vehicle] spawn {waitUntil {((_this select 0) distance (_this select 1)) > 20;}; (_this select 0) allowDamage TRUE;};
	titleText ['<t color=''#ffdd22'' size=''1.5''>20 METER SAFE AREA!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
	[_unit, "20 meter safe area around vehicle in effect!"] remoteExecCall ["commandChat", 0];
}];

_unit addEventHandler ["IncomingMissile", {
    titleText ['<t color=''#ffdd22'' size=''1.5''>MISSILE INBOUND!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
}];

