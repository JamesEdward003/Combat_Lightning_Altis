_unit = _this select 0;

_unit action ["eject",vehicle _unit];
sleep 2;

hint format["%1 has been dismissed",getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayname")];
sleep 2;

deleteVehicle _unit;
sleep 8;

hint "";
