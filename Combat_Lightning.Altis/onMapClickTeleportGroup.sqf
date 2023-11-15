////////////////////////////////////////////
//  execVM "onMapClickTeleportGroup.sqf"; //
////////////////////////////////////////////
private ["_varname"];
uisleep 0.25;
location = false;
openmap [true,false];
titleText["Map location", "PLAIN DOWN"];
PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, set a location", name player];

if (getMarkerColor "Marker" == "ColorBlue") then {deleteMarker "Marker"};

onMapSingleClick "onMapSingleClick ''; mappos = _pos; location = true";		
waitUntil {sleep 1; (!visiblemap OR location OR !alive player)};
	if (!location OR !alive player) exitWith {
	mappos = nil;
	PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Map location canceled";
	hintSilent parseText format ["<t size='1.25' color='#ff0000'>Map location canceled</t>"];
	titletext ["","plain"];
	};

	for "_i" from 0 to (count (units group player) - 1) do {
		_unit = (units group player) select _i;
		_unit setPos mappos;
		uisleep 0.1;
	};

//	{_x setPos mappos;uisleep 0.1;} forEach units group player; 

	_null=[position player,10,player] execVM "allRoundDefense.sqf";

	_varname = createMarkerLocal ["Marker", position player];
	_varname setMarkerTypeLocal "mil_dot";
	_varname setMarkerColorLocal "ColorBlue";
	_varname setMarkerSizeLocal [1,1];

titletext ["","plain",0.2];
hintSilent parseText format ["<t size='1.25' color='#00FFFF'>Mapclick location successful</t>"];
uisleep 2;
hintSilent "";
openmap [false,false];

uisleep 6;
deleteMarker "Marker";
