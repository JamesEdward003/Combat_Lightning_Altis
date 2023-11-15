//  ParamsPlus\laserMissile.sqf  //
//////////////////////////////////////////////////////////////////
// Created by: BIS, adapted for ArmA 3 by kylania
//////////////////////////////////////////////////////////////////
_logicCenter = createCenter sideLogic;
_logicGroup = createGroup _logicCenter;
_myLogicObject = _logicGroup createUnit ["Logic", [0,0,0], [], 0, "NONE"];

miMissionactive = false;

_myLogicObject setVehicleVarName "miMissileStart";
missionNamespace setVariable ["miMissileStart", _myLogicObject, true];

miMissileStart setPosATL (player modelToWorld [0, 0, 500]);

params ["_primaryTarget"];
// _primaryTarget = _this select 0;
_missileStart = getPos miMissileStart;
_missileType = "ammo_Missile_Cruise_01";
_missileSpeed = 200;
_defaultTargetPos = getPos player;

_reloadTime = 15;

if (isNull _primarytarget) exitWith {hintSilent "No Target Found!"};
if (miMissionActive) exitWith{hintSilent "Missile unavailable!"};

miMissionActive = true;

hintSilent "Target Detected!\n\nMissile inbound!";
uisleep 5;

_perSecondChecks = 25; //direction checks per second
_getPrimaryTarget = {if (typeName _primaryTarget == typename {}) then {call _primaryTarget} else {_primaryTarget}};
_target = call _getPrimaryTarget;

_missile = _missileType createVehicle _missileStart;
_missile setPos _missileStart;

_secondaryTarget = "Land_HelipadEmpty_F" createVehicle _defaultTargetPos;
_secondaryTarget setPos _defaultTargetPos;

_guidedRandomly = FALSE;

_homeMissile = {

private ["_velocityX", "_velocityY", "_velocityZ", "_target"];
_target = _secondaryTarget;
if (!(_guidedRandomly) && _missile distance _target > _missileSpeed * 1.5) then {
_guidedRandomly = TRUE;
_target = _secondaryTarget;
_dispersion = (_missile distance _defaultTargetPos) / 20;
_dispersionMin = _dispersion / 10;
_target setPos [(_defaultTargetPos select 0) + _dispersionMin - (_dispersion / 2) + random _dispersion, (_defaultTargetPos select 1) + _dispersionMin - (_dispersion / 2) + random _dispersion, 0];
};
if (!(isNull (call _getPrimaryTarget))) then {_target = call _getPrimaryTarget; _defaultTargetPos = position _target; _guidedRandomly = FALSE};

if (_missile distance _target > (_missileSpeed / 20)) then {
_travelTime = (_target distance _missile) / _missileSpeed;
_steps = floor (_travelTime * _perSecondChecks);

_relDirHor = [_missile, _target] call BIS_fnc_DirTo;
_missile setDir _relDirHor;

_relDirVer = asin ((((getPosASL _missile) select 2) - ((getPosASL _target) select 2)) / (_target distance _missile));
_relDirVer = (_relDirVer * -1);
[_missile, _relDirVer, 0] call BIS_fnc_setPitchBank;

_dummy = [];
_velocityX = [_dummy, 0, ((((getPosASL _target) select 0) - ((getPosASL _missile) select 0)) / _travelTime), [123]] call BIS_fnc_param;
_velocityY = [_dummy, 1, ((((getPosASL _target) select 1) - ((getPosASL _missile) select 1)) / _travelTime), [123]] call BIS_fnc_param;
_velocityZ = [_dummy, 2, ((((getPosASL _target) select 2) - ((getPosASL _missile) select 2)) / _travelTime), [123]] call BIS_fnc_param;

};
if ((typeName _velocityX) != (typeName 0)) then {_velocityX = 0};
if ((typeName _velocityY) != (typeName 0)) then {_velocityY = 0};
if ((typeName _velocityZ) != (typeName 0)) then {_velocityZ = 0};

[_velocityX, _velocityY, _velocityZ]
};

call _homeMissile;

_fireLight = "#lightpoint" createVehicle position _missile;
_fireLight setLightBrightness 0.5;
_fireLight setLightAmbient [1.0, 1.0, 1.0];
_fireLight setLightColor [1.0, 1.0, 1.0];
_fireLight lightAttachObject [_missile, [0, -0.5, 0]];

while {alive _missile} do {
_velocityForCheck = call _homeMissile;

if ({(typeName _x) == (typeName 0)} count _velocityForCheck == 3) then {_missile setVelocity _velocityForCheck};
uisleep (1 / _perSecondChecks)
};

deleteVehicle _fireLight;
deleteVehicle _secondaryTarget;
deleteVehicle miMissileStart;

uisleep _reloadtime;
miMissionactive = false;
hintSilent "Missile available!";


/*
I've been running it as a support:

description.ext:

class CfgCommunicationMenu
{
   class myMissile
   {
       text = "Guided Missile"; // Text displayed in the menu and in a notification
       submenu = ""; // Submenu opened upon activation (expression is ignored when submenu is not empty.)
       expression = "_null = [] execvm 'launchmissile.sqf'";
       icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"; // Icon displayed permanently next to the command menu
       cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
       enable = "1"; // Simple expression condition for enabling the item
       removeAfterExpressionCall = 0; // 1 to remove the item after calling
   };
};
add access to it with:

_supportMissiles = [player,"myMissile"] call BIS_fnc_addCommMenuItem;
Also expects a GameLogic named miMissileStart 500m up in the air somewhere with init of:

miMissionActive = false;
*/
