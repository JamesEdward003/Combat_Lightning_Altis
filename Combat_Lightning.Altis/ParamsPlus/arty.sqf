//////////////////////////////////////////////////////////////////
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;                
//_types = ["B_MBT_01_arty_F","O_MBT_02_arty_F","I_Truck_02_MRL_F","I_Truck_02_MRL_F"];
_types = ["B_MBT_01_mlrs_F","O_MBT_02_arty_F","I_Truck_02_MRL_F","I_Truck_02_MRL_F"];

_vehicle = [];

switch (side _caller) do {

	case west:			{_vehicle = (_types select 0)};
	case east:			{_vehicle = (_types select 1)};
	case resistance:	{_vehicle = (_types select 2)};
	case civilian:		{_vehicle = (_types select 3)};
};

_spawnPoints = [];

switch (side _caller) do {

	case west:			{_spawnPoints = [spawnpt1,spawnpt2,spawnpt3]};
	case east:			{_spawnPoints = [spawnpt1_2,spawnpt2_2,spawnpt3_2]};
	case resistance:	{_spawnPoints = [spawnpt1_3,spawnpt2_3,spawnpt3_3]};
	case civilian:		{_spawnPoints = [spawnpt1_5,spawnpt2_5,spawnpt3_5]};
};

_mrkrcolor = [];

switch (side _caller) do {

	case west:			{_mrkrcolor = "ColorBLUFOR"};
	case east:			{_mrkrcolor = "ColorOPFOR"};
	case resistance:	{_mrkrcolor = "ColorGUER"};
	case civilian:		{_mrkrcolor = "ColorCIV"};
};

[_caller, "Requesting artillery at the designated coordinates"] remoteExecCall ["commandChat", 0];

titleText ['<t color=''#ffdd22'' size=''2''>MAPCLICK COORDINATES!</t><br/>***********', 'PLAIN DOWN', -1, true, true];

playSound3D ["A3\dubbing_f\modules\supports\artillery_request.ogg", _caller];

if ((!isNil {missionNamespace getVariable "CruiseMissilesInProgress"}) OR (!isNil {missionNamespace getVariable "ArtilleryInProgress"})) exitWith {
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Artillery Mission Currently In Progress!</t>"];
};
missionNamespace setVariable ["ArtilleryInProgress",true];

switch (true) do {
	case (_position isNotEqualTo []): 
		{//_position = (screenToWorld [0.5,0.5]);
		_position = _position;
		
		_hLand = createMarkerLocal ["Artillery", _position];
		_hLand setMarkerTypeLocal "mil_objective";
		_hLand setMarkerShapeLocal "Icon";
		_hLand setMarkerTextLocal " Artillery";
		_hLand setMarkerSizeLocal [.5,.5];
		_hLand setMarkerAlphaLocal .5;
		_hLand setMarkerColorLocal _mrkrcolor;
		
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mark target successful</t>"];
		};
	case (_position isEqualTo []): 
		{
		objective = false;
		sleep 0.25;
		openmap [true,false];
		sleep 0.25;

		titleText["Map target", "PLAIN"];
		onMapSingleClick "onMapSingleClick ''; mappos = _pos; objective = true";		
		waitUntil {sleep 1; (!visiblemap OR objective OR !alive _caller)};
			if (!objective OR !alive _caller) exitWith {
			mappos = nil;
			missionNamespace setVariable ["ArtilleryInProgress",nil];
			hintSilent parseText format["<t size='1.25' color='#FF5500'>Map target canceled</t>"];
			titletext ["","plain"];
			uisleep 6;
			hintSilent "";
			};
			  
		_hLand = createMarkerLocal ["Artillery", mappos];
		_hLand setMarkerTypeLocal "mil_objective";
		_hLand setMarkerShapeLocal "Icon";
		_hLand setMarkerTextLocal " Artillery";
		_hLand setMarkerSizeLocal [.5,.5];
		_hLand setMarkerAlphaLocal .5;
		_hLand setMarkerColorLocal _mrkrcolor;
		
		titletext ["","plain",0.2];
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Map target successful</t>"];
		
		_position = getMarkerPos "Artillery";
			
		uisleep 1;
		openmap [false,false];
		};
};
if (_position isEqualTo []) exitWith {[_caller, "Request canceled"] remoteExecCall ["commandChat", 0];};
_artySmoke = createVehicle ["SmokeShellRed", [_position select 0, _position select 1, ((_position select 2) + 10)], [], 0, "NONE"];
call compile format ["%1=_artySmoke","target"];
uisleep 4;

