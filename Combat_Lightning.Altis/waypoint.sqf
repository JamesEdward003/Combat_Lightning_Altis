// waypoint.sqf //
private ["_blinky","_varname","_wp"];
uisleep 0.25;
location = false;
openmap [true,false];
titleText ['<t color=''#ffdd22'' size=''1''>MAPCLICK COORDINATES FOR A QUICK MOVE WAYPOINT!</t><br/>***********', 'PLAIN DOWN', -1, true, true];
PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat format ["On mapclick, %1, mark location for quick movement", name player];

if (getMarkerColor "Marker" == "ColorBlack") then {deleteMarker "Marker"};

onMapSingleClick "onMapSingleClick ''; mappos = _pos; location = true";     
waitUntil {sleep 1; (!visiblemap OR location OR !alive player)};
    if (!location OR !alive player) exitWith {
    mappos = nil;
    PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Quick movement canceled";
    hintSilent parseText format ["<t size='1.25' color='#ff0000'>Quick movement canceled</t>"];
    titletext ["","plain"];
    uisleep 16;
    hintSilent "";
    };

    for "_i" from count waypoints (group player) - 1 to 0 step -1 do
    {
        deleteWaypoint [(group player), _i];
    };

    _blinky = "Land_HelipadEmpty_F" createVehicle mappos;

    _wp = (group player) addWaypoint [getPos _blinky, 0];
    _wp setWaypointType "GUARD";
    _wp setWaypointBehaviour "AWARE";
    _wp setWaypointFormation "WEDGE";
    _wp setWaypointSpeed "NORMAL";

    (group player) setCombatMode "BLUE";
    (group player) setSpeedMode "FULL";
    {_x setUnitPos "UP"; _x disableAi "autoCombat";  _x disableAi "autoTarget"} foreach units (group player);
    (group player) allowfleeing 0;
    (group player) setBehaviourStrong "AWARE";

    _varname = createMarkerLocal ["Marker", _blinky];
    _varname setMarkerTypeLocal "mil_dot";
    _varname setMarkerColorLocal "ColorBlue";
    _varname setMarkerSizeLocal [1,1];

titletext ["","plain",0.2];
hintSilent parseText format ["<t size='1.25' color='#00FFFF'>Mapclick location successful</t>"];
uisleep 2;
hintSilent "";
openmap [false,false];

uisleep 16;
deleteMarker "Marker";
deleteVehicle _blinky;

