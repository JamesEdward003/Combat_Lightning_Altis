// "onGroupIcon.sqf" //
_BI_CP_GroupIconOver = "BI_CP_GroupIconOver" call BIS_fnc_getParamValue;
if (_BI_CP_GroupIconOver isEqualTo 1) exitWith {};
if (!isMultiplayer) exitWith {};
fnc_GroupIconOver = {
  _BI_CP_GroupIconOver = "BI_CP_GroupIconOver" call BIS_fnc_getParamValue;
  if (_BI_CP_GroupIconOver isEqualTo 1) exitWith {};
  setGroupIconsVisible[true,false];
  setGroupIconsSelectable true;
  BIS_marta_mainscope setVariable ["duration", 60];
  BIS_marta_mainscope setVariable ["minSize", 1];
  BIS_marta_mainscope setVariable ["delay", 0.5];
  player setVariable [ "MARTA_REVEAL", allGroups];
  getUnitPositionId = {
    private ["_vvn", "_str"];
    _str0 ="";
    _veh = vehicle _this;
    for "_i" from 0 to count crew _veh - 1 do {
      _vvn = vehicleVarName (crew _veh select _i);
      (crew _veh select _i) setVehicleVarName "";
      _str = str (crew _veh select _i);
      (crew _veh select _i) setVehicleVarName _vvn;
      _str0 = _str0 +" "+(_str select [(_str find ":") + 1]);
      _str0
    };
  };
  0 = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", "
    _map = _this select 0;
    {
      if (!isnil {_x getVariable 'GroupDisplay'}) then {
        {
          _map drawIcon [
            getText (configfile >> 'CfgVehicles' >> typeOf vehicle _x >> 'icon'),
            (getGroupIconParams group _x) select 0,
            getPosVisual _x,
            18,
            18,
            getDirVisual vehicle _x,
            _x call getUnitPositionId,
            0.7,
            0.03,
            'TahomaB',
            'right'
          ]
        } forEach (units _x select {_x == effectiveCommander vehicle _x});
      }
    } forEach allGroups
  "];
  addMissionEventHandler ["GroupIconOverEnter", {
    params [
      "_is3D", "_group", "_waypointId",
      "_posX", "_posY",
      "_shift", "_control", "_alt"
     ];
    _group setVariable ["GroupDisplay",true];
  }];
  addMissionEventHandler ["GroupIconOverLeave", {
    params [
      "_is3D", "_group", "_waypointId",
      "_posX", "_posY",
      "_shift", "_control", "_alt"
    ];
    if (isNil {_group getVariable "grpPermDisplay"}) then {
     _group setVariable ["GroupDisplay",nil];
    };
  }];
  addMissionEventHandler ["GroupIconClick", {
    params [
      "_is3D", "_group", "_waypointId",
      "_mouseButton", "_posX", "_posY",
      "_shift", "_control", "_alt"
    ];
    if (_mouseButton == 0) then {
      _group setVariable ["GroupDisplay",true];
      _group setVariable ["grpPermDisplay",true]
    } else {
        _group setVariable ["GroupDisplay",nil];
        _group setVariable ["grpPermDisplay",nil]
    };
  }];
};
[] spawn fnc_GroupIconOver;

onGroupIconClick  { 

  _is3D = _this select 0;
  _group = _this select 1;
  _wpID = _this select 2;
  _RMB = _this select 3;
  _posx = _this select 4;
  _posy = _this select 5;
  _shift = _this select 6;
  _ctrl = _this select 7;
  _alt = _this select 8;

  if (!_is3D) then {
    (vehicle ((units _group) select 0)) cameraEffect ["FixedWithZoom","LEFT TOP"];if (daytime >= 19 || daytime <= 5) then {showCinemaBorder false;camUseNVG true} else {showCinemaBorder true;camUseNVG false};
    if (_RMB == 1) then { (vehicle ((units _group) select 0)) cameraEffect ["FixedWithZoom","FRONT TOP"];if (daytime >= 19 || daytime <= 5) then {showCinemaBorder false;camUseNVG true} else {showCinemaBorder true;camUseNVG false}; };
    //titleText [format ["GROUP: %1\nLEADER GROUP: %2",_group,leader _group],"PLAIN DOWN"];    
  };
};