_artillery = [];
{
	private _arty = createVehicle [ _vehicle, (getPosATL _x), [], 0, "CAN_COLLIDE" ];
	_arty setDir ((getDir _arty) + 45);
	_arty setVehiclePosition [_x modelToWorld [0,0,((getPosATL _x) select 2)], [], 0, "CAN_COLLIDE"];
	
	createVehicleCrew _arty;
	_artillery pushBack _arty;
	uisleep 1;
} forEach _spawnPoints;

if (_artillery isEqualTo []) exitWith {deleteMarker "Artillery";missionNamespace setVariable ["ArtilleryInProgress",nil];_caller sidechat "Artillery Malfunction!";hintSilent parseText format["<t size='1.25' color='#FF5500'>Artillery Malfunction!</t>"];};

(_artillery select 0) execVM "ParamsPlus\VehicleRespawnNotification.sqf";
(_artillery select 1) execVM "ParamsPlus\VehicleRespawnNotification.sqf";
(_artillery select 2) execVM "ParamsPlus\VehicleRespawnNotification.sqf";

if ((position target) inRangeOfArtillery [[(_artillery select 0)], currentMagazine (_artillery select 0)]) then {
	(_artillery select 0) sidechat format ["Target In Range: %1", (position target) inRangeOfArtillery [[(_artillery select 0)], currentMagazine (_artillery select 0)]];

	playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", _caller];

	(_artillery select 0) sidechat format ["Artillery Ammo: %1", (getArtilleryAmmo [_artillery select 0] select 0)];
	uisleep 1;

	(_artillery select 0) sidechat format ["Artillery ETA Target: %1 seconds", (_artillery select 0) getArtilleryETA [(position target), getArtilleryAmmo [(_artillery select 0)] select 0]];
	uisleep 4;

	(_artillery select 0) sidechat "Artillery Rounds Firing!";

	{
		_x setVehicleAmmo 1;
		_shotsFired = 3;
		_ammo = (getArtilleryAmmo [_x] select 0);
		_x commandArtilleryFire [(position target), _ammo, _shotsFired];
	} forEach _artillery;
	
	_eta = (_artillery select 0) getArtilleryETA [(position target), getArtilleryAmmo [(_artillery select 0)] select 0];

	missionNamespace setVariable ["ETA_Target",round _eta];

	waitUntil {!isNil "ETA_Target"};

	_eta = missionNamespace getVariable "ETA_Target";

	["Artillery", _eta] spawn {
		private ["_i","_marker","_eta"];
		params ["_marker","_eta"];
		_marker = _this select 0;
		_eta = _this select 1;
		for [{ _i = _eta}, { _i > 0 - 1 }, { _i = _i - 1 }] do
		{	uisleep 1;
			_marker setMarkerTextLocal format [" Artillery ETA %1 seconds", _i];
			//hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1</t>",_eta];
			if (_i == 0) then {
				missionNamespace setVariable ["ETA_Target",nil];
			};
		};
	};
	uisleep 24;

  	playSound3D ["A3\dubbing_f\modules\supports\artillery_rounds_complete.ogg", _caller];
	uisleep 1;
	[(_artillery select 0), "Rounds complete.  Out."] remoteExecCall ["commandChat", 0];

	waitUntil {isNil "ETA_Target"};
	uisleep 1;

	playSound3D ["A3\dubbing_f\modules\supports\artillery_accomplished.ogg", _caller];
	uisleep 1;

	[(_artillery select 0), "Splash.  Out."] remoteExecCall ["commandChat", 0];

	uisleep 20;

	[side _caller, "HQ"] commandChat "Artillery Ready For ReAssignment!";

	deleteMarker "Artillery";

	for "_i" from 0 to count _artillery do {
		{(_artillery select _i) deleteVehicleCrew _x} forEach crew (_artillery select _i);
		deleteVehicle (_artillery select _i); 
		};

	missionNamespace setVariable ["ArtilleryInProgress",nil];

	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Artillery Ready for another mission.</t>"];

} else {
	(_artillery select 0) sidechat format ["Target Out Of Range: %1", _position inRangeOfArtillery [[(_artillery select 0)], currentMagazine (_artillery select 0)]];

	[side _caller, "HQ"] commandChat "Target Out Of Range!";

	deleteMarker "Artillery";

	for "_i" from 0 to count _artillery do {
		{(_artillery select _i) deleteVehicleCrew _x} forEach crew (_artillery select _i);
		deleteVehicle (_artillery select _i); 
		};
	missionNamespace setVariable ["ArtilleryInProgress",nil];

	hintSilent parseText format["<t size='1.25' color='#FF5500'>Target Out Of Range!</t>"];
};
