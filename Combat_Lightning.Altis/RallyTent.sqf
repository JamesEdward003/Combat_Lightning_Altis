/////--"RallyTent.sqf"--/////
_PRallyTent = "PRallyTent" call BIS_fnc_getParamValue;
if !(_PRallyTent isEqualTo 2) exitWith {};
//(_this select 0) addEventHandler ["Respawn",{(_this select 0) execVM "RallyTent.sqf"}];
_unit = _this;
_actions = actionIDs _unit;
_array = [];

_unit addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	_unit execVM "RallyTent.sqf";
}];

_unit addEventHandler ["WeaponAssembled", { (_this select 1) setCaptive true;(_this select 1) allowDamage false }];

for [{_i= (count _actions)-1},{_i>-1},{_i=_i-1}] do {
	_params = _unit actionParams (_actions select _i);
	_array = _array + [(_params select 0)];
	};

if !(("<t color='#00FFFF'>Deploy Rally Tent</t>") in _array) then {

Rally_Tent = _unit addAction ["<t color='#00FFFF'>Deploy Rally Tent</t>", {(_this select 0) call
{

	_height = ((getPosASLW _this) select 2);

	_mrkrColor = switch (playerSide) do 
		{
			case west: 			{"ColorBLUFOR"};
			case east: 			{"ColorOPFOR"};
			case resistance: 	{"ColorIndependent"};
			case civilian: 		{"ColorCivilian"};
		};
	_rallyvar = switch (playerSide) do 
		{
			case WEST: 			{"RallyTent_West"};
			case EAST: 			{"RallyTent_East"};
			case RESISTANCE: 	{"RallyTent_Guer"};
			case CIVILIAN: 		{"RallyTent_Civ"};
		};
	_tentclass = switch (playerSide) do  //		"Camping_base_F" Land_TentA_F  Land_TentDome_F  Respawn_TentDome_F  Patrol_Respawn_bag_F
		{
			case WEST: 			{"Respawn_TentDome_F"};
			case EAST: 			{"Respawn_TentA_F"};
			case RESISTANCE: 	{"Patrol_Respawn_bag_F"};
			case CIVILIAN: 		{"Respawn_TentA_F"};
		};
	_tentmrkr = switch (playerSide) do 
		{
			case WEST: 			{"b_uav"};
			case EAST: 			{"o_uav"};
			case RESISTANCE: 	{"n_uav"};
			case CIVILIAN: 		{"loc_Box"};
		};
	_sbvar = switch (playerSide) do 
		{
			case WEST: 			{"SleepBag_West"};
			case EAST: 			{"SleepBag_East"};
			case RESISTANCE: 	{"SleepBag_Guer"};
			case CIVILIAN: 		{"SleepBag_Civ"};
		};
	_sbclass = switch (playerSide) do // 	"Camping_base_F" Respawn_Sleeping_bag_F  Respawn_Sleeping_bag_brown_F  Respawn_Sleeping_bag_blue_F
		{
			case WEST: 			{"Respawn_Sleeping_bag_F"};
			case EAST: 			{"Respawn_Sleeping_bag_brown_F"};
			case RESISTANCE: 	{"Respawn_Sleeping_bag_brown_F"};
			case CIVILIAN: 		{"Respawn_Sleeping_bag_blue_F"};
		};
	_respmrkr = switch (playerSide) do 
		{
			case WEST: 			{"respawn_west"};
			case EAST: 			{"respawn_east"};
			case RESISTANCE: 	{"respawn_guerrila"};
			case CIVILIAN: 		{"respawn_civilian"};
		};
	switch (playerSide) do {		
		case WEST: {
		 	_pos = _this modelToWorld [0,3,_height];
		 	_posy = _this modelToWorld [4,2,_height];
		 	_posz = _this modelToWorld [6,2,_height];
		 	if (!isNil {missionNamespace getVariable _rallyvar}) then 
		 	{
		 		deleteVehicle respawn_west_helipad;
				deleteVehicle respawn_west;
				deleteMarker "respawn_west";
				_tentid = missionNamespace getVariable _rallyvar;
				_tentobj = _tentid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _tentobj;
		 		deleteMarker (str _tentid);
		 		_sbid = missionNamespace getVariable _sbvar;
				_sbobj = _sbid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _sbobj;
	 		};  
			_logicGroup = createGroup (playerSide);
        	respawn_west = _logicGroup createUnit ["ModuleRespawnPosition_F",_posy, [], 0, "FORM"];
        	respawn_west_helipad = "Land_HelipadEmpty_F" createVehicle _posz;        
        	createMarkerLocal ["respawn_west", position respawn_west];
        	"respawn_west" setMarkerTypeLocal "respawn_inf";
        	"respawn_west" setMarkerShapeLocal "Icon";
        	"respawn_west" setMarkerTextLocal " respawn_west";
        	"respawn_west" setMarkerSizeLocal [1,1];
        	"respawn_west" setMarkerColorLocal _mrkrColor; 
	        	
	        systemChat "Your rally has been teleported.";
	            
	        gridPos = mapGridPosition getPos respawn_west;
	        publicVariable "gridPos";
	        parseText format ["<t size='1.2' align='center' color='#00FFFF'>Rally moved to grid %1", gridPos] remoteExec ["hintSilent",2];
		};
		case EAST: {
		 	_pos = _this modelToWorld [0,3,_height];
		 	_posy = _this modelToWorld [4,2,_height];
		 	_posz = _this modelToWorld [6,2,_height];
		 	if (!isNil {missionNamespace getVariable _rallyvar}) then 
		 	{
		 		deleteVehicle respawn_east_helipad;
				deleteVehicle respawn_east;
				deleteMarker "respawn_east";
				_tentid = missionNamespace getVariable _rallyvar;
				_tentobj = _tentid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _tentobj;
		 		deleteMarker (str _tentid);
		 		_sbid = missionNamespace getVariable _sbvar;
				_sbobj = _sbid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _sbobj;
	 		};
			_logicGroup = createGroup (playerSide);
        	respawn_east = _logicGroup createUnit ["ModuleRespawnPosition_F",_posy, [], 0, "FORM"];
        	respawn_east_helipad = "Land_HelipadEmpty_F" createVehicle _posz;         
        	createMarkerLocal ["respawn_east", position respawn_east];
        	"respawn_east" setMarkerTypeLocal "respawn_inf";
        	"respawn_east" setMarkerShapeLocal "Icon";
        	"respawn_east" setMarkerTextLocal " respawn_east";
        	"respawn_east" setMarkerSizeLocal [1,1];
        	"respawn_east" setMarkerColorLocal _mrkrColor; 
	        	
	        systemChat "Your rally has been teleported.";
	            
	        gridPos = mapGridPosition getPos respawn_east;
	        publicVariable "gridPos";
	        parseText format ["<t size='1.2' align='center' color='#00FFFF'>Rally moved to grid %1", gridPos] remoteExec ["hintSilent",2];
		};
		case RESISTANCE: {
		 	_pos = _this modelToWorld [0,3,_height];
		 	_posy = _this modelToWorld [4,2,_height];
		 	_posz = _this modelToWorld [6,2,_height];
		 	if (!isNil {missionNamespace getVariable _rallyvar}) then 
		 	{
		 		deleteVehicle respawn_guerrila_helipad;
				deleteVehicle respawn_guerrila;
				deleteMarker "respawn_guerrila";
				_tentid = missionNamespace getVariable _rallyvar;
				_tentobj = _tentid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _tentobj;
		 		deleteMarker (str _tentid);
		 		_sbid = missionNamespace getVariable _sbvar;
				_sbobj = _sbid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _sbobj;
	 		};
			_logicGroup = createGroup (playerSide);
        	respawn_guerrila = _logicGroup createUnit ["ModuleRespawnPosition_F",_posy, [], 0, "FORM"];
        	respawn_guerrila_helipad = "Land_HelipadEmpty_F" createVehicle _posz;         
        	createMarkerLocal ["respawn_guerrila", position respawn_guerrila];
        	"respawn_guerrila" setMarkerTypeLocal "respawn_inf";
        	"respawn_guerrila" setMarkerShapeLocal "Icon";
        	"respawn_guerrila" setMarkerTextLocal " respawn_guerrila";
        	"respawn_guerrila" setMarkerSizeLocal [1,1];
        	"respawn_guerrila" setMarkerColorLocal _mrkrColor; 
	        	
	        systemChat "Your rally has been teleported.";
	            
	        gridPos = mapGridPosition getPos respawn_guerrila;
	        publicVariable "gridPos";
	        parseText format ["<t size='1.2' align='center' color='#00FFFF'>Rally moved to grid %1", gridPos] remoteExec ["hintSilent",2];
		};	
		case CIVILIAN: {
		 	_pos = _this modelToWorld [0,3,_height];
		 	_posy = _this modelToWorld [4,2,_height];
		 	_posz = _this modelToWorld [6,2,_height];
		 	if (!isNil {missionNamespace getVariable _rallyvar}) then 
		 	{
		 		deleteVehicle respawn_civilian_helipad;
				deleteVehicle respawn_civilian;
				deleteMarker "respawn_civilian";
				_tentid = missionNamespace getVariable _rallyvar;
				_tentobj = _tentid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _tentobj;
		 		deleteMarker (str _tentid);
		 		_sbid = missionNamespace getVariable _sbvar;
				_sbobj = _sbid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _sbobj;
	 		};
			_logicGroup = createGroup (playerSide);
        	respawn_civilian = _logicGroup createUnit ["ModuleRespawnPosition_F",_posy, [], 0, "FORM"];
        	respawn_civilian_helipad = "Land_HelipadEmpty_F" createVehicle _posz;         
        	createMarkerLocal ["respawn_civilian", position respawn_civilian];
        	"respawn_civilian" setMarkerTypeLocal "respawn_inf";
        	"respawn_civilian" setMarkerShapeLocal "Icon";
        	"respawn_civilian" setMarkerTextLocal " respawn_civilian";
        	"respawn_civilian" setMarkerSizeLocal [1,1];
        	"respawn_civilian" setMarkerColorLocal _mrkrColor; 
	        	
	        systemChat "Your rally has been teleported.";
	            
	        gridPos = mapGridPosition getPos respawn_civilian;
	        publicVariable "gridPos";
	        parseText format ["<t size='1.2' align='center' color='#00FFFF'>Rally moved to grid %1", gridPos] remoteExec ["hintSilent",2];
		};
	};

	_location = _this modelToWorld [0,2,_height];
	_this playMove "AmovPknlMstpSrasWrflDnon_AinvPknlMstpSrasWrflDnon_Putdown";
	uisleep 0.5;
	_tentname = _tentclass createVehicle _location;
	_tentid = _tentname call BIS_fnc_netId;
	missionNamespace setVariable [_rallyvar,_tentid];
	_tentname setVehiclePosition [_this modelToWorld [0,2,_height], [], 0, "CAN_COLLIDE"];
	_tentname enableSimulation false;

	_sbname = _sbclass createVehicle _location;
	_sbid = _sbname call BIS_fnc_netId;
	missionNamespace setVariable [_sbvar,_sbid];
	_sbname setVehiclePosition [_this modelToWorld [0,2,_height], [], 0, "CAN_COLLIDE"];
	//_sbname enableSimulation false;

	_sbname addAction ["Wait 2 Hours", {_date = date; _date set [3, (_date select 3) + 2]; setDate _date;}, [], 0, false, true, "", "_this distance _target < 10"];

	_sbname addAction ["Sleep 8 Hours", {_date = date; _date set [3, (_date select 3) + 8]; setDate _date;}, [], 0, false, true, "", "_this distance _target < 10"];

	_sbname addAction ["Night Vision-Silencers", "LoadoutAdjustments_Group.sqf", [], 0, false, true, "", "_this distance _target < 10"];

	[_this,_tentname] spawn {
		private ["_unit","_tentname","_Damage_EH1"];
		params ["_unit","_tentname"];
		_Damage_EH1 = { 
		private ["_unit","_tentname","_Damage_EH1"];
		params ["_unit","_tentname"];
		_unit = _this select 0;
		_tentname = _this select 1;
		scopeName "main";
	 	while {alive _tentname} do {
	      	scopeName "loop1";
	      	getDammage _tentname;
	      	while {((getDammage _tentname) > .1)} do {
	         	scopeName "loop2";
				parsetext format ["<t size='0.85' align='left'>Owner: </t><t size='0.85' color='#00bbff' align='left'>%3</t><br/><t size='0.85' align='left'>Type: </t><t size='0.85' color='#00bbff' align='left'> %1</t><br/><t size='0.85' align='left'>Damage: </t><t size='0.85' color='#00bbff' align='left'> %2</t>", typeOf _tentname, damage _tentname,name _unit] remoteExec ["hintSilent",2];
	          	if ((getDammage _tentname) > .99) then {breakTo "main"}; // Breaks all scopes and return to "main"
	          	if ((getDammage _tentname) < .1) then {breakOut  "loop2"}; // Breaks scope named "loop2"
	      	sleep  1; };
	  	sleep  1; }; 
		};
		[_unit,_tentname] call _Damage_EH1;
	};
	[_this,_sbname] spawn {
		private ["_unit","_sbname","_Damage_EH2"];
		params ["_unit","_sbname"];
		_Damage_EH2 = { 
		private ["_unit","_sbname","_Damage_EH2"];
		params ["_unit","_sbname"];
		_unit = _this select 0;
		_sbname = _this select 1;
		scopeName "main";
	 	while {alive _sbname} do {
	      	scopeName "loop1";
	      	getDammage _sbname;
	      	while {((getDammage _sbname) > .1)} do {
	         	scopeName "loop2";
				parsetext format ["<t size='0.85' align='left'>Owner: </t><t size='0.85' color='#00bbff' align='left'>%3</t><br/><t size='0.85' align='left'>Type: </t><t size='0.85' color='#00bbff' align='left'> %1</t><br/><t size='0.85' align='left'>Damage: </t><t size='0.85' color='#00bbff' align='left'> %2</t>", typeOf _sbname, damage _sbname,name _unit] remoteExec ["hintSilent",2];
	          	if ((getDammage _sbname) > .99) then {breakTo "main"}; // Breaks all scopes and return to "main"
	          	if ((getDammage _sbname) < .1) then {breakOut  "loop2"}; // Breaks scope named "loop2"
	      	sleep  1; };
	  	sleep  1; }; 
		};
		[_unit,_sbname] call _Damage_EH2;
	};
	
//	_this action ['AddBag', (nearestObject [_this, 'GroundWeaponHolder']), typeOf firstBackpack (nearestObject [_this, 'GroundWeaponHolder'])];

//	_this addAction ["<t color='#00FFFF'>"AddBag"</t>", {(_this select 0) action ["AddBag", (nearestObject [_this, "GroundWeaponHolder"]), typeOf firstBackpack (nearestObject [_this, "WeaponHolder"])];,"",10,false,true,"","_this distance _target<10"];

//	_this addAction ["<t color='#FF0000'>Put on Pack</t>","params ['_target','_caller']; _target action ['AddBag', (nearestObject [_target, 'WeaponHolder']), typeOf firstBackpack (nearestObject [_target, 'WeaponHolder'])];","",10,true,true,"",""];

//	_this addAction ["<t color='#40e0d0'>Take Pack</t>","params ['_target','_caller']; 

	_tentname addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		{deleteVehicle _x} forEach nearestObjects [_unit, ["logic","HeliH","Camping_base_F","GroundWeaponHolder"], 10];
		{deleteMarker _x} forEach allMapMarkers select {(getMarkerType _x == "respawn_inf") inArea [getPos _unit, 10, 10, 0, false, 100];}; 
		{deleteMarker _x} forEach allMapMarkers select {(getMarkerType _x == _tentmrkr) inArea [getPos _unit, 10, 10, 0, false, 100];}; 
		_killer addRating 100;
	}];
	_sbname addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		{deleteVehicle _x} forEach nearestObjects [_unit, ["logic","HeliH","Camping_base_F","GroundWeaponHolder"], 10];
		{deleteMarker _x} forEach allMapMarkers select {(getMarkerType _x == "respawn_inf") inArea [getPos _unit, 10, 10, 0, false, 100];}; 
		{deleteMarker _x} forEach allMapMarkers select {(getMarkerType _x == _tentmrkr) inArea [getPos _unit, 10, 10, 0, false, 100];}; 
		_killer addRating 100;
	}];
	_marker = createMarkerLocal [(str _tentid),position _tentname]; 
	_marker setMarkerShapeLocal "ICON"; 
	_marker setMarkerTypeLocal _tentmrkr;

	_tentname addAction ["<t color='#40e0d0'>Recruit Units</t>","bon_recruit_units\open_dialog.sqf",[],10,false,true,"","_this distance _target<10"];

	_terminalclass = switch (playerSide) do 
		{
			case WEST: 			{"B_UavTerminal"};
			case EAST: 			{"O_UavTerminal"};
			case RESISTANCE: 	{"I_UavTerminal"};
			case CIVILIAN: 		{"C_UavTerminal"};
		};

	if(!(_terminalclass in assignedItems _this)) then 
		{
			_this unassignitem "ItemGPS";
			_this removeItem "ItemGPS";

			_this addWeapon _terminalclass;
			_this assignItem _terminalclass;
			_this addItem _terminalclass;
		};

	switch true do 
		{
		case (_this == leader group _this && {(((units group _this) - [_this]) findIf {_x distance _this < 25}) != -1} && { allUnits findIf {side _x getFriend playerSide <0.6 && _x distance _this < 50} == -1}): {hintSilent parsetext format ["<t size='0.85' color='#00bbff' align='left'>Rallytent set with group members closer than 25m and NO enemies closer than 50m, </t><t size='0.85' color='#00bbff' align='left'> %1</t>", name _this];};
		case (_this == leader group _this && {(((units group _this) - [_this]) findIf {_x distance _this < 25}) != -1} && { allUnits findIf {side _x getFriend playerSide <0.6 && _x distance _this < 50} != -1}): {hintSilent parsetext format ["<t size='0.85' color='#00bbff' align='left'>Rallytent set with group members closer than 25m and enemies closer than 50m, </t><t size='0.85' color='#00bbff' align='left'> %1</t>", name _this];};
		case (_this == leader group _this && {(((units group _this) - [_this]) findIf {_x distance _this < 25}) == -1} && { allUnits findIf {side _x getFriend playerSide <0.6 && _x distance _this < 50} == -1}): {hintSilent parsetext format ["<t size='0.85' color='#00bbff' align='left'>Rallytent set with NO members closer than 25m and NO enemies closer than 50m, </t><t size='0.85' color='#00bbff' align='left'> %1</t>", name _this];};
		case (_this == leader group _this && {(((units group _this) - [_this]) findIf {_x distance _this < 25}) == -1} && { allUnits findIf {side _x getFriend playerSide <0.6 && _x distance _this < 50} != -1}): {hintSilent parsetext format ["<t size='0.85' color='#00bbff' align='left'>Rallytent set with NO members closer than 25m and enemies closer than 50m, </t><t size='0.85' color='#00bbff' align='left'> %1</t>", name _this];};
		};	
	};
	},
  	[],
  	10,
  	false,
  	true,
  	"",
  	"isNull objectParent _this",
  	-1,
  	true,
  	"",
  	""];
};

if (isPlayer _unit) then {

	[playerSide, "HQ"] commandChat "RallyTent Enabled!";

};

