///  	_unit execVM "SP_Respawn.sqf";	///
private ["_unit"];
params ["_unit"];

if isMultiplayer exitWith {};

waitUntil {!isNull _unit};
waitUntil {!isNil {_unit getVariable "LoadoutDone"}};
waitUntil {!isNil {_unit getVariable "LoadoutAdjustmentsDone"}};

_unitvn			= vehicleVarName _unit;
_classname 		= format ["%1", typeOf _unit];
_displayname 	= gettext (configfile >> "CfgVehicles" >> _className >> "displayName");
_unitname 		= [name _unit,name _unit,name _unit];
_unitrank   	= rank _unit;
_unitface		= face _unit;
_unitvoice		= speaker _unit;
_unitskill		= skill _unit;
_plyrgrp		= group _unit;	
_grpldr			= leader _plyrgrp;
_plyrlo			= getUnitLoadout _unit;

[_unit, 0.10] remoteExec ["setCustomAimCoef", groupOwner _plyrgrp];
[_unit, 0.20] remoteExec ["setUnitRecoilCoefficient", groupOwner _plyrgrp];
[_unit, false] remoteExec ["enablestamina", groupOwner _plyrgrp];
[_unit, ["camouflageCoef",0.20]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];
[_unit, ["loadCoef",1.0]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];

missionNamespace setVariable [_varname,[_unitvn,_className,_displayName,_unitname,_unitrank,_unitface,_unitvoice,_unitskill,_plyrgrp,_grpldr,_plyrlo]];

SP_Respawn = {

	private ["_unit"];
	params ["_unit"];	

	_varname = vehicleVarName _unit;

	_rally = switch (playerSide) do {
		case west: 			{"respawn_west"};
		case east: 			{"respawn_east"};
		case resistance: 	{"respawn_guerrila"};
		case civilian:		{"respawn_civilian"};
	};

	_PlayerProfile = missionNamespace getVariable _varname;

	_unitvn			= _PlayerProfile select 0;
	_className 		= _PlayerProfile select 1;
	_displayName 	= _PlayerProfile select 2;
	_unitname 		= _PlayerProfile select 3;
	_unitrank   	= _PlayerProfile select 4;
	_unitface		= _PlayerProfile select 5;
	_unitvoice		= _PlayerProfile select 6;
	_unitskill		= _PlayerProfile select 7;
	_plyrgrp		= _PlayerProfile select 8;	
	_grpldr			= _PlayerProfile select 9;
	_plyrlo			= _PlayerProfile select 10;

//	_className createUnit [position, group, init, skill, rank] getMarkerPos ["respawn_west", true];
//	_className createUnit [getMarkerPos _rally, _plyrgrp, "this setVehicleVarname _unitvn;_unitvn = this;addSwitchableUnit this;"];
	_unitNew = _plyrgrp createUnit [_className, getMarkerPos _rally, [], 0, "NONE"];

	if (_grpldr isEqualTo _unitvn) then {[_unitNew] remoteExec ["selectPlayer", groupOwner _plyrgrp];};

	_unitNew setVehiclePosition [getMarkerPos [_rally, true], [], 0, "CAN_COLLIDE"];	

	[_unitNew, _unitvn] remoteExec ["setVehicleVarName", groupOwner _plyrgrp]; 

	if (_grpldr isEqualTo _unitvn) then {[_plyrgrp, _unitNew] remoteExec ["selectLeader", groupOwner _plyrgrp];};

	//[_unitNew, _plyrlo] remoteExec ["setUnitLoadout", groupOwner _plyrgrp];

	if (("BI_CP_loadouts_wl" call BIS_fnc_getParamValue) isEqualTo 2) then {

		_unitNew call loadouts_woodland;
	};

	if (("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue) isEqualTo 2) then {

		_unitNew call loadouts_multiterrain;
	};

	if ((("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue) isEqualTo 1) && (("BI_CP_loadouts_wl" call BIS_fnc_getParamValue) isEqualTo 1)) then {

		[_unitNew, _plyrlo] remoteExec ["setUnitLoadout", groupOwner _plyrgrp];
	};

	[_unitNew, _unitrank] remoteExec ["setRank", groupOwner _plyrgrp];

	[_unitNew, _unitname] remoteExec ["setName", groupOwner _plyrgrp];

	[_unitNew, _unitface] remoteExec ["setFace", groupOwner _plyrgrp];
		
	[_unitNew, _unitvoice] remoteExec ["setSpeaker", groupOwner _plyrgrp];
	
	[_unitNew, _unitskill] remoteExec ["setSkill", groupOwner _plyrgrp];

	[_unitNew, 0.30] remoteExec ["setCustomAimCoef", groupOwner _plyrgrp];
	[_unitNew, 0.30] remoteExec ["setUnitRecoilCoefficient", groupOwner _plyrgrp];
	[_unitNew, false] remoteExec ["enableStamina", groupOwner _plyrgrp];
	[_unitNew, ["camouflageCoef",0.20]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];
	[_unitNew, ["loadCoef",1.0]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];

	openmap [false,false];

	if (isPlayer _unitNew) then {  

		_unitNew execVM "RallyPoint.sqf";

		_unitNew execVM "RallyTent.sqf";

		_unitNew execVM "UnlimitedAmmo.sqf";

		_unitNew execVM "LoadoutAdjustments.sqf";

		execVM  "initPlayerLocal.sqf";

		execVM  "ParamsPlus\Military_Symbol_Module.sqf";

		waitUntil {!isNil {_to getVariable "Briefing"}};

		call BIS_fnc_CPObjBriefingSetup;
	};
	private _future = time + 10;
	waitUntil { time >= _future };

	[playerSide, "HQ"] commandChat format ["%1 respawned!",_displayName];
	
	waitUntil {!alive _unitNew};
	_unitNew call SP_Respawn;
};

waitUntil {!alive _unit};
_unit call SP_Respawn;

/*
this addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
}];

// _group = group (leader _unit);

// _text = toArray(str _group);
// _text set[0,"**DELETE**"];
// _text set[1,"**DELETE**"];
// _text = _text - ["**DELETE**"];
// _grp = toString(_text);

// _grpCount = ((units group _unit) find _unit) + 1;

// _varname = format ["%1_%2",_grp,_grpCount];

//_PlayerProfile = missionNamespace getVariable _varname;

//_group = group (leader _unit);
//_grpCount = ((units group _unit) find _unit) + 1;
//_typename = _unit getVariable "codeName";
//_nameUnit = name _unit;
//_typename = lbtext [BON_RECRUITING_UNITLIST,_unit];
//hint format ["%1",_typename];

//_group = group (leader _unit);
//_grpCount = ((units group _unit) find _unit) + 1;
//_typename = _unit getVariable "codeName";
//_nameUnit = name _unit;
//_typename = lbtext [BON_RECRUITING_UNITLIST,_unit];
//hint format ["%1",_typename];
//_classname 	= format ["%1", typeOf _unit];
//_displayname = gettext (configfile >> "CfgVehicles" >> _className >> "displayName");

// _text = toArray(str _group);
// _text set[0,"**DELETE**"];
// _text set[1,"**DELETE**"];
// _text = _text - ["**DELETE**"];
// _grp = toString(_text);

//_varname = format ["%1_%2",_grp,_grpCount];

//_unit setVehicleVarname _varname;_varname = _unit;//call compile format ["%1=%2",_varname,_unit];


//_PlayerProfile = missionNamespace getVariable _varname;

//	hint format ["%1",_PlayerProfile];

//	copyToClipboard format ["%1",_PlayerProfile];
*/