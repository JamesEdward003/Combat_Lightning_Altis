//////////////////////////////////////////////////////////////////
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
//_types = ["B_Mortar_01_F","O_Mortar_01_F","I_Mortar_01_F","I_Mortar_01_F"];  //"mortar_82mm","mortar_155mm_AMOS"];
//_types = ["vn_b_sf_static_mortar_m2","vn_o_nva_static_mortar_type53","vn_i_static_mortar_m2"];

_mortar = switch (side _caller) do {

         case west:			{"B_Mortar_01_F"};
         case east:			{"O_Mortar_01_F"};
         case resistance:	{"I_Mortar_01_F"};
         case civilian:		{"I_Mortar_01_F"};
};

_mrkrcolor = switch (side _caller) do {

         case west:			{"ColorBLUFOR"};
         case east:			{"ColorOPFOR"};
         case resistance:	{"ColorGUER"};
         case civilian:		{"ColorCIV"};
};

playSound3D ["A3\dubbing_f\modules\supports\artillery_request.ogg", _caller];

[_caller, "Requesting mortar support at the designated coordinates"] remoteExecCall ["commandChat", 0];

if (!isNil {missionNamespace getVariable "MortarInProgress"}) exitWith {
	hint parseText format["<t size='1.25' color='#FF5500'>Mortar Mission Currently In Progress!</t>"];
};
missionNamespace setVariable ["MortarInProgress",true];

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
		missionNamespace setVariable ["MortarInProgress",nil];
		hint parseText format["<t size='1.25' color='#FF5500'>Map target cancelled</t>"];
		titletext ["","plain"];
		};
		  
	_hLand = createMarkerLocal ["Mortar", mappos];
	"Mortar" setMarkerTypeLocal "mil_objective";
	"Mortar" setMarkerShapeLocal "Icon";
	"Mortar" setMarkerTextLocal " Mortar";
	"Mortar" setMarkerSizeLocal [.75,.75];
	"Mortar" setMarkerAlphaLocal .75;
	"Mortar" setMarkerColorLocal _mrkrcolor;
	
	titletext ["","plain",0.2];
	hint parseText format["<t size='1.25' color='#00FFFF'>Map objective successful</t>"];
	
	_position = getMarkerPos "Mortar";

	uisleep 1;
	openmap [false,false];

} else {
		  
	_hLand = createMarkerLocal ["Mortar", _position];
	"Mortar" setMarkerTypeLocal "mil_objective";
	"Mortar" setMarkerShapeLocal "Icon";
	"Mortar" setMarkerTextLocal " Mortar";
	"Mortar" setMarkerSizeLocal [.75,.75];
	"Mortar" setMarkerAlphaLocal .75;
	"Mortar" setMarkerColorLocal _mrkrcolor;
	
	hint parseText format["<t size='1.25' color='#00FFFF'>Mark objective successful</t>"];
	
	_position = _position;
};
if (_position isEqualTo []) exitWith {[_caller, "Request canceled"] remoteExecCall ["commandChat", 0];};
uisleep 4;

_mortarSmoke = createVehicle ["SmokeShellOrange", [_position select 0, _position select 1, ((_position select 2) + 10)], [], 0, "NONE"];
call compile format ["%1=_mortarSmoke","mortarSmoke"];

target = mortarSmoke;

if ( target isEqualTo objNull ) exitWith {

	hint parseText format["<t size='1.25' color='#FF5500'>Target not found!</t>"];

	PAPABEAR=[(side _caller),"HQ"]; PAPABEAR SideChat format ["Target not found, %1", name _caller];

	deleteMarker "Mortar";

	missionNamespace setVariable ["MortarInProgress",nil];

	uisleep 4;

	hint parseText format["<t size='1.25' color='#00FFFF'>Mortar is ready for another mission.</t>"];

	PAPABEAR=[(side _caller),"HQ"]; PAPABEAR SideChat "Mortar is Ready For ReAssignment!";
};

_spawnPos = [];

if (_caller distance uss_freedom < 3000) then {

	_spawnPos = getPos spawnpt1;

} else {

	_spawnPos = _caller modelToWorld [6,0,0];
};

_virtualProvider = _mortar createVehicle _spawnPos;
				 
createVehicleCrew _virtualProvider;

_virtualProvider setVehicleAmmo 1;

_virtualProvider setVehicleLock "UNLOCKED";

_virtualProvider addEventHandler ["Fired", {
	private ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	_unit = _this select 0;
	_projectile = _this select 6;
	call compile format ["%1=_projectile","projectile"];
	[mortarSmoke,projectile] spawn {
		private ["_mortarSmoke", "_projectile", "_t", "_eta"];
		params ["_mortarSmoke", "_projectile"];
		_mortarSmoke = _this select 0;
		_projectile = _this select 1;
		scopeName "main";
		while {alive _projectile} do {
			_t = ((_mortarSmoke distance _projectile) / (speed _projectile) * 4.8);
			_eta = round _t;
			uisleep 1;
			missionNamespace setVariable ["ETA_Mortar",_eta];
			if (!alive _projectile) then {breakTo "main"};
			if (_eta < 1) then {breakTo "main"};
		};
	};
	_unit removeEventHandler ["Fired", _thisEventHandler];
}];
uisleep 5;

