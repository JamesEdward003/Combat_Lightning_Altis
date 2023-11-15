//  "init_newunit.sqf"  //
_unit = _this;
/*****************************************************************
	following section to run only on server.
	Note: duplicate respective code in the pve in the init.sqf
******************************************************************/
if(isServer) then{
	[_unit] execFSM (BON_RECRUIT_PATH+"unit_lifecycle.fsm");
} else {
	bon_recruit_newunit = _unit;
	publicVariable "bon_recruit_newunit";
};
/*****************************************************************
	Client Stuff
******************************************************************/
_group = group (leader _unit);
_grpCount = (units group _unit) find _unit;
//_typename = _unit getVariable "codeName";
//_nameUnit = name _unit;
//_typename = lbtext [BON_RECRUITING_UNITLIST,_unit];
//hint format ["%1",_typename];
_classname 	= format ["%1", typeOf _unit];
_displayname = gettext (configfile >> "CfgVehicles" >> _className >> "displayName");

_text = toArray(str _group);
_text set[0,"**DELETE**"];
_text set[1,"**DELETE**"];
_text = _text - ["**DELETE**"];
_grp = toString(_text);

_varname = format ["%1_%2",_grp,_grpCount];

_unit setVehicleVarname _varname;

//[_unit, "", "", -1, ""] call BIS_fnc_setIdentity;

[_unit, _displayname] remoteExec ["setIdentity",groupOwner (group _unit)];

//_unit setIdentity _displayname;

_unit setUnitRank "SERGEANT";

_unit setMimic "neutral";

addswitchableunit _unit;

switch (side _unit) do {
	case west: {

		_unit execVM "loadouts_multiterrain.sqf";
		_unit execVM "loadouts_woodland.sqf";
		_unit execVM "LoadoutAdjustments.sqf";
		_unit execVM "UnlimitedAmmo.sqf";
		_unit execVM "SettingsAdjustments.sqf";
			
	};
	case east: {

		_unit execVM "LoadoutAdjustments.sqf";
		_unit execVM "UnlimitedAmmo.sqf";
		_unit execVM "SettingsAdjustments.sqf";
			
	};
	case resistance: {

		_unit execVM "LoadoutAdjustments.sqf";
		_unit execVM "UnlimitedAmmo.sqf";
		_unit execVM "SettingsAdjustments.sqf";
			
	};
	case civilian: {

		_unit execVM "LoadoutAdjustments.sqf";
		_unit execVM "UnlimitedAmmo.sqf";
		_unit execVM "SettingsAdjustments.sqf";
			
	};
};

_unit addAction ["<t color='#00FFFF'>Dismiss</t>",BON_RECRUIT_PATH+"dismiss.sqf",[],100,false,true,""];

_unit setUnitCombatMode "YELLOW";
_unit setUnitPosWeak "AUTO";
_unit allowfleeing 0;
_unit setBehaviour "AWARE";

//hintSilent parseText format["<t size='1.25' color='#FF5500'>Bon recruitable unit equipped and accounted for.</t>"];

//_displayNames = [];
//for "_i" from 0 to (count (units group player)) -1 do {
//_unit = (units group player) select _i;
//_classname  = format ["%1", typeOf _unit];
//_displayname = gettext (configfile >> "CfgVehicles" >> _className >> "displayName");
//_displayNames = _displayNames + [_displayName];};
//hint format ["%1",_displayNames]; copyToClipboard format ["%1",_displayNames];








