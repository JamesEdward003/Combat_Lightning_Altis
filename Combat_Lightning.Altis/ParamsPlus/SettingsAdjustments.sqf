///  	_unit execVM "SettingsAdjustments.sqf";	///
private ["_unit","_unitvn","_unitrank","_unitface","_unitvoice","_unitskill","_unitgrp","_grpldr","_unitlo","_BI_CP_SettingsAdjustments"];
_BI_CP_SettingsAdjustments = "BI_CP_SettingsAdjustments" call BIS_fnc_getParamValue;
if (_BI_CP_SettingsAdjustments isEqualTo 1) exitWith {};

_unit = _this;

	_unitvn			= vehicleVarname _unit;
	_unitrank   	= rank _unit;
	_unitface		= face _unit;
	_unitvoice		= speaker _unit;
	_unitskill		= skill _unit;
	_unitgrp		= group _unit;	
	_grpldr			= leader _unitgrp;
	_unitlo			= getUnitLoadout _unit;

	[_unit, ["Medic", true]] remoteExec ["setUnitTrait", groupOwner (group _unit)];
	[_unit, ["UAVHacker", true]] remoteExec ["setUnitTrait", groupOwner (group _unit)];
	[_unit, ["Engineer", true]] remoteExec ["setUnitTrait", groupOwner (group _unit)];
	[_unit, ["ExplosiveSpecialist", true]] remoteExec ["setUnitTrait", groupOwner (group _unit)];
	[_unit, false] remoteExec ["enablestamina", groupOwner (group _unit)];
	[_unit, false] remoteExec ["enablefatigue", groupOwner (group _unit)];
	[_unit, .1] remoteExec ["setCustomAimCoef", groupOwner (group _unit)];
	[_unit, .1] remoteExec ["setUnitRecoilCoefficient", groupOwner (group _unit)];
	[_unit, ["camouflageCoef",0.20]] remoteExec ["setUnitTrait", groupOwner (group _unit)];
	[_unit, ["audibleCoef",0.20]] remoteExec ["setUnitTrait", groupOwner (group _unit)];
	[_unit, ["loadCoef",1.0]] remoteExec ["setUnitTrait", groupOwner (group _unit)];

_unit setvariable ["saved_Loadout",[_unitvn,_unitrank,_unitface,_unitvoice,_unitskill,_unitgrp,_grpldr,_unitlo]];

if (isMultiPlayer) then
{	
	_unit addEventHandler ["Respawn",
	{
		params ["_unit"];
		_unit execVM "SettingsAdjustments.sqf";		
	}];
};
if (isPlayer _unit) then {

	[playerSide, "HQ"] commandChat "Settings Adjustments Done!";

};

/*
		_saved_Loadout = _unit getVariable "saved_Loadout";

		//hint format ["%1",_saved_Loadout];

		//copyToClipboard format ["%1",_saved_Loadout];

		_unitvn			= _saved_Loadout select 0;
		_unitrank   	= _saved_Loadout select 1;
		_unitface		= _saved_Loadout select 2;
		_unitvoice		= _saved_Loadout select 3;
		_unitskill		= _saved_Loadout select 4;
		_unitgrp		= _saved_Loadout select 5;	
		_grpldr			= _saved_Loadout select 6;
		_unitlo			= _saved_Loadout select 7;

		[_unit, _unitvn] remoteExec ["setVehicleVarName", groupOwner _unitgrp];

		[_unit, _unitrank] remoteExec ["setRank", groupOwner _unitgrp];

		[_unit, _unitface] remoteExec ["setFace", groupOwner _unitgrp];
			
		[_unit, _unitvoice] remoteExec ["setSpeaker", groupOwner _unitgrp];
		
		[_unit, _unitskill] remoteExec ["setSkill", groupOwner _unitgrp];

		[_unit, _unitlo] remoteExec ["setUnitLoadout", groupOwner _unitgrp];

*/
