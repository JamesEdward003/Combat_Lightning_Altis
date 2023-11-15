///////  execVM "respawn.sqf"  ///////
if ( "RespawnSP" call BIS_fnc_getParamValue isEqualTo 1 ) exitWith {};
if isMultiplayer exitWith {[playerSide, "HQ"] commandChat "'RespawnSP' not available!";};

waitUntil {!isNull player};
waitUntil {!isNil {player getVariable "LoadoutDone"}};
waitUntil {!isNil {player getVariable "LoadoutAdjustmentsDone"}};

[playerSide, "HQ"] commandChat "Initiating SinglePlayer Respawn!";

_unitvn		= vehicleVarName player;
_classname 	= format ["%1", typeOf player];
_displayname = gettext (configfile >> "CfgVehicles" >> _className >> "displayName");
_unitname 	= [name player,name player,name player];
_unitrank   = rank player;
_unitface	= face player;
_unitvoice	= speaker player;
_unitskill	= skill player;
_plyrgrp	= group player;	
_grpldr		= leader _plyrgrp;
_plyrlo		= getUnitLoadout player;

missionNamespace setVariable ["PlayerProfile",[_unitvn,_className,_displayName,_unitname,_unitrank,_unitface,_unitvoice,_unitskill,_plyrgrp,_grpldr,_plyrlo]];

_PlayerProfile = missionNamespace getVariable "PlayerProfile";

//hint format ["%1",_PlayerProfile];

//copyToClipboard format ["%1",_PlayerProfile];

// _p = [];
// if (isClass (missionConfigFile/"Params")) then {
// 	for "_i" from 0 to (count (missionConfigFile/"Params") - 1) do {
// 		_paramName = configName ((missionConfigFile >> "Params") select _i);
// 		missionNamespace setVariable [_paramName, getNumber (missionConfigFile >> "Params" >> _paramName >> "default")];
// 		_value = _paramName call BIS_fnc_getParamValue;
// 		_P = _P + [_paramName,_value];
// 	};
// };

// hint format ["%1",_p];

// copyToClipboard format ["%1",_p];

if (hasInterface) then {
	CurrentGroup = group player;
	IsGroupLeader = false;
	if (leader CurrentGroup  == leader player) then {
		IsGroupLeader = true;
	};
	player addEventHandler ["Respawn",
	{
		if (IsGroupLeader) then {
		CurrentGroup = group player;
		{[_x] joinSilent player} forEach (units CurrentGroup);
		CurrentGroup selectLeader player;
		};
	}];
};

