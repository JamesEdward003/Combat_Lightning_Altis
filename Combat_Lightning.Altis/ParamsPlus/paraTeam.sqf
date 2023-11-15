////////////////  "ParamsPlus\paraTeam.sqf"  //////////////////
_ParaTeam = "ParaTeam" call BIS_fnc_getParamValue;
if ( "ParaTeam" call BIS_fnc_getParamValue isEqualTo 1 ) exitWith {};
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

if (_position isEqualTo []) then { 

	objective = false;
	sleep 0.25;
	openmap [true,false];
	sleep 0.25;

	titleText["Map target", "PLAIN"];
	onMapSingleClick "onMapSingleClick ''; mappos = _pos; objective = true";		
	waitUntil {sleep 1; (!visiblemap OR objective OR !alive _caller)};
		if (!objective OR !alive _caller) exitWith {
		mappos = nil;
		hint parseText format["<t size='1.25' color='#FF5500'>Map target canceled</t>"];
		titletext ["","plain"];
		};
	
	_mrkr = createMarkerLocal [_mrkrname, mappos];
	_mrkr setMarkerTypeLocal "mil_objective";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal " Para Team";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;
	
	titletext ["","plain",0.2];
	hint parseText format["<t size='1.25' color='#00FFFF'>Map target successful</t>"];

	_position = [getMarkerPos _mrkrname select 0,getMarkerPos _mrkrname select 1,0];

} else {
		  
	_mrkr = createMarkerLocal [_mrkrname, _position];
	_mrkr setMarkerTypeLocal "mil_objective";
	_mrkr setMarkerShapeLocal "Icon";
	_mrkr setMarkerTextLocal " Para Team";
	_mrkr setMarkerSizeLocal [.75,.75];
	_mrkr setMarkerAlphaLocal .75;
	_mrkr setMarkerColorLocal _mrkrcolor;
	
	hint parseText format["<t size='1.25' color='#00FFFF'>Mark target successful</t>"];

	_position = [_position select 0,_position select 1,0];
};
uisleep 1;
openmap [false,false];
if (_position isEqualTo []) exitWith {[_caller, "Request canceled"] remoteExecCall ["commandChat", 0];};

switch (side _caller) do {
	
	case west: {
		
	_reUnits_w = ["B_Captain_Pettka_F","B_Captain_Jay_F","B_CTRG_soldier_AR_A_F","B_CTRG_soldier_GL_LAT_F","B_Story_Protagonist_F","B_CTRG_soldier_engineer_exp_F","B_CTRG_soldier_M_medic_F"];
	_unitrank = ["captain","captain","lieutenant","sergeant","sergeant","corporal","corporal"];
		
		for "_i" from 0 to count _reUnits_w -1 do {
			_type = _reUnits_w select _i;
			_rank = _unitrank select _i;
			_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
			_unit = (group _caller) createUnit [_type, _position, [], 0, "FORM"];
			_group	= group _unit;
			_unit allowDamage false;

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

			_unit execVM "loadouts_multiterrain.sqf";
			
			_unit execVM "loadouts_woodland.sqf";

			_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

			_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

			_unit execVM "ParamsPlus\Markers.sqf";

			if ((_BI_CP_loadouts_mtp isEqualTo 1) and (_BI_CP_loadouts_wl isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

			_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

			_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

			_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

			_unit allowDamage true;

			units group _caller doFollow leader group _caller;
		};
	};
	case east: {
		
	_reUnits_e = ["O_Soldier_GL_F","O_Soldier_AT_F","O_soldier_M_F","O_soldier_exp_F","O_engineer_F","O_soldier_mine_F","O_medic_F"];
	_unitrank = ["captain","captain","lieutenant","sergeant","sergeant","corporal","corporal"];
		
		for "_i" from 0 to count _reUnits_e -1 do {
			_type = _reUnits_e select _i;
			_rank = _unitrank select _i;
			_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
			_unit = (group _caller) createUnit [_type, _position, [], 0, "FORM"];
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

			_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

			_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

			_unit execVM "ParamsPlus\Markers.sqf";

			if ((_BI_CP_loadouts_mtp isEqualTo 1) and (_BI_CP_loadouts_wl isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

			_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

			_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

			_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

			_unit allowDamage true;

			units group _caller doFollow leader group _caller;
		};
	};
	case resistance: {
		
	_reUnits_r = ["I_Story_Colonel_F","I_Captain_Hladas_F","I_Story_Officer_01_F","I_Story_Crew_F","I_engineer_F","I_soldier_mine_F","I_medic_F"];
	_unitrank = ["captain","captain","lieutenant","sergeant","sergeant","corporal","corporal"];

		for "_i" from 0 to count _reUnits_r -1 do {
			_type = _reUnits_r select _i;
			_rank = _unitrank select _i;
			_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
			_unit = (group _caller) createUnit [_type, _position, [], 0, "FORM"];
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

			_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

			_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

			_unit execVM "ParamsPlus\Markers.sqf";

			if ((_BI_CP_loadouts_mtp isEqualTo 1) and (_BI_CP_loadouts_wl isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

			_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

			_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

			_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

			_unit allowDamage true;

			units group _caller doFollow leader group _caller;
		};
	};
	case civilian: {
		
	_reUnits_c = ["C_Orestes","C_man_p_fugitive_F_euro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_p_beggar_F_afro","C_man_w_worker_F","C_man_polo_2_F"];
	_unitrank = ["captain","captain","lieutenant","sergeant","sergeant","corporal","corporal"];

		for "_i" from 0 to count _reUnits_c -1 do {
			_type = _reUnits_c select _i;
			_rank = _unitrank select _i;
			_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
			_unit = (group _caller) createUnit [_type, _position, [], 0, "FORM"];
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
			
			_unit setUnitLoadout selectRandom ["I_engineer_F","I_soldier_mine_F","I_medic_F","I_soldier_F","I_Soldier_A_F","I_Soldier_LAT_F","I_Soldier_M_F","I_Soldier_AR_F","I_Soldier_TL_F","I_Soldier_SL_F"]; 

			[_unit, selectRandom ["I_engineer_F","I_soldier_mine_F","I_medic_F","I_soldier_F","I_Soldier_A_F","I_Soldier_LAT_F","I_Soldier_M_F","I_Soldier_AR_F","I_Soldier_TL_F","I_Soldier_SL_F"]] remoteExec ["setIdentity", 0, _unit];		
					
			_unit execVM "ParamsPlus\SettingsAdjustments.sqf";

			_unit execVM "ParamsPlus\UnlimitedAmmo.sqf";

			_unit execVM "ParamsPlus\Markers.sqf";

			if ((_BI_CP_loadouts_mtp isEqualTo 1) and (_BI_CP_loadouts_wl isEqualTo 1)) then {_unit setVariable ["LoadoutDone", true];};

			_unit addAction ["<t color='#00FFFF'>FirstAidKits And Magazines</t>",BON_RECRUIT_PATH+"FirstAidKitsAndMags.sqf",[],-100,false,true,""];

			_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],-100,false,true,""];

			_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";

			_unit allowDamage true;

			units group _caller doFollow leader group _caller;
		};
	};
};

