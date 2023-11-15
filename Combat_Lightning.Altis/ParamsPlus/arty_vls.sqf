//////////////////////////////////////////////////////////////////
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
//_types = ["B_MBT_01_arty_F","O_MBT_02_arty_F","I_Truck_02_MRL_F","I_Truck_02_MRL_F"];
_types = ["B_Ship_MRLS_01_F","O_MBT_02_arty_F","I_Truck_02_MRL_F","I_Truck_02_MRL_F"];

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

[_caller, "Requesting cruise missiles at the designated coordinates"] remoteExecCall ["commandChat", 0];

playSound3D ["A3\dubbing_f\modules\supports\artillery_request.ogg", _caller];

if ((!isNil {missionNamespace getVariable "CruiseMissilesInProgress"}) OR (!isNil {missionNamespace getVariable "ArtilleryInProgress"})) exitWith {
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Artillery Mission Currently In Progress!</t>"];
};
missionNamespace setVariable ["CruiseMissilesInProgress",true];

switch (true) do {
	case (_position isNotEqualTo []): 
		{//_position = (screenToWorld [0.5,0.5]);
		_position = _position;
		
		_hLand = createMarkerLocal ["CruiseMissiles", _position];
		_hLand setMarkerTypeLocal "mil_warning";
		_hLand setMarkerShapeLocal "Icon";
		_hLand setMarkerTextLocal " CruiseMissiles";
		_hLand setMarkerSizeLocal [.75,.75];
		_hLand setMarkerAlphaLocal .75;
		_hLand setMarkerColorLocal _mrkrcolor;
		
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mark target successful</t>"];
		};
	case (_position isEqualTo []): 
		{
		objective = false;
		sleep 0.25;
		openmap [true,false];
		sleep 0.25;

		titleText ['<t color=''#ffdd22'' size=''2''>MAPCLICK COORDINATES!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
		onMapSingleClick "onMapSingleClick ''; mappos = _pos; objective = true";		
		waitUntil {sleep 1; (!visiblemap OR objective OR !alive _caller)};
			if (!objective OR !alive _caller) exitWith {
			mappos = nil;
			missionNamespace setVariable ["CruiseMissilesInProgress",nil];
			hintSilent parseText format["<t size='1.25' color='#FF5500'>Map target canceled</t>"];
			titletext ["","plain"];
			uisleep 6;
			hintSilent "";
			};
			  
		_hLand = createMarkerLocal ["CruiseMissiles", mappos];
		_hLand setMarkerTypeLocal "mil_warning";
		_hLand setMarkerShapeLocal "Icon";
		_hLand setMarkerTextLocal " CruiseMissiles";
		_hLand setMarkerSizeLocal [.75,.75];
		_hLand setMarkerAlphaLocal .75;
		_hLand setMarkerColorLocal _mrkrcolor;
		
		titletext ["","plain",0.2];
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Map target successful</t>"];
		
		_position = getMarkerPos "CruiseMissiles";
			
		uisleep 1;
		openmap [false,false];
		};
};
if (_position isEqualTo []) exitWith {[_caller, "Request canceled"] remoteExecCall ["commandChat", 0];};
_redSmoke = createVehicle ["SmokeShellRed", [_position select 0, _position select 1, ((_position select 2) + 10)], [], 0, "NONE"];
call compile format ["%1=_redSmoke","redSmoke"];
uisleep 4;
_nearTargets = (getPos redSmoke) nearEntities [["Air", "Car", "Motorcycle", "Tank", "Man"],100]; //  "House",
_targetFilter = switch (side _caller) do {

    case west:			{[_nearTargets, { side _x == east OR side _x == resistance }]};
    case east:			{[_nearTargets, { side _x == west OR side _x == resistance }]};
    case resistance:	{[_nearTargets, { side _x == west OR side _x == east }]};
    case civilian:		{[_nearTargets, { side _x == east OR side _x == resistance }]};
};
_targets = _targetFilter call BIS_fnc_conditionalSelect;
hintSilent format ["%1",_targets];

if ( _targets isEqualTo [] ) exitWith {

	hintSilent parseText format["<t size='1.25' color='#FF5500'>Targets not found!</t>"];

	deleteMarker "CruiseMissiles";

	missionNamespace setVariable ["CruiseMissilesInProgress",nil];

	uisleep 4;

	hintSilent parseText format["<t size='1.25' color='#00FFFF'>Cruise Missiles Ready For ReAssignment!</t>"];

	PAPABEAR=[(side _caller),"HQ"]; PAPABEAR SideChat "Cruise Missiles Ready For ReAssignment!";
};

_VLS_Array = [];
{
	private _vls = createVehicle [ _vehicle, (getPosATL _x), [], 0, "CAN_COLLIDE" ];
	_vls setVehiclePosition [_x modelToWorld [-6,-2,((getPosATL _x) select 2)], [], 0, "CAN_COLLIDE"];
	_vls setDir ((getDir _vls) + 45);
	createVehicleCrew _vls;
	_vls setVehicleAmmo 1;
	_VLS_Array pushBack _vls;
	uisleep 1;
} forEach _spawnPoints;

if (_VLS_Array isEqualTo []) exitWith 
	{
		deleteMarker "CruiseMissiles";
		missionNamespace setVariable ["CruiseMissilesInProgress",nil];
		_caller sidechat "Cruise Missile Malfunction!";
	};

(_VLS_Array select 0) setVehicleVarname "MRLS_1"; MRLS_1 = (_VLS_Array select 0);
//[(_VLS_Array select 0), "MRLS_1"] remoteExec ["setVehicleVarName", groupOwner (group _caller)];

MRLS_1 addEventHandler ["Fired", {
	private ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner","_t","_eta"];
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	_t = ((redSmoke distance _projectile) / (speed _projectile) * .25);
	_eta = round _t;
	[_eta] spawn  { params ["_eta"]; for [{ _i = _eta}, { _i > 0 - 1 }, { _i = _i - 1 }] do {uisleep 1; hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1</t>",_eta]}};
	missionNamespace setVariable ["ETA_Time",_eta];
	_unit removeEventHandler ["Fired", _thisEventHandler];
}];
["CruiseMissiles",_caller,MRLS_1] spawn {
	private ["_i","_marker","_eta","_caller","_MRLS_1"];
	params ["_marker","_caller","_MRLS_1"];
	waitUntil {!isNil "ETA_Time"};
	_eta = missionNamespace getVariable "ETA_Time";
	for [{ _i = _eta}, { _i > 0 - 1 }, { _i = _i - 1 }] do
	{	uisleep 1;
		_marker setMarkerTextLocal format [" Missiles ETA %1 seconds", _i];
		if (_i == 0) then {
			missionNamespace setVariable ["ETA_Time",nil];
			playSound3D ["A3\dubbing_f\modules\supports\artillery_accomplished.ogg", _caller];
			[_MRLS_1, "Splash.  Out."] remoteExecCall ["commandChat", 0];
		};
	};
};
[(_VLS_Array select 0)] execVM "ParamsPlus\VehicleRespawnNotification.sqf";
uisleep 1;
[(_VLS_Array select 1)] execVM "ParamsPlus\VehicleRespawnNotification.sqf";
uisleep 1;
[(_VLS_Array select 2)] execVM "ParamsPlus\VehicleRespawnNotification.sqf";
uisleep 1;
playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", _caller];
uisleep 1;
[(_VLS_Array select 0), "Target location received.  Ordinance is inbound.  Out."] remoteExecCall ["commandChat", 0];

{	private _target = _x;
	(side _caller) reportRemoteTarget [_x, 3600]; 
	uisleep 1;
	_x confirmSensorTarget [(side _caller), true]; 
	uisleep 1;	
	{ 
		_x setWeaponReloadingTime [gunner _x, currentMuzzle gunner _x, 0];

		_x fireAtTarget [_target, "weapon_vls_01"];

		uisleep 2;

	} forEach _VLS_Array;
} forEach _targets;

playSound3D ["A3\dubbing_f\modules\supports\artillery_rounds_complete.ogg", _caller];

[(_VLS_Array select 0), "Rounds complete.  Out."] remoteExecCall ["commandChat", 0];

uisleep 20;

deleteMarker "CruiseMissiles";

for "_i" from 0 to count _VLS_Array do {
{(_VLS_Array select _i) deleteVehicleCrew _x} forEach crew (_VLS_Array select _i);
deleteVehicle (_VLS_Array select _i); 
};

missionNamespace setVariable ["CruiseMissilesInProgress",nil];

[(_VLS_Array select 0), "Cruise Missiles Ready For ReAssignment!"] remoteExecCall ["commandChat", 0];

hintSilent parseText format["<t size='1.25' color='#00FFFF'>Cruise Missiles Ready for another mission.</t>"];

uisleep 4;

hintSilent "";

/*

_nearTargets = (getPos redSmoke) nearEntities [["Air", "Car", "Motorcycle", "Tank", "Man"],100];
_targets = [_nearTargets, { side _x == east OR side _x == resistance }] call BIS_fnc_conditionalSelect;
//hintSilent format ["%1",_targets];

*/
