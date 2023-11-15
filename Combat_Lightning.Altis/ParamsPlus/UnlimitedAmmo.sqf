// _unit execVM "UnlimitedAmmo.sqf"; //
private ["_unit","_BI_CP_UnlimitedAmmo"];
_BI_CP_UnlimitedAmmo = "BI_CP_UnlimitedAmmo" call BIS_fnc_getParamValue;
if (_BI_CP_UnlimitedAmmo isEqualTo 1) exitWith {};

_unit = _this;

_unit addEventHandler ["Reloaded", {
	params ["_unit", "_weapon", "_muzzle", ["_newMagazine", []], ["_oldMagazine", []]];
	private _magClass = _oldMagazine param [0, ""];
		if (_magClass == "") then {
			_magClass = _newMagazine param [0, ""];
		};
		_unit addMagazine _magClass;
}];

_unit addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	_unit execVM "UnlimitedAmmo.sqf";
}];

if (isPlayer _unit) then {

	[playerSide, "HQ"] commandChat format ["%1, Unlimited Ammo Enabled!",name _unit];

};

