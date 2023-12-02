////   ["_center", "_types", "_buildingRadius"] execVM "RandomHousePosition.sqf";   ////
private ["_center", "_types", "_buildingRadius"];

_center = _this select 0;
_types = _this select 1;
_buildingRadius = _this select 2;

RandomHousePosition = {
    params [_pos, _types, _radius];

    _allBuildings = nearestTerrainObjects [_pos, _types, _radius, false, true];
    _allPositions = [];
    _allBuildings apply {_allPositions append (_x buildingPos -1)};
    _rndPos = selectRandom _allPositions;
    missionNamespace setVariable ["RandomHousePosition",_rndPos];
};
[[BIS_CP_targetLocationPos, ["BUILDING","CHAPEL","CHURCH","FUELSTATION","HOSPITAL","HOUSE","LIGHTHOUSE"], 1000], RandomHousePosition] remoteExec ["call", 0];



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
