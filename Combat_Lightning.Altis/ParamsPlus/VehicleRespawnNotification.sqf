// VehicleRespawnNotification.sqf // [_vehicle] execVM "VehicleRespawnNotification.sqf";
private ["_vehicle","_vehicleSide","_cfgVeh","_displayName","_picture","_respawnName"];
    params [ ["_vehicle", objNull, [objNull]] ];
    
    if ( isNull _vehicle ) exitWith {};
    
    private _vehicleSide = [_vehicle, true] call bis_fnc_objectSide;
    private _cfgVeh = configfile >> "cfgvehicles" >> typeOf _vehicle;
    private _displayName = gettext (_cfgVeh >> "displayName");
    private _picture = (gettext (_cfgVeh >> "picture")) call bis_fnc_textureVehicleIcon;
    private _respawnName = format [localize "str_a3_bis_fnc_respawnmenuposition_grid",mapgridposition (position _vehicle)];
    [["RespawnVehicle",[_displayName, _respawnName, _picture]], "BIS_fnc_showNotification", _vehicleSide] call bis_fnc_mp;