if (getMarkerPos "Mortar" inRangeOfArtillery [[_virtualProvider], currentMagazine _virtualProvider]) then {

	_virtualProvider execVM "ParamsPlus\VehicleRespawnNotification.sqf";
	uisleep 1;

	playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", _caller];
	uisleep 1;

	_virtualProvider sidechat format["%1, %2",_virtualProvider,group _virtualProvider];
	uisleep 1;

	_virtualProvider sidechat format ["Target In Range: %1", getMarkerPos "Mortar" inRangeOfArtillery [[_virtualProvider], currentMagazine _virtualProvider]];
	uisleep 1;

	_virtualProvider sidechat format ["Mortar ETA Target: %1", _virtualProvider getArtilleryETA [getMarkerPos "Mortar", (getArtilleryAmmo [_virtualProvider] select 0)]];
	uisleep 1;

	_virtualProvider sidechat format ["Mortar Ammo: %1", getArtilleryAmmo [_virtualProvider] select 0];
	uisleep 1;

	[_virtualProvider, "Target location received.  Ordinance is inbound.  Out."] remoteExecCall ["commandChat", 0];

	for "_i" from 1 to 6 do {
		private _ammo = (getArtilleryAmmo [_virtualProvider] select 0);
		_virtualProvider doArtilleryFire [(position target), _ammo, 1];
		sleep 2;
	};	

	waitUntil {!isNil "ETA_Mortar"};

	_eta = missionNamespace getVariable "ETA_Mortar";

	["Mortar", _eta] spawn {
		private ["_i","_marker","_eta"];
		params ["_marker","_eta"];
		_marker = _this select 0;
		_eta = _this select 1;
		for [{ _i = _eta }, { _i > 0 - 1 }, { _i = _i - 1 }] do
		{	uisleep 1;
			_marker setMarkerTextLocal format [" Mortar ETA %1 seconds", _i];
			if (_i == 0) then {
				missionNamespace setVariable ["ETA_Mortar",nil];
			};
		};
	};
	
	playSound3D ["A3\dubbing_f\modules\supports\artillery_rounds_complete.ogg", _caller];

	[_virtualProvider, "Rounds complete.  Out."] remoteExecCall ["commandChat", 0];

	waitUntil {isNil "ETA_Mortar"};

	playSound3D ["A3\dubbing_f\modules\supports\artillery_accomplished.ogg", _caller];

	[_virtualProvider, "Splash.  Out."] remoteExecCall ["commandChat", 0];

	uisleep 24;

	[_virtualProvider, "Mortar is ready for another mission."] remoteExecCall ["commandChat", 0];

	deleteMarker "Mortar";

	deleteVehicleCrew _virtualProvider;

	deleteVehicle _virtualProvider;

	missionNamespace setVariable ["MortarInProgress",nil];

	hint parseText format["<t size='1.25' color='#00FFFF'>Mortar is ready for another mission.</t>"];

} else {

	_virtualProvider sidechat format ["Target In Range: %1", getMarkerPos "Mortar" inRangeOfArtillery [[_virtualProvider], currentMagazine _virtualProvider]];

	[_virtualProvider, "Mortar Target is out of range."] remoteExecCall ["commandChat", 0];

	deleteMarker "Mortar";

	deleteVehicleCrew _virtualProvider;

	deleteVehicle _virtualProvider;

	missionNamespace setVariable ["MortarInProgress",nil];

	hintSilent parseText format["<t size='1.25' color='#FF5500'>Mortar Target is out of range.</t>"];
};


//	_ammo = [
//	"8Rnd_82mm_Mo_shells",
//	"8Rnd_82mm_Mo_Flare_white",
//	"8Rnd_82mm_Mo_Smoke_white",
//	"8Rnd_82mm_Mo_guided",
//	"8Rnd_82mm_Mo_LG"
//	];

//	_ammo = [
//	"32Rnd_155mm_Mo_shells",
//	"32Rnd_155mm_Mo_shells_O",
//	"6Rnd_155mm_Mo_smoke",
//	"6Rnd_155mm_Mo_smoke_O",
//	"2Rnd_155mm_Mo_guided",
//	"2Rnd_155mm_Mo_guided_O",
//	"4Rnd_155mm_Mo_guided",
//	"4Rnd_155mm_Mo_guided_O",
//	"2Rnd_155mm_Mo_LG",
//	"4Rnd_155mm_Mo_LG",
//	"4Rnd_155mm_Mo_LG_O",
//	"6Rnd_155mm_Mo_mine",
//	"6Rnd_155mm_Mo_mine_O",
//	"6Rnd_155mm_Mo_AT_mine",
//	"6Rnd_155mm_Mo_AT_mine_O",
//	"2Rnd_155mm_Mo_Cluster",
//	"2Rnd_155mm_Mo_Cluster_O"
//	];

/*
	_eta = missionNamespace getVariable "ETA_Mortar";
	uisleep 1;
	["Mortar", _eta] spawn {
		_marker = _this select 0;
		_eta = _this select 1;
		private ["_i"];
		for [{ _i = _eta }, { _i > 0 }, { _i = _i - 1 }] do
		{	uisleep 1;
			_marker setMarkerTextLocal format [" Mortar ETA %1 sec", _i];
			if (_i == 0) then {
				missionNamespace setVariable ["ETA_Mortar",nil];
			};
		};
	};
*/

