// create.sqf //
fnc_setVehicleName =
{
	params ["_unit", "_name"];
	missionNamespace setVariable [_name, _unit, true];
	[_unit, _name] remoteExec ["setVehicleVarName", 0, _unit];
};
_type = _this select 0;
_position = _this select 1;
_group = _this select 2;
_text = toArray(str _group);
_text set[0,"**DELETE**"];
_text set[1,"**DELETE**"];
_text = _text - ["**DELETE**"];
_grp = toString(_text);
_displayname = gettext (configfile >> "CfgVehicles" >> _type >> "displayName");
_groupNumber = count units _group + 1;
_varname = format ["%1_%2",_grp,_groupNumber];

//_unit = group player createUnit ["B_RangeMaster_F", position player, [], 0, "FORM"];
//_type createUnit format [[_position, _group, "addSwitchableUnit this; %1 = this", _varname]];
//type createUnit [position, group, init, skill, rank];

_unit = _group createUnit [_type, _position, [], 0, "NONE"];
[_unit, _varname] call fnc_setVehicleName;
_unit disableAi "RADIOPROTOCOL";
_unit setVariable ["LoadoutDone", true];
_unit execVM "SettingsAdjustments.sqf";
_unit execVM "LoadoutAdjustments.sqf";
[_unit,50] execFSM "AI_medic.fsm";

