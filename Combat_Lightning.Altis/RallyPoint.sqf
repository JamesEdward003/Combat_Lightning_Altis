/////--"RallyPoint.sqf--/////
if !(("PRallyPoint" call BIS_fnc_getParamValue) isEqualTo 2) exitWith {};
//(_this select 0) addEventHandler ["Respawn",{(_this select 0) execVM "RallyPoint.sqf"}];
_unit = _this;
_actions = actionIDs _unit;
_array = [];

_unit addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	_unit execVM "RallyPoint.sqf";
}];
//hint format ["%1",[ configFile >> "CfgVehicles" >> "I_UAV_01_F", true ] call BIS_fnc_returnParents];
_unit addEventHandler ["WeaponAssembled", { 
	params ["_unit", "_staticWeapon"];
	_uavname = switch (playerSide) do
		{
			case WEST: 			{uav_west};
			case EAST: 			{uav_east};
			case RESISTANCE: 	{uav_guer};
			case CIVILIAN: 		{uav_civ};
		};
	_mag = switch (playerSide) do
		{
			case WEST: 			{"1Rnd_Leaflets_West_F"};
			case EAST: 			{"1Rnd_Leaflets_East_F"};
			case RESISTANCE: 	{"1Rnd_Leaflets_Guer_F"};
			case CIVILIAN: 		{"1Rnd_Leaflets_Civ_F"};
		};

	_UAVnetID = _staticWeapon call BIS_fnc_netId;
	missionNameSpace setVariable [format ["str %1",_uavname],_UAVnetID,true];

	_staticWeapon setCaptive true;
	_staticWeapon allowDamage false; 
	if (_staticWeapon isKindOf "UAV_01_Base_F") then {
		_staticWeapon addMagazine _mag;
		_staticWeapon addWeapon "Bomb_Leaflets";
		_staticWeapon addeventhandler ["fired", {(_this select 0) setvehicleammo 1}];
		_unit addAction ["<t color='#00FFFF'>Deploy Leaflets</t>", {
			params ["_target", "_caller", "_actionId", "_arguments"];
			(_arguments select 0) fire "Bomb_Leaflets";
			[(_arguments select 0), "Bomb_Leaflets"] remoteExec ["fire", (_arguments select 0)];
		},
	  	[_staticWeapon],
	  	10,
	  	false,
	  	true,
	  	"",
	  	"(alive _target)",
	  	-1,
	  	true,
	  	"",
	  	""];
		_unit addAction ["<t color='#00FFFF'>Deploy Bombs</t>", {
			params ["_target", "_caller", "_actionId", "_arguments"];
			(_arguments select 0) fire "Bomb_Leaflets";
			[(_arguments select 0), "ParamsPlus\heliBombs.sqf"] remoteExec ["execVM", (_arguments select 0)];
		},
	  	[_staticWeapon],
	  	10,
	  	false,
	  	true,
	  	"",
	  	"(alive _target)",
	  	-1,
	  	true,
	  	"",
	  	""];
		}; 
	}];

for [{_i= (count _actions)-1},{_i>-1},{_i=_i-1}] do {
	_params = _unit actionParams (_actions select _i);
	_array = _array + [(_params select 0)];
	};

if !(("<t color='#00FFFF'>Deploy Rally Point</t>") in _array) then {

Rally_Point = _unit addAction ["<t color='#00FFFF'>Deploy Rally Point</t>", {(_this select 0) call
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
			case WEST: 			{"RallyPoint_West"};
			case EAST: 			{"RallyPoint_East"};
			case RESISTANCE: 	{"RallyPoint_Guer"};
			case CIVILIAN: 		{"RallyPoint_Civ"};
		};
	_uavbpclass = switch (playerSide) do 
		{
			case WEST: 			{"B_UAV_01_backpack_F"};
			case EAST: 			{"O_UAV_01_backpack_F"};
			case RESISTANCE: 	{"I_UAV_01_backpack_F"};
			case CIVILIAN: 		{"C_IDAP_UAV_01_backpack_F"};
		};
	_uavbpmrkr = switch (playerSide) do // UAV_01_Base_F 
		{
			case WEST: 			{"b_uav"};
			case EAST: 			{"o_uav"};
			case RESISTANCE: 	{"n_uav"};
			case CIVILIAN: 		{"loc_Box"};
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
				_uavbpid = missionNamespace getVariable _rallyvar;
				_uavbpobj = _uavbpid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _uavbpobj;
		 		deleteMarker (str _uavbpid);
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
				_uavbpid = missionNamespace getVariable _rallyvar;
				_uavbpobj = _uavbpid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _uavbpobj;
		 		deleteMarker (str _uavbpid);
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
				_uavbpid = missionNamespace getVariable _rallyvar;
				_uavbpobj = _uavbpid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _uavbpobj;
		 		deleteMarker (str _uavbpid);
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
				_uavbpid = missionNamespace getVariable _rallyvar;
				_uavbpobj = _uavbpid call BIS_fnc_objectFromNetId;
		 		deleteVehicle _uavbpobj;
		 		deleteMarker (str _uavbpid);
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
	_uavbpname = "GroundWeaponHolder_Scripted" createVehicle _location;
	_uavbpid = _uavbpname call BIS_fnc_netId;
	missionNamespace setVariable [_rallyvar,_uavbpid];
	_uavbpname setVehiclePosition [_this modelToWorld [0,2,_height], [], 0, "CAN_COLLIDE"];
	uisleep 0.1;
	_uavbpname addBackpackCargoGlobal [_uavbpclass, 1];
	uisleep 0.1;

	_uavbpname addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		{deleteVehicle _x} forEach nearestObjects [_unit, ["logic","HeliH","Weapon_Bag_Base","GroundWeaponHolder"], 10];
		_objectarray = position _unit nearObjects ["GroundWeaponHolder_Scripted",10];
		{deleteVehicle _x} forEach _objectarray;
		{deleteMarker _x} forEach allMapMarkers select {(getMarkerType _x == "respawn_inf") inArea [getPos _unit, 10, 10, 0, false, 100];}; 
		{deleteMarker _x} forEach allMapMarkers select {(getMarkerType _x == _uavbpmrkr) inArea [getPos _unit, 10, 10, 0, false, 100];}; 
		format ["%1 = nil",_uavbpname];
		_killer addRating 100;
	}];
	_marker = createMarkerLocal [(str _uavbpid),position _uavbpname]; 
	_marker setMarkerShapeLocal "ICON"; 
	_marker setMarkerTypeLocal _uavbpmrkr;
	//[_uavbpname] execVM "bon_recruit_units\open_dialog.sqf";

//	copyToClipboard format ["%1,%2,%3,%4",(str _uavbpid),position _uavbpname,_rallyvar,missionNamespace getVariable _rallyvar]; "0:1",[8260.49,3454.93,0],RallyPoint_West,0:1

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

	[playerSide, "HQ"] commandChat "RallyPoint Enabled!";

};
