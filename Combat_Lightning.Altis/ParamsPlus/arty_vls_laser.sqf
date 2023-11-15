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

[_caller, "Requesting a laser guided cruise missile at the designated coordinates"] remoteExecCall ["commandChat", 0];

playSound3D ["A3\dubbing_f\modules\supports\artillery_request.ogg", _caller];

if ((!isNil {missionNamespace getVariable "CruiseMissilesInProgress"}) OR (!isNil {missionNamespace getVariable "ArtilleryInProgress"})) exitWith {
	hintSilent parseText format["<t size='1.25' color='#FF5500'>Artillery Mission Currently In Progress!</t>"];
};
missionNamespace setVariable ["CruiseMissilesInProgress",true];

hintSilent parseText format["<t size='1.25' color='#FF5500'>Laser target now!</t>"];

[16, "#FF5500"] execVM "ParamsPlus\TimeoutCountdown.sqf";

uisleep 1;

waitUntil {isNil "RscFiringDrillTime_done"};

switch (true) do {
	case (!isNull (laserTarget _caller)):
		{
		_position = (getPosATL (laserTarget _caller));
		_target = (laserTarget _caller);
		_target setVehicleVarname "target"; target = _target;

		_hLand = createMarkerLocal ["CruiseMissile", _position];
		_hLand setMarkerTypeLocal "mil_warning";
		_hLand setMarkerShapeLocal "Icon";
		_hLand setMarkerTextLocal " CruiseMissile";
		_hLand setMarkerSizeLocal [.75,.75];
		_hLand setMarkerAlphaLocal .75;
		_hLand setMarkerColorLocal _mrkrcolor;
		
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mark laser target successful</t>"];
		};
	case (!isNull (laserTarget getConnectedUAV _caller)): 
		{
		_position = (getPosATL (laserTarget getConnectedUAV _caller));
		_target = (laserTarget getConnectedUAV _caller);
		_target setVehicleVarname "target"; target = _target;
			  
		_hLand = createMarkerLocal ["CruiseMissile", _position];
		_hLand setMarkerTypeLocal "mil_warning";
		_hLand setMarkerShapeLocal "Icon";
		_hLand setMarkerTextLocal " CruiseMissile";
		_hLand setMarkerSizeLocal [.75,.75];
		_hLand setMarkerAlphaLocal .75;
		_hLand setMarkerColorLocal _mrkrcolor;
		
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Mark uav laser target successful</t>"];
		};
	case ((isNull (laserTarget _caller)) AND (isNull (laserTarget getConnectedUAV _caller))): 
		{
		hintSilent parseText format["<t size='1.25' color='#FF5500'>Target not found!</t>"];

		PAPABEAR=[(side _caller),"HQ"]; PAPABEAR SideChat format ["Target not found, %1", name _caller];

		missionNamespace setVariable ["CruiseMissilesInProgress",nil];

		deleteMarker "CruiseMissile";

		uisleep 6;

		PAPABEAR=[(side _caller),"HQ"]; PAPABEAR SideChat "Cruise Missile is Ready For ReAssignment!";

		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Cruise Missile is ready for another mission.</t>"];
		};
};

if ((isNull (laserTarget _caller)) AND (isNull (laserTarget getConnectedUAV _caller))) exitWith {};

_VLS_Array = [];
{
	private _vls = createVehicle [ _vehicle, (getPosATL _x), [], 0, "CAN_COLLIDE" ];
	_vls setVehiclePosition [_x modelToWorld [0,0,((getPosATL _x) select 2)], [], 0, "CAN_COLLIDE"];
	_vls setDir ((getDir _vls) + 45);
	createVehicleCrew _vls;
	_vls setVehicleAmmo 1;
	_VLS_Array pushBack _vls;
	uisleep 1;
} forEach [_spawnPoints select 0];

if (_VLS_Array isEqualTo []) exitWith 
	{
		deleteMarker "CruiseMissile";
		missionNamespace setVariable ["CruiseMissilesInProgress",nil];
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>Cruise Missile Malfunction!</t>"];
		_caller sidechat "Cruise Missile Malfunction!";
	};

(_VLS_Array select 0) setVehicleVarname "MRLS_1"; MRLS_1 = (_VLS_Array select 0);
//[(_VLS_Array select 0), "MRLS_1"] remoteExec ["setVehicleVarName", groupOwner (group _caller)];
[MRLS_1] execVM "ParamsPlus\VehicleRespawnNotification.sqf";
uisleep 1;
playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", _caller];
uisleep 1;
[(_VLS_Array select 0), "Target location received.  Ordinance is inbound.  Out."] remoteExecCall ["commandChat", 0];

MRLS_1 addEventHandler ["Fired", {
	private ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner","_t","_eta"];
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	_t = ((target distance _projectile) / (speed _projectile) * .55);
	_eta = round _t;
	[_eta] spawn  { params ["_eta"]; for [{ _i = _eta}, { _i > 0 - 1 }, { _i = _i - 1 }] do {uisleep 1; hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1</t>",_eta]}};
	missionNamespace setVariable ["ETA_Time",_eta];
	_unit removeEventHandler ["Fired", _thisEventHandler];
}];
["CruiseMissile",_caller,MRLS_1] spawn {
	private ["_i","_marker","_eta","_caller","_MRLS_1"];
	params ["_marker","_caller","_MRLS_1"];
	waitUntil {!isNil "ETA_Time"};
	_eta = missionNamespace getVariable "ETA_Time";
	for [{ _i = _eta}, { _i > 0 - 1 }, { _i = _i - 1 }] do
	{	uisleep 1;
		_marker setMarkerTextLocal format [" Cruise Missile ETA %1 seconds", _i];
		if (_i == 0) then {
			missionNamespace setVariable ["ETA_Time",nil];
			playSound3D ["A3\dubbing_f\modules\supports\artillery_accomplished.ogg", _caller];
			[_MRLS_1, "Splash.  Out."] remoteExecCall ["commandChat", 0];
		};
	};
};

(side _caller) reportRemoteTarget [target, 3600]; 
uisleep 1;
target confirmSensorTarget [(side _caller), true]; 
uisleep 1;	
MRLS_1 setWeaponReloadingTime [gunner MRLS_1, currentMuzzle gunner MRLS_1, 0];
uisleep 1;
MRLS_1 fireAtTarget [target, "weapon_vls_01"];
uisleep 2;

playSound3D ["A3\dubbing_f\modules\supports\artillery_rounds_complete.ogg", _caller];

[MRLS_1, "Rounds complete.  Out."] remoteExecCall ["commandChat", 0];

waitUntil {isNil "ETA_Time"};

uisleep 4;

deleteMarker "CruiseMissile";

{MRLS_1 deleteVehicleCrew _x} forEach crew MRLS_1;

deleteVehicle MRLS_1; 

missionNamespace setVariable ["CruiseMissilesInProgress",nil];

[MRLS_1, "Cruise Missiles Ready For ReAssignment!"] remoteExecCall ["commandChat", 0];

hintSilent parseText format["<t size='1.25' color='#00FFFF'>Cruise Missile Ready for another mission.</t>"];

uisleep 4;

hintSilent "";
