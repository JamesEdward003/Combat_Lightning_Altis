///////////////////  "ParamsPlus\paraDrop.sqf"  ////////////////////
if ( "ParaDrop" call BIS_fnc_getParamValue isEqualTo 1 ) exitWith {};
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
_mrkrcolor = switch (side _caller) do {

         case west:			{"ColorBlue"};
         case east:			{"ColorRed"};
         case resistance:	{"ColorGreen"};
         case civilian:		{"ColorYellow"};
};
_mrkrname = format ["mrkr_%1", round(random 10000)];

[_caller, "Requesting parachute drop at the designated coordinates"] remoteExecCall ["commandChat", 0];

playSound3D ["A3\dubbing_f\modules\supports\drop_request.ogg", _caller];

if (_position isEqualTo []) then { 

	objective = false;
	sleep 0.25;
	openmap [true,false];
	sleep 0.25;
	titleText ['<t color=''#ffdd22'' size=''1''>MAPCLICK COORDINATES!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

	onMapSingleClick "onMapSingleClick ''; mappos = _pos; objective = true";		
	waitUntil {sleep 1; (!visiblemap OR objective OR !alive _caller)};
	if (!objective OR !alive _caller) exitWith {
	mappos = nil;
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Mark position canceled</t>"];
	titletext ["","plain"];
	};
	
	_mrkr = createMarkerLocal [_mrkrname, mappos];
	_mrkr setMarkerTypeLocal "mil_objective";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal " Para Drop";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;
	
	titletext ["","plain",0.2];
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mark position successful</t>"];
	
	_position = [(getMarkerPos _mrkrname) select 0,(getMarkerPos _mrkrname) select 1,100];

	uisleep 1;
	openmap [false,false];

} else {

	uisleep 6;

	_mrkr = createMarkerLocal [_mrkrname, _position];
	_mrkr setMarkerTypeLocal "mil_objective";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal " Para Drop";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;
	
	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mark position successful</t>"];

	_position = [_position select 0,_position select 1,100];
};
uisleep 4;
hintSilent "";

if (_position isEqualTo []) exitWith {
	[_caller, "Request canceled"] remoteExecCall ["commandChat", 0];
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Position Out Of Range!</t>"];
	playSound3D ["A3\dubbing_f\modules\supports\drop_destroyed.ogg", _caller];
	deleteMarker _mrkrname;
	uisleep 6;
	hintSilent "";
};

_randDir 			= 	getDir vehicle _caller;
_randDist 			= 	(random 100) + 2000;
_airStart 			=	[(_position select 0) + (_randDist * sin(_randDir)), (_position select 1) + (_randDist * cos(_randDir)), 120];
_randDir2 			= 	getDir vehicle _caller - 180;
_airEnd 			=	[(_position select 0) + (_randDist * sin(_randDir2)), (_position select 1) + (_randDist * cos(_randDir2)), 120];
//_airTypes 		= 	B_T_VTOL_01_infantry_F // B_Heli_Light_01_F // B_Heli_Light_01_stripped_F // B_Heli_Transport_01_F // B_Heli_Transport_01_camo_F ////DLC > B_Heli_Transport_03_F // B_Heli_Transport_03_unarmed_F
//_airTypes			=	O_T_VTOL_02_infantry_dynamicLoadout_F // O_Heli_Light_02_F // O_Heli_Light_02_unarmed_F // O_Heli_Light_02_v2_F ////DLC > O_Heli_Transport_04_F 
_airType = switch (side _caller) do {

	case west: 			{"B_T_VTOL_01_infantry_F"};
	case east: 			{"O_T_VTOL_02_infantry_dynamicLoadout_F"};
	case resistance: 	{"I_C_Plane_Civil_01_F"};
	case civilian: 		{"C_Plane_Civil_01_F"};
};
_airName = switch (side _caller) do {

	case west: 			{"WestPara"};
	case east: 			{"EastPara"};
	case resistance: 	{"GuerPara"};
	case civilian: 		{"CivPara"};
};
_cargoType = switch (side _caller) do {

	case west: 			{"B_supplyCrate_F"};
	case east: 			{"O_supplyCrate_F"};
	case resistance: 	{"I_supplyCrate_F"};
	case civilian: 		{"Box_GEN_Equip_F"};
};
_airDrop = [];
_airDrop = format ["%1Drop",_airName];
_cargoID = [];
_cargoID = format ["Cargo_%1", round(random 10000)];

_reUnits_w = 
["B_CTRG_soldier_AR_A_F","B_G_Captain_Ivan_F","B_Captain_Jay_F","B_CTRG_soldier_GL_LAT_F","B_Story_Protagonist_F","B_CTRG_soldier_engineer_exp_F","B_CTRG_soldier_M_medic_F"];
_reUnits_e = 
["O_Soldier_GL_F","O_Soldier_AT_F","O_soldier_M_F","O_soldier_exp_F","O_engineer_F","O_soldier_mine_F","O_medic_F"];
_reUnits_r = 
["I_Story_Colonel_F","I_Captain_Hladas_F","I_Story_Officer_01_F","I_Soldier_LAT_F","I_engineer_F","I_soldier_mine_F","I_medic_F"];
_reUnits_c = 
["C_Orestes","C_man_p_fugitive_F_euro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_p_beggar_F_afro","C_man_w_worker_F","C_man_polo_2_F"];

_unitrank = ["lieutenant","sergeant","sergeant","corporal","corporal","corporal","corporal"];

if (!isNil {missionNamespace getVariable _airDrop}) exitWith {
	hintSilent parseText format["<t size='1.25' color='#FF5500'>ParaDrop Currently In Progress!</t>"];
	deleteMarker _mrkrname;
	uisleep 6;
	hintSilent "";
};

missionNamespace setVariable [_airDrop,true];

playSound3D ["A3\dubbing_f\modules\supports\drop_acknowledged.ogg", _caller];

[_airStart, _airEnd, 120, "NORMAL", _airType, west] call BIS_fnc_ambientFlyby;

_airName = nearestObject [_airStart, _airType];

_airName setDestination [getMarkerPos _mrkrname, "VEHICLE PLANNED", true];

_airName moveTo (getMarkerPos _mrkrname);

waitUntil {(_airName distance2d _position) < 240};

_smokePos = [_position select 0, _position select 1, ((_position select 2) + 10)];
_greenSmoke = createVehicle ["SmokeShellGreen", _smokePos, [], 0, "NONE"];
//_jumpTarget = createVehicle ["Land_JumpTarget_F", _smokePos, [], 0, "NONE"];

switch (side _caller) do {
	
	case west: {
			
	for "_i" from 0 to count _reUnits_w -1 do {
		_type = _reUnits_w select _i;
		_rank = _unitrank select _i;
		_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
		_unit = (group _caller) createUnit [_type, position _airName, [], 0, "FORM"];
		_unit disableCollisionWith _airName;
		_unit allowDamage false;
		_group	= group _unit;

		_text = toArray(str _group);
		_text set[0,"**DELETE**"];
		_text set[1,"**DELETE**"];
		_text = _text - ["**DELETE**"];
		_grp = toString(_text);
		_grpCount = (units group _unit) find _unit;
		
		_varname = format ["%1_%2",_grp,_grpCount];			
		
		[_unit, _rank] remoteExec ["setRank", groupOwner (group _caller)];

		[_unit, _varname] remoteExec ["setVehicleVarName", groupOwner (group _caller)];

		[_unit, _displayname] remoteExec ["setName", groupOwner _group];

		addswitchableunit _unit;

		_chute = createVehicle ["NonSteerable_Parachute_F", (getPos _unit), [], 0, "FLY"];
		_chute disableCollisionWith _airName;
		_chute allowDamage false;
		_chute setPos (getPos _unit);
		_unit moveinDriver _chute;

		_unit execVM "loadouts_multiterrain.sqf";
			
		_unit execVM "loadouts_woodland.sqf";

		_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

		_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

		_unit execVM "ParamsPlus\Markers.sqf";

		if (("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue isEqualTo 1) and ("BI_CP_loadouts_wl" call BIS_fnc_getParamValue isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

		_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

		_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

		_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

		if (_unit isEqualTo leader _group) then {

			titleText ['<t color=''#ffdd22'' size=''2''>PARA DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

			playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];

			_offDir = _unit getRelDir _position;

			1 setWindDir _offDir; 1 setWindStr 1.0; 1 setWindForce 1.0; 10 setGusts 1.0;
		};
	};
	_box = createVehicle [_cargoType, [getPosATL _airName select 0,getPosATL _airName select 1,(getPosATL _airName select 2)-3], [], 0, "NONE"];
	//_box = createVehicle ["B_supplyCrate_F", position _airName, [], 0, "FLY"];
	_box disableCollisionWith _airName;
	_box allowDamage false;
//	_box setPos position _airName;
//	_chute = createVehicle ["B_Parachute_02_F", (getPos _box), [], 0, "FLY"];
//	_chute disableCollisionWith _airName;
//	_chute allowDamage false;
//	_box attachto [_chute, [0, 0, 0]];
	[objnull, _box] call BIS_fnc_curatorobjectedited;
	waitUntil {sleep 1; !isNil "_box"};   
	["AmmoboxInit", [_box, true, {true}]] spawn BIS_fnc_arsenal;
	waitUntil {((getPos _box) select 2) < 1};
	detach _box;
	"SmokeShellgreen" createVehicle getPos _box;
	"F_40mm_White" createVehicle [getPos _box select 0,getPos _box select 1,+150];
	_mrkrname setMarkerPos getPos _box;
	_mrkrname setMarkerTextLocal "Ammo";
	{_x allowDamage true} forEach units group _caller;
	units group _caller doFollow leader group _caller;
	titleText ['<t color=''#ffdd22'' size=''2''>AMMO DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
	playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];
	};
	case east: {
					
	for "_i" from 0 to count _reUnits_e -1 do {
		_type = _reUnits_e select _i;
		_rank = _unitrank select _i;
		_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
		_unit = (group _caller) createUnit [_type, position _airName, [], 0, "FORM"];
		_group	= group _unit;
		_unit allowDamage false;

		_text = toArray(str _group);
		_text set[0,"**DELETE**"];
		_text set[1,"**DELETE**"];
		_text = _text - ["**DELETE**"];
		_grp = toString(_text);
		_grpCount = (units group _unit) find _unit;
		
		_varname = format ["%1_"+"%2",_grp,_grpCount];			
		
		[_unit, _rank] remoteExec ["setRank", groupOwner (group _caller)];

		[_unit, _varname] remoteExec ["setVehicleVarName", groupOwner (group _caller)];

		[_unit, _displayname] remoteExec ["setName", groupOwner _group];

		addswitchableunit _unit;

		_chute = createVehicle ["NonSteerable_Parachute_F", (getPos _unit), [], 0, "FLY"];
		_chute disableCollisionWith _airName;
		_chute allowDamage false;
		_chute setPos (getPos _unit);
		_unit moveinDriver _chute;
		
		_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

		_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

		_unit execVM "ParamsPlus\Markers.sqf";

		if (("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue isEqualTo 1) and ("BI_CP_loadouts_wl" call BIS_fnc_getParamValue isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

		_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

		_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

		_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

		if (_unit isEqualTo leader _group) then {

			titleText ['<t color=''#ffdd22'' size=''2''>PARA DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

			playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];

			_offDir = _unit getRelDir _position;

			1 setWindDir _offDir; 1 setWindStr 1.0; 1 setWindForce 1.0; 10 setGusts 1.0;
		};
	};
	_box = createVehicle [_cargoType, [getPosATL _airName select 0,getPosATL _airName select 1,(getPosATL _airName select 2)-3], [], 0, "NONE"];
	//_box = createVehicle ["O_supplyCrate_F", position _airName, [], 0, "FLY"];
	_box disableCollisionWith _airName;
	_box allowDamage false;
//	_box setPos position _airName;
//	_chute = createVehicle ["B_Parachute_02_F", (getPos _box), [], 0, "FLY"];
//	_chute disableCollisionWith _airName;
//	_chute allowDamage false;
//	_box attachto [_chute, [0, 0, 0]];
	[objnull, _box] call BIS_fnc_curatorobjectedited;
	waitUntil {sleep 1; !isNil "_box"};   
	["AmmoboxInit", [_box, true, {true}]] spawn BIS_fnc_arsenal;
	waitUntil {((getPos _box) select 2) < 1};
	detach _box;
	"SmokeShellgreen" createVehicle getPos _box;
	"F_40mm_White" createVehicle [getPos _box select 0,getPos _box select 1,+150];
	_mrkrname setMarkerPos getPos _box;
	_mrkrname setMarkerTextLocal "Ammo";
	{_x allowDamage true} forEach units group _caller;
	units group _caller doFollow leader group _caller;
	titleText ['<t color=''#ffdd22'' size=''2''>AMMO DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
	playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];
	};
	case resistance: {

	for "_i" from 0 to count _reUnits_r -1 do {
		_type = _reUnits_r select _i;
		_rank = _unitrank select _i;
		_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
		_unit = (group _caller) createUnit [_type, position _airName, [], 0, "FORM"];
		_group	= group _unit;
		_unit allowDamage false;

		_text = toArray(str _group);
		_text set[0,"**DELETE**"];
		_text set[1,"**DELETE**"];
		_text = _text - ["**DELETE**"];
		_grp = toString(_text);
		_grpCount = (units group _unit) find _unit;
		
		_varname = format ["%1_"+"%2",_grp,_grpCount];			
		
		[_unit, _rank] remoteExec ["setRank", groupOwner (group _caller)];

		[_unit, _varname] remoteExec ["setVehicleVarName", groupOwner (group _caller)];

		[_unit, _displayname] remoteExec ["setName", groupOwner _group];

		addswitchableunit _unit;
				
		_chute = createVehicle ["NonSteerable_Parachute_F", (getPos _unit), [], 0, "FLY"];
		_chute disableCollisionWith _airName;
		_chute allowDamage false;
		_chute setPos (getPos _unit);
		_unit moveinDriver _chute;
		
		_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

		_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

		_unit execVM "ParamsPlus\Markers.sqf";

		if (("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue isEqualTo 1) and ("BI_CP_loadouts_wl" call BIS_fnc_getParamValue isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

		_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

		_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

		_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

		if (_unit isEqualTo leader _group) then {

			titleText ['<t color=''#ffdd22'' size=''2''>PARA DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

			playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];

			_offDir = _unit getRelDir _position;

			1 setWindDir _offDir; 1 setWindStr 1.0; 1 setWindForce 1.0; 10 setGusts 1.0;
		};
	};
	_box = createVehicle [_cargoType, [getPosATL _airName select 0,getPosATL _airName select 1,(getPosATL _airName select 2)-3], [], 0, "NONE"];
	//_box = createVehicle ["I_supplyCrate_F", position _airName, [], 0, "FLY"];
	_box disableCollisionWith _airName;
	_box allowDamage false;
//	_box setPos position _airName;
//	_chute = createVehicle ["B_Parachute_02_F", (getPos _box), [], 0, "FLY"];
//	_chute disableCollisionWith _airName;
//	_chute allowDamage false;
//	_box attachto [_chute, [0, 0, 0]];
	[objnull, _box] call BIS_fnc_curatorobjectedited;
	waitUntil {sleep 1; !isNil "_box"};   
	["AmmoboxInit", [_box, true, {true}]] spawn BIS_fnc_arsenal;
	waitUntil {((getPos _box) select 2) < 1};
	detach _box;
	"SmokeShellgreen" createVehicle getPos _box;
	"F_40mm_White" createVehicle [getPos _box select 0,getPos _box select 1,+150];
	_mrkrname setMarkerPos getPos _box;
	_mrkrname setMarkerTextLocal "Ammo";
	{_x allowDamage true} forEach units group _caller;
	units group _caller doFollow leader group _caller;
	titleText ['<t color=''#ffdd22'' size=''2''>AMMO DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
	playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];
	};
	case civilian: {
			
	for "_i" from 0 to count _reUnits_c -1 do {
		_type = _reUnits_c select _i;
		_rank = _unitrank select _i;
		_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
		_unit = (group _caller) createUnit [_type, position _airName, [], 0, "FORM"];
		_group	= group _unit;
		_unit allowDamage false;

		_text = toArray(str _group);
		_text set[0,"**DELETE**"];
		_text set[1,"**DELETE**"];
		_text = _text - ["**DELETE**"];
		_grp = toString(_text);
		_grpCount = (units group _unit) find _unit;
		
		_varname = format ["%1_"+"%2",_grp,_grpCount];			
		
		[_unit, _rank] remoteExec ["setRank", groupOwner (group _caller)];

		[_unit, _varname] remoteExec ["setVehicleVarName", groupOwner (group _caller)];

		[_unit, _displayname] remoteExec ["setName", groupOwner _group];

		addswitchableunit _unit;
				
		_chute = createVehicle ["NonSteerable_Parachute_F", (getPos _unit), [], 0, "FLY"];
		_chute disableCollisionWith _airName;
		_chute allowDamage false;
		_chute setPos (getPos _unit);
		_unit moveinDriver _chute;

		_unit setUnitLoadout selectRandom ["I_engineer_F","I_soldier_mine_F","I_medic_F","I_soldier_F","I_Soldier_A_F","I_Soldier_LAT_F","I_Soldier_M_F","I_Soldier_AR_F","I_Soldier_TL_F","I_Soldier_SL_F"]; 

		[_unit, selectRandom ["I_engineer_F","I_soldier_mine_F","I_medic_F","I_soldier_F","I_Soldier_A_F","I_Soldier_LAT_F","I_Soldier_M_F","I_Soldier_AR_F","I_Soldier_TL_F","I_Soldier_SL_F"]] remoteExec ["setIdentity", 0, _unit];		
		
		_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

		_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

		_unit execVM "ParamsPlus\Markers.sqf";

		if (("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue isEqualTo 1) and ("BI_CP_loadouts_wl" call BIS_fnc_getParamValue isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

		_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

		_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

		_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

		if (_unit isEqualTo leader _group) then {

			titleText ['<t color=''#ffdd22'' size=''2''>PARA DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

			playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];

			_offDir = _unit getRelDir _position;

			1 setWindDir _offDir; 1 setWindStr 1.0; 1 setWindForce 1.0; 10 setGusts 1.0;
		};		
	};
	_box = createVehicle [_cargoType, [getPosATL _airName select 0,getPosATL _airName select 1,(getPosATL _airName select 2)-3], [], 0, "NONE"];
	//_box = createVehicle ["C_supplyCrate_F", position _airName, [], 0, "FLY"];
	_box disableCollisionWith _airName;
	_box allowDamage false;
//	_box setPos position _airName;
//	_chute = createVehicle ["B_Parachute_02_F", (getPos _box), [], 0, "FLY"];
//	_chute disableCollisionWith _airName;
//	_chute allowDamage false;
//	_box attachto [_chute, [0, 0, 0]];
	[objnull, _box] call BIS_fnc_curatorobjectedited;
	waitUntil {sleep 1; !isNil "_box"};   
	["AmmoboxInit", [_box, true, {true}]] spawn BIS_fnc_arsenal;
	waitUntil {((getPos _box) select 2) < 1};
	detach _box;
	"SmokeShellgreen" createVehicle getPos _box;
	"F_40mm_White" createVehicle [getPos _box select 0,getPos _box select 1,+150];
	_mrkrname setMarkerPos getPos _box;
	_mrkrname setMarkerTextLocal "Ammo";
	{_x allowDamage true} forEach units group _caller;
	units group _caller doFollow leader group _caller;
	titleText ['<t color=''#ffdd22'' size=''2''>AMMO DROP ON THE MARKER!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
	playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", _caller];
	};
};

missionNamespace setVariable [_airDrop,nil];
/*
************************************************************
_text= {
    [ format["<t size='0.75' color='#FFFFFF'>Reinforcements are inbound, Check the map.</t>",_this], 0,1,5,0,0,301] spawn bis_fnc_dynamicText;
};	
	
call _text;

************************************************************
["<t color='#ff0000' size='.8'>Warning!<br />Stop doing what you are doing</t>",-1,-1,4,1,0,789] spawn BIS_fnc_dynamicText;

************************************************************
["Call made to nearest medic", "Stand By..."] spawn BIS_fnc_showSubtitle; 

************************************************************
[
	["CROSSROAD", "Mission is a go, I repeat, mission is a go! Crossroad, out.", 0]
] spawn BIS_fnc_EXP_camp_playSubtitles;

*************************************************************
[
	["Speaker1", "Subtitle1", 0],
	["Speaker2", "Subtitle2", 5],
	["Speaker3", "Subtitle3", 10],
	["Speaker4", "Subtitle4", 15]
] spawn BIS_fnc_EXP_camp_playSubtitles;

sleep 7;
BIS_fnc_EXP_camp_playSubtitles_terminate = true;

**************************************************************
colorTextGrey = {format ["<t color='#505050'>%1</t>", _this]};
colorTextWhite = {format ["<t color='#ffffff'>%1</t>", _this]};
and then have

["Project leader" call colorTextGrey, "We need to investigate whatever's in the crater." call colorTextWhite] call BIS_fnc_showSubtitle;
**************************************************************


["<t color='#FF0000'>Dragon", "NATO forces are in the AO."] call BIS_fnc_showSubtitle;
*/