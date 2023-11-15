///  	execVM "SinglePlayer_Respawn.sqf";	///
_SinglePlayerRespawn = "SinglePlayerRespawn" call BIS_fnc_getParamValue;
if (_SinglePlayerRespawn isEqualTo 1) exitWith {};
if isMultiplayer exitWith {};

waitUntil { !isNil { player getVariable "LoadoutDone" } };

[playerSide, "HQ"] commandChat format ["%1 be sure to set your rally point!",name player];
//systemChat format ["%1 be sure to set your rally point!",name player];
_unitvn			= vehicleVarName player;
_classname 		= format ["%1", typeOf player];
_displayname 	= gettext (configfile >> "CfgVehicles" >> _className >> "displayName");
_unitname 		= [name player,name player,name player];
_unitrank   	= rank player;
_unitface		= face player;
_unitvoice		= speaker player;
_unitskill		= skill player;
_plyrgrp		= group player;	
_grpldr			= leader _plyrgrp;
_plyrlo			= getUnitLoadout player;

[player, 0.10] remoteExec ["setCustomAimCoef", groupOwner _plyrgrp];
[player, 0.20] remoteExec ["setUnitRecoilCoefficient", groupOwner _plyrgrp];
[player, false] remoteExec ["enablestamina", groupOwner _plyrgrp];
[player, ["camouflageCoef",0.20]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];
[player, ["loadCoef",1.0]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];

missionNamespace setVariable ["PlayerProfile",[_unitvn,_className,_displayName,_unitname,_unitrank,_unitface,_unitvoice,_unitskill,_plyrgrp,_grpldr,_plyrlo]];

_PlayerProfile = missionNamespace getVariable "PlayerProfile";

//	hint format ["%1",_PlayerProfile];

//	copyToClipboard format ["%1",_PlayerProfile];

playerRespawn = {

	_rallycount = switch (playerSide) do 
		{
			case west: 			{"rally_count_west"};
			case east: 			{"rally_count_east"};
			case resistance: 	{"rally_count_guerrila"};
			case civilian:		{"rally_count_civilian"};
		};
	_rally = switch (playerSide) do
		{
			case WEST: 			{"respawn_west"};
			case EAST: 			{"respawn_east"};
			case RESISTANCE: 	{"respawn_guerrila"};
			case CIVILIAN: 		{"respawn_civilian"};
		};

	if (!(isNil {missionNamespace getVariable _rallycount})) then
	{
		_cnt = missionNamespace getVariable _rallycount;
		_mrkrname = format ["%1_%2",_rally,_cnt]; 
		_rally = str _mrkrname;
		missionNamespace setVariable [_rallycount, _cnt, true];
	} else {		
		_cnt = 1;
		_mrkrname = format ["%1_%2",_rally,_cnt];
		_rally = str _mrkrname;
		missionNamespace setVariable [_rallycount, _cnt, true];
    };
				
	cutText ["respawning","BLACK IN", 5];

	_PlayerProfile = missionNamespace getVariable "PlayerProfile";

//	hint format ["%1",_PlayerProfile];

//	copyToClipboard format ["%1",_PlayerProfile];

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

	//_className createUnit [position, group, init, skill, rank] getMarkerPos ["respawn_west", true];
	_className createUnit [getMarkerPos [_rally, true], _plyrgrp, "selectPlayer this"];
	player setVehiclePosition [getMarkerPos [_rally, true], [], 0, "CAN_COLLIDE"];

	[player] remoteExec ["addSwitchableUnit", groupOwner _plyrgrp];

	if (_grpldr isEqualTo _unitvn) then {[_plyrgrp, player] remoteExec ["selectLeader", groupOwner _plyrgrp];};

	[player, (missionNamespace getVariable "saved_loadout")] remoteExec ["setUnitLoadout", groupOwner _plyrgrp];

	_BI_CP_loadouts_wl = "BI_CP_loadouts_wl" call BIS_fnc_getParamValue;
	_BI_CP_loadouts_mtp = "BI_CP_loadouts_mtp" call BIS_fnc_getParamValue;

	if (_BI_CP_loadouts_wl isEqualTo 2) then {

		player call loadouts_woodland;
	};

	if (_BI_CP_loadouts_mtp isEqualTo 2) then {

		player call loadouts_multiterrain;
	};

	if ((_BI_CP_loadouts_mtp isEqualTo 1) && (_BI_CP_loadouts_wl isEqualTo 1)) then {

		[player, _plyrlo] remoteExec ["setUnitLoadout", groupOwner _plyrgrp];
	};

	[player, 0.30] remoteExec ["setCustomAimCoef", groupOwner _plyrgrp];
	[player, 0.30] remoteExec ["setUnitRecoilCoefficient", groupOwner _plyrgrp];
	[player, false] remoteExec ["enableStamina", groupOwner _plyrgrp];
	[player, ["camouflageCoef",0.20]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];
	[player, ["loadCoef",1.0]] remoteExec ["setUnitTrait", groupOwner _plyrgrp];

	[player, _unitvn] remoteExec ["setVehicleVarName", groupOwner _plyrgrp];

	[player, _unitrank] remoteExec ["setRank", groupOwner _plyrgrp];

	[player, _unitname] remoteExec ["setName", groupOwner _plyrgrp];

	[player, _unitface] remoteExec ["setFace", groupOwner _plyrgrp];
		
	[player, _unitvoice] remoteExec ["setSpeaker", groupOwner _plyrgrp];
	
	[player, _unitskill] remoteExec ["setSkill", groupOwner _plyrgrp];
			
	player switchCamera "EXTERNAL";

	player execVM "SettingsAdjustments.sqf";

	player execVM "LoadoutAdjustments.sqf";

	player execVM "UnlimitedAmmo.sqf";

	player execVM "RallyPoint.sqf";

	player execVM "RallyTent.sqf";

	execVM  "initPlayerLocal.sqf";

	openmap [false,false];

	BIS_DeathBlur ppEffectAdjust [0.0];
	BIS_DeathBlur ppEffectCommit 0.0;

	private _future = time + 10;
	waitUntil { time >= _future };

	[playerSide, "HQ"] commandChat format ["%1 respawned!",name player];
			
	waitUntil {!alive player};
	[missionNamespace, ["saved_loadout", getUnitLoadout player]] remoteExec ["setVariable", groupOwner (group player)];
	call playerRespawn;
};

waitUntil {!alive player};
[missionNamespace, ["saved_loadout", getUnitLoadout player]] remoteExec ["setVariable", groupOwner (group player)];
call playerRespawn;
