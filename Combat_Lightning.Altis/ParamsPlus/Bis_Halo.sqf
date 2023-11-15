//  execVM "ParamsPlus\Bis_Halo.sqf"  /////////////////////////////////////
waitUntil { isServer || !isNull player };
private ["_unit", "_pos", "_m"];
_unit = player;

uisleep 0.25;
objective = false;
openmap [true,false];

deleteMarker "mrkrx";

titleText ['<t color=''#ffdd22'' size=''3''>MAPCLICK HALO AREA!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
[_unit, "Requesting halo at the designated coordinates"] remoteExecCall ["commandChat", 0];
//PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name _unit];
onMapSingleClick "onMapSingleClick ''; mappos = _pos; objective = true";		
waitUntil {sleep 1; ((visiblemap isEqualTo false) OR (objective isEqualTo true) OR ((alive _unit) isEqualTo false))};

	if ((objective isEqualTo false) OR ((alive _unit) isEqualTo false)) exitWith {
	mappos = nil;
	[_unit, "Halo support canceled"] remoteExecCall ["commandChat", 0];
	//PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Mapclick location canceled";
	hintSilent parseText format["<t size='1.25' color='#ff6161'>Map location canceled</t>"];
	titletext ["","plain"];
	uisleep 6;
	hintSilent "";
	};
	
	_m = createMarker ["mrkrx",mappos];
	_m setMarkerShape "ELLIPSE";
	_m setMarkerSize [200,200];
	_m setMarkerBrush "DiagGrid";
	_m setMarkerAlpha .75;
	_m setMarkerColor "ColorGreen";
	
titletext ["","plain",0.25];
hintSilent parseText format["<t size='1.25' color='#44ff00'>Mapclick location successful</t>"];
uisleep 0.25;
hintSilent "";
titleText ['', 'BLACK OUT',1];
uisleep 0.25;
openmap [false,false];

_position = getMarkerPos "mrkrx";

_jumpTarget = createVehicle ["Land_JumpTarget_F", _position, [], 0, "NONE"];

enableRadio false;

unassignVehicle _unit;
_unit action ["EJECT", (vehicle _unit)];
uisleep 0.03;
_unit allowDamage false;
_unit setPos getMarkerPos "mrkrx";
[_unit,3000] call BIS_fnc_halo;
titleText ['', 'BLACK IN',4];
_unit spawn {uisleep 1; waitUntil {getPosATL _this select 2 < 200}; _this action ["openParachute"];};
_unit domove _position;

[playerSide, "HQ"] commandChat format ["%1: Pull the ripcord before height 300 meters!",name _unit];

waitUntil {((getPos _unit) select 2) < 200 || !alive _unit};

enableRadio true;

waitUntil {((getPos _unit) select 2) < 1 || !alive _unit};

uisleep 6; 

_unit allowDamage true;
	
deleteMarker "mrkrx";

deleteVehicle _jumpTarget;
