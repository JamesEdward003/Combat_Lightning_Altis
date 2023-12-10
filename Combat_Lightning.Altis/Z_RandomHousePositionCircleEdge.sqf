////   ["_marker", "_perimeter", "_placedUnit"] execVM "Z_RandomHousePositionCircleEdge.sqf";   ////
waitUntil {!isNil "BIS_CP_initDone"};
private ["_zRef","_zSize","_zDir","_zRect","_zPos","_perimeter","_posVector"];
_zRef = _this select 0;
_perimeter = if (count _this > 1) then {_this select 1} else {false};
_placedUnit = if (count _this > 2) then {_this select 2} else {objNull};


switch (typeName _zRef) do {
   case "STRING" : {
       if ((markerShape _zRef) in ["RECTANGLE","ELLIPSE"]) then {
           _zSize = markerSize _zRef;
           _zDir = markerDir _zRef;
           _zRect = (markerShape _zRef) == "RECTANGLE";
           _zPos = markerPos _zRef;
       };
   };
   case "OBJECT" : {
       if !((triggerArea _zRef) isEqualTo []) then {
           _zSize = triggerArea _zRef;
           _zDir = _zSize select 2;
           _zRect = _zSize select 3;
           _zPos = getPos _zRef;
       };
   };
};


if (isNil "_zSize") exitWith {[]};


private ["_x","_y","_a","_b","_rho","_phi","_x1","_x2","_y1","_y2"];
if (_zRect) then {
   _x = _zSize select 0;
   _y = _zSize select 1;
   _a = _x*2;
   _b = _y*2;


   if (_perimeter) then {
       _rho = random (2*(_a + _b));


       _x1 = (_rho min _a);
       _y1 = ((_rho - _x1) min _b) max 0;
       _x2 = ((_rho - _x1 - _y1) min _a) max 0;
       _y2 = ((_rho - _x1 - _y1 - _x2) min _b) max 0;
       _posVector = [(_x1 - _x2) - _x, (_y1 - _y2) - _y, 0];
   } else {
       _posVector = [random(_a) - _x, random(_b) - _y, 0];
   };
} else {
   _rho = if (_perimeter) then {1} else {random 1};
   _phi = random 360;
   _x = sqrt(_rho) * cos(_phi);
   _y = sqrt(_rho) * sin(_phi);


   _posVector = [_x * (_zSize select 0), _y * (_zSize select 1), 0];
};


_posVector = [_posVector, -_zDir] call BIS_fnc_rotateVector2D;


_zPosFinal = _zPos vectorAdd _posVector;

if (!isNull _placedUnit) then {

    RandomHousePosition = {
        private ["_pos", "_types", "_radius"];
        params ["_pos", "_types", "_radius"];

        _allBuildings = nearestTerrainObjects [_pos, _types, _radius, false, true];
        _allPositions = [];
        _allBuildings apply {_allPositions append (_x buildingPos -1)};
        _rndPos = selectRandom _allPositions;
        if (_rndPos isEqualTypeArray [0,0,0]) then {
            missionNamespace setVariable ["RandomHousePosition",_rndPos];
        } else {
            hintSilent "[]";
        };
    };
    [[_zPosFinal, ["BUILDING","CHAPEL","CHURCH","FUELSTATION","HOSPITAL","HOUSE","LIGHTHOUSE"], 100], RandomHousePosition] remoteExec ["call", 0];

    if (isNil "RandomHousePosition") exitWith {hintSilent "[No position!]";[[_zPosFinal, ["BUILDING","CHAPEL","CHURCH","FUELSTATION","HOSPITAL","HOUSE","LIGHTHOUSE"], 100], RandomHousePosition] remoteExec ["call", 0];};

        _rndPos = missionNamespace getVariable "RandomHousePosition";

    if (_rndPos isEqualTypeArray [0,0,0]) then {
        _placedUnit setVehiclePosition [_rndPos, [], 0, "CAN_COLLIDE"];
        _placedUnit setCaptive true;
        _placedUnit disableAi "TARGET";
        missionNamespace setVariable ["RandomHousePosition",nil];
    } else {
        hintSilent "[No position!]";
        missionNamespace setVariable ["RandomHousePosition",nil];
    };

} else {

    hintSilent "[No unit!]";
};

//debug: call{_cursorTarget = typeOf cursorTarget; hint format ["%1",([configFile >> "CfgVehicles" >> _cursorTarget, true] call BIS_fnc_returnParents)];copyToClipboard format ["%1",([configFile >> "CfgVehicles" >> _cursorTarget, true] call BIS_fnc_returnParents)];["ao_marker", true, player] execVM "Z_RandomHousePositionCircleEdge.sqf";};

//this setVehiclePosition [[14633.7,16798.5,0.125], ["scout_intel_1","scout_intel_2","scout_intel_3","scout_intel_4"], 0, "CAN_COLLIDE"];
//["ao_marker", true, this] execVM "Z_RandomHousePositionCircleEdge.sqf";
/*
    "BUILDING"
    "BUNKER"
    "BUSH"
    "BUSSTOP"
    "CHAPEL"
    "CHURCH"
    "CROSS"
    "FENCE"
    "FOREST BORDER"
    "FOREST SQUARE"
    "FOREST TRIANGLE"
    "FOREST"
    "FORTRESS"
    "FOUNTAIN"
    "FUELSTATION"
    "HIDE"
    "HOSPITAL"
    "HOUSE"
    "LIGHTHOUSE"
    "MAIN ROAD"
    "POWER LINES"
    "POWERSOLAR"
    "POWERWAVE"
    "POWERWIND"
    "QUAY"
    "RAILWAY"
    "ROAD"
    "ROCK"
    "ROCKS"
    "RUIN"
    "SHIPWRECK"
    "SMALL TREE"
    "STACK"
    "TOURISM"
    "TRACK"
    "TRAIL"
    "TRANSMITTER"
    "TREE"
    "VIEW-TOWER"
    "WALL"
    "WATERTOWER"
*/
