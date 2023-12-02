////////   "ParamsPlus\heliDest.sqf"  ////////
private ["_heli"];
_heli = _this select 0;
_actions = actionIDs _heli;
_array = [];

hintSilent parseText format["<t size='1.25' color='#00FFFF'>Addaction Destination!</t>"];
PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Addaction Destination!";

for [{_i= (count _actions)-1},{_i>-1},{_i=_i-1}] do {
	_params = _heli actionParams (_actions select _i);
	_array = _array + [(_params select 0)];
	};

if !(("<t color='#00FFFF'>Map Destination</t>") in _array) then {

	_heli addAction ["<t color='#00FFFF'>Map Destination</t>", {
		private ["_heli","_caller","_airEnd","_airName","_mrkrcolor"];
		params ["_heli","_caller","_actionId","_arguments"];
		_heli = _this select 0;
		_caller = _this select 1;
		_actionID = _this select 2;
		_arguments = _this select 3;
		_searchRadius 	= 300;
		_sideUnit 		= side _caller;
		_friendlySide 	= _sideUnit;
		_neutralSide 	= CIVILIAN;
		_enemyAntiAir 	= if (_friendlySide isEqualTo "WEST") then { ["O_T_APC_Tracked_02_AA_ghex_F","O_APC_Tracked_02_AA_F","O_static_AA_F","O_Soldier_AA_F","O_soldierU_AA_F","O_T_Soldier_AA_F","O_A_soldier_AA_F"] } else { ["B_T_APC_Tracked_01_AA_F","B_APC_Tracked_01_AA_F","B_static_AA_F","B_T_Static_AA_F","B_soldier_AA_F","B_T_Soldier_AA_F","B_W_Soldier_AA_F"] };
		_sourcePoint 	= _caller;
		_randDir 		= getDir vehicle _sourcePoint - 180;
		_randDist 		= (random 100) + 1000;
		_airStart 		= [(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir)), 100];
		_randDir2 		= getDir vehicle _sourcePoint;
		_airEnd 		= [(getPos vehicle _sourcePoint select 0) + (_randDist * sin(_randDir2)), (getPos vehicle _sourcePoint select 1) + (_randDist * cos(_randDir2)), 60];
		uisleep 0.25;
		location = false;
		openmap [true,false];
		titleText["Map location", "PLAIN"];
		PAPABEAR=[_sideUnit,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name _caller];
		_heli vehicleChat "Map Your Destination!";
		_airName = switch (_sideUnit) do 
			{
				case west: 			{"Transport_West"};
				case east: 			{"Transport_East"};
				case resistance: 	{"Transport_Guer"};
				case civilian: 		{"Transport_Civ"};
			};
		_mrkrcolor = switch (_sideUnit) do 
			{
			     case west:			{"ColorBLUFOR"};
			     case east:			{"ColorOPFOR"};
			     case resistance:	{"ColorGUER"};
			     case civilian:		{"ColorCIV"};
			};
		onMapSingleClick "onMapSingleClick ''; mappos3 = _pos; location = true";		
		waitUntil {sleep 1; (!visiblemap OR location OR !alive _caller)};
			if (!location OR !alive _caller) exitWith {
			mappos3 = nil;
			PAPABEAR=[_sideUnit,"HQ"]; PAPABEAR SideChat "Map location canceled";
			hintSilent parseText format["<t size='1.25' color='#ff0000'>Map location canceled</t>"];
			titletext ["","plain"];
			};
			_SafePos = mappos3; //[mappos3, 0, 50, 10, 0, 20, 0] call BIS_fnc_findSafePos;
			_position = switch (true) do {

				case (_SafePos distance uss_freedom < 200): {getPosATL uss_freedom};

				case (_SafePos distance uss_freedom >= 200): {_SafePos};
			};
			if (!isNil {missionNamespace getVariable _airName}) then {
				deleteMarker _airName;
				deleteMarker format ["%1_Start",_airName];
				deleteMarker format ["%1_Dest",_airName];
				_RallyProfile = missionNamespace getVariable _airName;
				_CampFireID = _RallyProfile select 0;
				_CampFire = _CampFireID call BIS_fnc_objectFromNetId;
				deleteVehicle _CampFire;
				_heliPadID = _RallyProfile select 1;
				_heliPad = _heliPadID call BIS_fnc_objectFromNetId;
				deleteVehicle _heliPad;
				missionNamespace setVariable [_airName,nil];
				hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1 onward to new location!</t>", _airName];
			}; 
			_mrkr = createMarker [_airName,_position];
			_mrkr setMarkerType "mil_pickup";
			_mrkr setMarkerShapeLocal "Icon";
			_mrkr setMarkerTextLocal "LZ";
			_mrkr setMarkerSizeLocal [.75,.75];
			_mrkr setMarkerAlphaLocal .75;
			_mrkr setMarkerColorLocal _mrkrcolor;

		uisleep 2;
		titletext ["","plain",0.2];
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mapclick location successful</t>"];
		uisleep 2;
		hintSilent "";
		openmap [false,false];
		
		_CampFire = createVehicle ["Campfire_burning_F", _position, [], 0, "CAN_COLLIDE"];
		_CampFire setVehiclePosition [_position, [], 0, "CAN_COLLIDE"];
		_CampFireID = _CampFire call BIS_fnc_netId;
		_heliPad = createVehicle ["Land_HelipadCircle_F", _CampFire modelToWorld [0,-3,0], [], 0, "CAN_COLLIDE"];
		_heliPad setVehiclePosition [_CampFire modelToWorld [0,-3,0], [], 0, "CAN_COLLIDE"];
		_heliPadID = _heliPad call BIS_fnc_netId;
		missionNamespace setVariable [_airName,[_CampFireID,_heliPadID]];
		for "_i" from count waypoints (group _heli) - 1 to 0 step -1 do
		    {
		    deleteWaypoint [(group _heli), _i];
		};
		for "_i" from count waypoints (group _caller) - 1 to 0 step -1 do
		    {
		        deleteWaypoint [(group _caller), _i];
		};

		_enemyArray = [];

		_enemyArray = (getPos _heliPad) nearEntities [["Air", "Car", "Motorcycle", "Tank", "Man"], _searchRadius];

		{
			if ((side _x == _friendlySide) || (side _x == _neutralSide)) then {
			
				_enemyArray = _enemyArray - [_x];
			};

		} count _enemyArray;

		_enemyAntiAirArray = [];

		{
			if (typeOf _x in _enemyAntiAir) then {
			
				_enemyAntiAirArray = _enemyAntiAirArray + [_x];
			};
			
		} count _enemyArray;

		if (((count _enemyArray) > 10) or ((count _enemyAntiAirArray) > 0)) then {

			hintSilent parseText format ["<t size = '1.5' color = '#FF0000'>Transport Be ForeWarned!</t><br/><br/>Too many enemies close! ( 10 per 50m )<br/><br/>Secure the area before requesting transport!"];

			[_heli] execVM "paramsplus\heliBombs.sqf";
		};

		_wp0 = (group _heli) addwaypoint [getPos _heliPad, 0];
		_wp0 setWaypointPosition [getPosASL _heliPad, -1];
		_wp0 waypointAttachVehicle _heliPad;
		_wp0 setwaypointtype "TR UNLOAD";	
		_wp0 setWaypointBehaviour "AWARE";
		_wp0 setWaypointCombatMode "YELLOW";
		_wp0 setWaypointSpeed "NORMAL";
		_wp0 setWaypointStatements ["true",""];

		_wpp0 = (group _caller) addwaypoint [getPos _heliPad, 0];
		_wpp0 setWaypointPosition [getPosASL _heliPad, -1];
		_wpp0 waypointAttachVehicle _heliPad;
		_wpp0 setwaypointtype "GETOUT";	
		_wpp0 setWaypointBehaviour "AWARE";
		_wpp0 setWaypointCombatMode "YELLOW";
		_wpp0 setWaypointSpeed "NORMAL";
		_wpp0 setWaypointStatements ["true",""];

		[(group _caller), 0] synchronizeWaypoint [[(group _heli), 0]];

		waitUntil {(_heli distance2d _heliPad < 200)};
		(driver _heli) move getPos _heliPad;
		(driver _heli) commandMove getPos _heliPad;
		(_heli) land "GET OUT";
		//waitUntil {crew _heli arrayIntersect units (group _caller) isEqualTo []};

		_wp1 = (group _heli) addwaypoint [_airEnd, 100];
		_wp1 setwaypointtype "MOVE";
		_wp1 setWaypointBehaviour "AWARE";
		_wp1 setWaypointCombatMode "YELLOW";
		_wp1 setWaypointSpeed "NORMAL";
		_wp1 setWaypointStatements ["true","[vehicle this] execVM 'paramsplus\heliEnd.sqf'"]; 
	},
	[],
	10,
	false,
	true,
	"",
	"",
	-1,
	true,
	"",
	""];
};


//{unassignVehicle _x; doGetOut _x} forEach units group this
