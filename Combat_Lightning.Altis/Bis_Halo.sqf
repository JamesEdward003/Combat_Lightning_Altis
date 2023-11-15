//////////////////////////////////////////////////////////////////
waitUntil { isServer || !isNull player };
private ["_unit", "_group", "_pos", "_m"];
_unit = player;
_group = group player;
_leader = leader _group;

if (!isFormationLeader _unit) exitWith {PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat format ["%1, you need to be leader of group to HALO", name _unit]};
if (!isNull objectParent _unit) exitWith {PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat format ["%1, you need to be out of vehicle to HALO", name _unit]};

uisleep 0.25;
objective = false;
openmap [true,false];

deleteMarker "mrkrx";

titleText["map halo area", "PLAIN"];
PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name _unit];
onMapSingleClick "onMapSingleClick ''; mappos = _pos; objective = true";		
waitUntil {sleep 1; ((visiblemap isEqualTo false) OR (objective isEqualTo true) OR ((alive _unit) isEqualTo false))};

	if ((objective isEqualTo false) OR ((alive _unit) isEqualTo false)) exitWith {
	mappos = nil;
	PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Mapclick location canceled";
	hint parseText format["<t size='1.25' color='#ff6161'>Map location canceled</t>"];
	titletext ["","plain"];
	};
	
	_m = createMarker ["mrkrx",mappos];
	_m setMarkerShape "ELLIPSE";
	_m setMarkerSize [200,200];
	_m setMarkerBrush "DiagGrid";
	_m setMarkerAlpha 1;
	_m setMarkerColor "ColorGreen";
	
titletext ["","plain",0.25];
hint parseText format["<t size='1.25' color='#44ff00'>Mapclick location successful</t>"];
uisleep 0.25;
hintSilent "";
openmap [false,false];

_position = getMarkerPos "mrkrx";
_jumpTargetPos = [_position select 0, _position select 1, ((_position select 2) + 0)];
_jumpTarget = createVehicle ["Land_JumpTarget_F", _jumpTargetPos, [], 0, "NONE"];

_box = createVehicle ["B_supplyCrate_F", [_jumpTargetPos select 0, _jumpTargetPos select 1, +20], [], 0, "FLY"];
[objnull, _box] call BIS_fnc_curatorobjectedited;

//_chute = createVehicle ["B_Parachute_02_F", (getMarkerPos "mrkrx"), [], 0, "FLY"];
//_box attachto [_chute, [0, 0, 0]];

enableRadio false;

unassignVehicle _leader;
_leader action ["EJECT", (vehicle _leader)];
uisleep 0.03;
_leader allowDamage false;
_leader setPos getMarkerPos "mrkrx";
[_leader,3000] call BIS_fnc_halo;
_leader spawn {waitUntil {getPosATL _this select 2 < 200}; _this action ["openParachute"];};
_leader move _jumpTargetPos;

{if (_x != _leader ) then {
	_dir = random 359;
	_leadDir = direction _leader;
	unassignVehicle _x;
	_x action ["EJECT", (vehicle _leader)];
	uisleep 0.03;
	_x allowDamage false;
	_x setPos [(getPos _leader select 0)-10*sin(_dir),(getPos _leader select 1)-10*cos(_dir)];
	_x setDir _leadDir;
	[_x,getPos _leader select 2] call BIS_fnc_halo;
	//_x addBackpack "B_Parachute"; 
	_x spawn {waitUntil {getPosATL _this select 2 < 100}; _this action ["openParachute"];};
	_x move _jumpTargetPos;	
}} forEach units _group;

enableRadio true;

[playerSide, "HQ"] commandChat format ["%1: Pull the ripcord before height 300 meters!",name _unit];

waitUntil {((getPos player) select 2) < 200 || !alive player};

["AmmoboxInit", [_box, true, {true}]] spawn BIS_fnc_arsenal;

_box setPos _jumpTargetPos;

"F_40mm_White" createVehicle [_jumpTargetPos select 0, _jumpTargetPos select 1, +150];	

_smokePos = [_jumpTargetPos select 0, _jumpTargetPos select 1, ((_jumpTargetPos select 2) + 100)];

_greenSmoke = createVehicle ["SmokeShellGreen", _smokePos, [], 0, "NONE"];

waitUntil {((getPos player) select 2) < 1 || !alive player};

uisleep 6; 

{
	_x allowDamage true;
	
} forEach units _group;

deleteMarker "mrkrx";

