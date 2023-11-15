// "init.sqf" //

[playerSide, "HQ"] commandChat "Initiating v2023.11.10";

addMissionEventHandler ["EntityKilled", { 
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	removeAllActions _unit;
	_killer addRating 100;
  _killer addScore 100;
}];

if (isServer) then {
  addMissionEventHandler ["EntityKilled", { 
    params ["_killed", "_killer", "_instigator"];
    _killed setVariable ["LoadoutDone", nil];
  }];
  addMissionEventHandler ["EntityRespawned", { 
    params ["_newEntity", "_oldEntity"];
    _newEntity setUnitLoadout (_oldEntity getVariable "loadout");
  }];
  addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    if ((typeOf _entity isEqualTo "B_Medic_F") or (typeOf _entity isEqualTo "B_Soldier_LAT_F")) then {
    _entity execVM "SettingsAdjustments.sqf";
    _entity execVM "LoadoutAdjustments.sqf";
    _entity execVM "Regen_Health.sqf";
    [_entity] call fnc_addFirstAidKitsAndMags;};
  }];
	addMissionEventHandler ["EntityCreated", {
		params ["_entity"];
		if ((_entity isKindOf "CAR") OR (_entity isKindOf "TANK") OR (_entity isKindOf "AIR")) then {
			[_entity] execVM "ParamsPlus\vehicleMarker.sqf";
			[_entity] execVM "ParamsPlus\heliBombs.sqf";
			_entity setVehicleAmmo 1;
			_entity setFuel 1;
			_entity setAmmoCargo 1;
			_entity setRepairCargo 1;
			_entity setFuelCargo 1;
			_entity addEventHandler ["GetOut", {
				params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
				_unit setBehaviour "COMBAT";_unit allowDamage FALSE;
				[_unit,_vehicle] spawn {waitUntil {((_this select 0) distance (_this select 1)) > 20;}; (_this select 0) allowDamage TRUE;};
				if (isPlayer _unit) then {["<t color='#FFCC33' size='1.5'>20 METER SAFE AREA!<br />STAY CLOSE TO THE VEHICLE!</t>",0,.01,24,1] spawn BIS_fnc_dynamicText;
				titleText ['<t color=''#ffdd22'' size=''1.5''>20 METER SAFE AREA!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
				[_unit, "20 meter safe area around vehicle in effect!"] remoteExecCall ["commandChat", 0]};
			}];
		};	
	}];
	addMissionEventHandler ["EntityCreated", {
		params ["_entity"];
		if (_entity isKindOf "UAV") then {
			[_entity] execVM "ParamsPlus\vehicleMarker.sqf";
			[_entity] execVM "ParamsPlus\heliBombs.sqf";
			createVehicleCrew _entity;
		};	
	}];
 	addMissionEventHandler ["UAVCrewCreated", {
		params ["_uav", "_driver", "_gunner"];		
		hintSilent parseText format ["<t size = '1.5' color = '#FF0000'>UAV Type: %1</t><br/>Driver Type: %2<br/>Gunner Type: %3",typeOf _uav,typeOf _driver,typeOf _gunner];
	}];
};
inGameUISetEventHandler ["Action",
"
    private _cond = FALSE;
    _target = _this select 0;
    _caller = _this select 1;
    _action = _this select 3;
    _priority = _this select 5;
    _showwindow = _this select 6;
    _hide = _this select 9;
    if (_action == 'HealSoldierSelf') then
    {
        if (side _target != side _caller) then
        {
          _priority = 0;
          _showwindow = false;
          _hide = false;
          _cond = TRUE;
        };
    };
    _cond;
"];

fnc_RemoveActions = {
	params ["_unit","_actionId"];
		_actions = actionIDs _unit;
		_array = [];
		for [{_i= (count _actions)-1},{_i>-1},{_i=_i-1}] do {
			_params = _unit actionParams (_actions select _i);
			_array = _array + [(_params select 0)];
		};
		if (_actionId in _array) then {
			_filteredArray = _array select { _x isEqualTo _actionId };
		for "_i" from count _filteredArray - 1 to 1 step -1 do {
      [_unit,_filteredArray select _i] remoteExec ["BIS_fnc_holdActionRemove", 0];
    };
	};
};
				
fnc_RemoveAction = {
	params ["_unit"];

	_actionID = _unit getVariable [ "RemoveAction", -1 ];

	if ( _actionID > -1 ) then {
		[ _unit, _actionID select 0 ] call BIS_fnc_holdActionRemove;
	};
};

fnc_hackingCompleted = {
	[] spawn
	{
		// EXECUTE IN EDEN EDITOR OR EDITOR PREVIEW!
		disableSerialization;

		private _display = findDisplay 313 createDisplay "RscDisplayEmpty";

		private _edit = _display ctrlCreate ["RscEdit", 645];
		_edit ctrlSetPosition [safezoneX + 50 * pixelW, safezoneY + 50 * pixelH, safezoneW - 500 * pixelW, 50 * pixelH];
		_edit ctrlSetBackgroundColor [0,0,0,1];
		_edit ctrlCommit 0;

		private _status = _display ctrlCreate ["RscEdit", 1337];
		_status ctrlSetPosition [safezoneX + safezoneW - 400 * pixelW, safezoneY + 50 * pixelH, 350 * pixelW, 50 * pixelH];
		_status ctrlSetBackgroundColor [0,0,0,1];
		_status ctrlCommit 0;
		_status ctrlEnable false;

		private _tv = _display ctrlCreate ["RscTreeSearch", -1];
		_tv ctrlSetFont "EtelkaMonospacePro";
		_tv ctrlSetFontHeight 0.05;
		_tv ctrlSetPosition [safezoneX + 50 * pixelW, safezoneY + 125 * pixelH, safezoneW - 100 * pixelW, safeZoneH - 175 * pixelH];
		_tv ctrlSetBackgroundColor [0,0,0,1];
		_tv ctrlCommit 0;

		_tv ctrlAddEventHandler ["treeSelChanged",
		{
			params ["_ctrlTV", "_selectionPath"];
			copyToClipboard (_ctrlTV tvText _selectionPath);
			playSound ("RscDisplayCurator_ping" + selectRandom ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"]);
			(ctrlParent _ctrlTv) displayCtrl 1337 ctrlSetText "Path copied to clipboard!";
		}];

		private _counter = 0;
		{
			private _files = addonFiles [_x # 0, ".paa"];
			{
				if ("\actions" in _x || "\holdaction" in _x) then
				{
					_counter = _counter + 1;
					_status ctrlSetText format ["%1 textures found.", _counter];
					private _index = _tv tvAdd [[], _x];
					_tv tvSetPicture [[_index], _x];
				};
			} forEach _files;
		} foreach allAddonsInfo;

		_tv tvSortall [[], false];
	};	
};

fnc_removePrimaryWeaponAndMags =
{
	params ["_soldier"];
	_compatibleMags = [];
	{
		_mags = [];
		hint str _mags;
		if ( _x != "this" ) then {
			_mags = getArray( configFile >> "CfgWeapons" >> primaryWeapon _soldier >> _x >> "magazines" ); 
		}else{
			_mags = getArray( configFile >> "CfgWeapons" >> primaryWeapon _soldier >> "magazines" ); 
		};
		_compatibleMags = _compatibleMags + _mags;
	}forEach getArray( configFile >> "CfgWeapons" >> primaryWeapon _soldier >> "muzzles" );
	{
		if ( _x in _compatibleMags ) then {
			_soldier removeMagazine _x;
		}
	} forEach magazines _soldier;
	_soldier removeWeapon primaryWeapon _soldier;
	_soldier groupRadio "SentSupportReady";
};
fnc_addFirstAidKitsAndMags =
{
	params ["_unit"];
	if ({_x == "FirstAidKit"} count items _unit < 4) then {
		_cnta = {_x == "FirstAidKit"} count (items _unit);
		for [{_i= 4 - _cnta},{_i>0},{_i=_i-1}] do {
			_unit addItem "FirstAidKit";
		};				
	};	
	if ({_x == "30Rnd_65x39_caseless_black_mag"} count magazines _unit < 8) then {
		_cntb = {_x == "30Rnd_65x39_caseless_black_mag"} count (magazines _unit);
		for [{_i= 8 - _cntb},{_i>0},{_i=_i-1}] do {
			_unit addMagazine "30Rnd_65x39_caseless_black_mag";
		};				
	};
	if ({_x == "3Rnd_HE_Grenade_shell"} count magazines _unit < 8) then {
		_cntc = {_x == "3Rnd_HE_Grenade_shell"} count (magazines _unit);
		for [{_i= 8 - _cntc},{_i>0},{_i=_i-1}] do {
			_unit addMagazine "3Rnd_HE_Grenade_shell";
		};				
	};	
	[_unit, 1] remoteExec ["setVehicleAmmo",groupOwner (group _unit)];
	if (needReload _unit == 1) then { reload _unit; _unit groupRadio "SentSupportReady"; };
};

if (("BI_CP_loadouts_mtp" call BIS_fnc_getParamValue isEqualTo 1) && ("BI_CP_loadouts_wl" call BIS_fnc_getParamValue isEqualTo 1)) exitWith {

	for "_i" from 0 to count (if ismultiplayer then {playableunits} else {switchableunits}) - 1 do {

		private _unit = (if ismultiplayer then {playableunits} else {switchableunits}) select _i;
		
		_unit setVariable ["loadout", getUnitLoadout _unit];

		_unit setVariable ["LoadoutDone", true];

		if (isPlayer _unit) then {

			[playerSide, "HQ"] commandChat format ["%1, Loadouts Done!",name _unit];

			[playerSide, "HQ"] commandChat format ["%1, GetUnitLoadout Saved!",name _unit];
		};
	};  
};

if (hasInterface) then { 
  [] spawn { 
    waitUntil { !isNil "BIS_CP_initDone" && { [ "BIS_CP_taskExfil" ] call BIS_fnc_taskExists } };
		{if (!( isPlayer _x ) and (_x in (units group player))) then {_x addAction ["<t color='#00FFFF'>Dismiss</t>","dismiss.sqf",[],100,false,true,""];}} forEach (if ismultiplayer then {playableunits} else {switchableunits});
	};   
}; 

_moveExtractionPos = [] spawn {

	waitUntil { !isNil "BIS_CP_initDone" && { [ "BIS_CP_taskExfil" ] call BIS_fnc_taskExists } };

	_exfil = switch (playerSide) do {
		case west: 			{exfilWest};
		case east: 			{exfilEast};
		case resistance: 	{exfilGuer};
		case civilian:		{exfilCivil};
	};

  if (("BI_CP_exFil_Location" call BIS_fnc_getParamValue) isEqualTo 2) then {
    BIS_CP_exfilPos = position _exfil;
    [ "BIS_CP_taskExfil", BIS_CP_exfilPos ] call BIS_fnc_taskSetDestination;
  };
  
	_hpad = switch (playerSide) do {
		case west: 			{hpad};
		case east: 			{hpad2};
		case resistance: 	{hpad3};
		case civilian:		{hpad5};
	};

	_hpad setPos (BIS_CP_exfilPos findEmptyPosition [10,100,"B_Heli_Transport_03_F"]);
	_hpad setDir getDir (nearestBuilding BIS_CP_exfilPos);
	_hpadmrkr = createMarkerLocal ["hpad",position _hpad];
	_hpadmrkr setMarkerShapeLocal "ICON";
	_hpadmrkr setMarkerTypeLocal "c_air";

	_pads = [];

	_pads = [0,0,0] nearobjects ["HeliH",(worldSize / 2) * 1.4142];

	for "_i" from 0 to count _pads - 1 do
	{
		_pad = _pads select _i;
		_markername = "hpad" + str _i;
		_markerstr = createMarkerLocal [_markername,position _pad];
		_markerstr setMarkerShapeLocal "ICON";
		_markerstr setMarkerTypeLocal "c_air";
	};

	/*
	BIS_CP_exfilPos = 
	
	[ "BIS_CP_taskExfil", BIS_CP_exfilPos ] call BIS_fnc_taskSetDestination;
	*/
};