playerRespawn = {

	cutText ["respawning","BLACK IN", 5];
	
	_PlayerProfile = missionNamespace getVariable "PlayerProfile";
	
	//	hint format ["%1",_PlayerProfile];

	//	copyToClipboard format ["%1",_PlayerProfile];

	// _p = [];
	// if (isClass (missionConfigFile/"Params")) then {
	// 	for "_i" from 0 to (count (missionConfigFile/"Params") - 1) do {
	// 		_paramName = configName ((missionConfigFile >> "Params") select _i);
	// 		missionNamespace setVariable [_paramName, getNumber (missionConfigFile >> "Params" >> _paramName >> "default")];
	// 		_value = _paramName call BIS_fnc_getParamValue;
	// 		_P = _P + [_paramName,_value];
	// 	};
	// };

	// hint format ["%1",_p];

	// copyToClipboard format ["%1",_p];

	_unitvn		= _PlayerProfile select 0;
	_className 	= _PlayerProfile select 1;
	_displayName = _PlayerProfile select 2;
	_unitname 	= _PlayerProfile select 3;
	_unitrank   = _PlayerProfile select 4;
	_unitface	= _PlayerProfile select 5;
	_unitvoice	= _PlayerProfile select 6;
	_unitskill	= _PlayerProfile select 7;
	_plyrgrp	= _PlayerProfile select 8;	
	_grpldr		= _PlayerProfile select 9;
	_plyrlo		= _PlayerProfile select 10;
	//_className createUnit [position, group, init, skill, rank]	getMarkerPos ["respawn_west", true];
	_className createUnit [getMarkerPos ["respawn_west", true], _plyrgrp, "selectPlayer this; (group player) selectLeader this; addSwitchableUnit this;"];
	player setVehiclePosition [getMarkerPos ["respawn_west", true], [], 0, "CAN_COLLIDE"];

	//if (_grpldr isEqualTo _unitvn) then {[_plyrgrp, player] remoteExec ["selectLeader", groupOwner _plyrgrp];};

	[player, "loadouts_multiterrain.sqf"] remoteExec ["execVM", groupOwner _plyrgrp];

	[player, "loadouts_woodland.sqf"] remoteExec ["execVM", groupOwner _plyrgrp];

	if ((("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue) isEqualTo 1) && (("BI_CP_loadouts_wl" call BIS_fnc_getParamValue) isEqualTo 1)) then {

		[player, _plyrlo] remoteExec ["setUnitLoadout", groupOwner _plyrgrp];

		player setVariable ["LoadoutDone", true];
	};

	[player, _unitvn] remoteExec ["setVehicleVarName", groupOwner _plyrgrp];

	[player, _unitrank] remoteExec ["setRank", groupOwner _plyrgrp];

	[player, _unitname] remoteExec ["setName", groupOwner _plyrgrp];

	[player, _unitface] remoteExec ["setFace", groupOwner _plyrgrp];
		
	[player, _unitvoice] remoteExec ["setSpeaker", groupOwner _plyrgrp];
	
	[player, _unitskill] remoteExec ["setSkill", groupOwner _plyrgrp];
		
	[player, _unitskill] remoteExec ["setSkill", groupOwner _plyrgrp];

	player execVM "RallyPoint.sqf";

	player execVM "RallyTent.sqf";

	player execVM "UnlimitedAmmo.sqf";

	player execVM "LoadoutAdjustments.sqf";

	player execVM "markers.sqf";

	execVM  "initPlayerLocal.sqf";

	execVM  "Military_Symbol_Module.sqf";

	waitUntil {!isNil {player getVariable "Briefing"}};

	call BIS_fnc_CPObjSetup;

	call BIS_fnc_CPObjBriefingSetup;

	call BIS_fnc_CPObjSetupClient;

	call BIS_fnc_CPObjTasksSetup;


	BIS_DeathBlur ppEffectAdjust [0.0];
	BIS_DeathBlur ppEffectCommit 0.0;

	private _future = time + 10;
	waitUntil { time >= _future };

	[playerSide, "HQ"] commandChat format ["%1 respawned!",name player];

	waitUntil {!alive player};
	call playerRespawn;

};

waitUntil {!alive player};
call playerRespawn;

//["Gambler_1","B_Captain_Pettka_F","Pettka",["RENFRO","RENFRO","RENFRO"],"MAJOR","Whitehead_02","male11eng",1,B Gambler,Gambler_1,[["arifle_MX_GL_Black_F","","acc_pointer_IR","optic_Nightstalker",["30Rnd_65x39_caseless_black_mag",30],["3Rnd_HE_Grenade_shell",3],""],[],["hgun_Pistol_heavy_01_MRD_F","","acc_flashlight_pistol","optic_MRD",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",2],["11Rnd_45ACP_Mag",2,11]]],["V_PlateCarrierSpec_mtp",[["B_UavTerminal",1],["MineDetector",1],["30Rnd_65x39_caseless_black_mag",5,30]]],["B_TacticalPack_mcamo",[["FirstAidKit",10],["Medikit",1],["3Rnd_HE_Grenade_shell",2,3],["SmokeShellGreen",2,1],["HandGrenade",2,1],["30Rnd_65x39_caseless_black_mag",1,30],["11Rnd_45ACP_Mag",1,11],["Laserbatteries",1,1]]],"H_Beret_Colonel","G_Goggles_VR",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","B_UavTerminal","ItemRadio","ItemCompass","ItemWatch",""]]]

//["Param_Daytime","WindDirection","WindStrength","Weather_Param","Param_ViewDistance","BIS_CP_garrison","BIS_CP_reinforcements","BIS_CP_showInsertion","BIS_CP_tickets","BIS_CP_enemyFaction","BIS_CP_objective","BIS_CP_locationSelection","BI_CP_startLocation","Bskill","Oskill","Rskill","BloodEffect","PRegenHealth","InitRevive","Alt_C_Medic","Ctrl_C_Lightning","BI_CP_loadouts_wl","BI_CP_loadouts_mtp","PRallyPoint","PRallyTent","PMarkers","BI_CP_UnlimitedAmmo","BI_CP_LoadoutAdjustments","BI_CP_SettingsAdjustments","BI_CP_GroupIconOver","BI_CP_IntroCam","BI_CP_Kestrel","BI_CP_Cam","BI_CP_CamOldReWrite","MissionStatus","MissionSaves","MSymbols","RespawnSP","GroupRespawnSP","GodMode","Artillery","Missile","LaserMissile","Mortar","MortarBag","ParaTeam","ParaDrop","HaloJump","HaloJumpGroup","CargoDrop","AirSupport","AirLift","AirLift2","WindSpeed","ReviveMode","ReviveDuration","ReviveRequiredTrait","ReviveMedicSpeedMultiplier","ReviveRequiredItems","UnconsciousStateMode","ReviveBleedOutDuration","ReviveForceRespawnDuration"]

//["Param_Daytime",16,"WindDirection",5,"WindStrength",3,"Weather_Param",5,"Param_ViewDistance",1000,"BIS_CP_garrison",1,"BIS_CP_reinforcements",1,"BIS_CP_showInsertion",0,"BIS_CP_tickets",5,"BIS_CP_enemyFaction",2,"BIS_CP_objective",-1,"BIS_CP_locationSelection",0,"BI_CP_startLocation",2,"Bskill",4,"Oskill",3,"Rskill",2,"BloodEffect",8,"PRegenHealth",1,"InitRevive",1,"Alt_C_Medic",2,"Ctrl_C_Lightning",2,"BI_CP_loadouts_wl",1,"BI_CP_loadouts_mtp",3,"PRallyPoint",2,"PRallyTent",2,"PMarkers",2,"BI_CP_UnlimitedAmmo",2,"BI_CP_LoadoutAdjustments",3,"BI_CP_SettingsAdjustments",2,"BI_CP_GroupIconOver",1,"BI_CP_IntroCam",1,"BI_CP_Kestrel",1,"BI_CP_Cam",1,"BI_CP_CamOldReWrite",2,"MissionStatus",2,"MissionSaves",1,"MSymbols",4,"RespawnSP",2,"GroupRespawnSP",1,"GodMode",1,"Artillery",2,"Missile",2,"LaserMissile",2,"Mortar",1,"MortarBag",1,"ParaTeam",2,"ParaDrop",2,"HaloJump",1,"HaloJumpGroup",2,"CargoDrop",2,"AirSupport",2,"AirLift",2,"AirLift2",2,"WindSpeed",1,"ReviveMode",-100,"ReviveDuration",-100,"ReviveRequiredTrait",-100,"ReviveMedicSpeedMultiplier",-100,"ReviveRequiredItems",-100,"UnconsciousStateMode",-100,"ReviveBleedOutDuration",-100,"ReviveForceRespawnDuration",-100]

//["Param_Daytime",16,"WindDirection",5,"WindStrength",3,"Weather_Param",5,"Param_ViewDistance",1000,"BIS_CP_garrison",1,"BIS_CP_reinforcements",1,"BIS_CP_showInsertion",0,"BIS_CP_tickets",5,"BIS_CP_enemyFaction",2,"BIS_CP_objective",-1,"BIS_CP_locationSelection",0,"BI_CP_startLocation",2,"Bskill",4,"Oskill",3,"Rskill",2,"BloodEffect",8,"PRegenHealth",1,"InitRevive",1,"Alt_C_Medic",2,"Ctrl_C_Lightning",2,"BI_CP_loadouts_wl",1,"BI_CP_loadouts_mtp",3,"PRallyPoint",2,"PRallyTent",2,"PMarkers",2,"BI_CP_UnlimitedAmmo",2,"BI_CP_LoadoutAdjustments",3,"BI_CP_SettingsAdjustments",2,"BI_CP_GroupIconOver",1,"BI_CP_IntroCam",1,"BI_CP_Kestrel",1,"BI_CP_Cam",1,"BI_CP_CamOldReWrite",2,"MissionStatus",2,"MissionSaves",1,"MSymbols",4,"RespawnSP",2,"GroupRespawnSP",1,"GodMode",1,"Artillery",2,"Missile",2,"LaserMissile",2,"Mortar",1,"MortarBag",1,"ParaTeam",2,"ParaDrop",2,"HaloJump",1,"HaloJumpGroup",2,"CargoDrop",2,"AirSupport",2,"AirLift",2,"AirLift2",2,"WindSpeed",1,"ReviveMode",-100,"ReviveDuration",-100,"ReviveRequiredTrait",-100,"ReviveMedicSpeedMultiplier",-100,"ReviveRequiredItems",-100,"UnconsciousStateMode",-100,"ReviveBleedOutDuration",-100,"ReviveForceRespawnDuration",-100]


