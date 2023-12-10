// allRoundDefense.sqf //
private ["_pos", "_radius", "_unit", "_units", "_validUnits", "_grp", "_move_fnc1", "_count", "_move_fnc1", "_movePosArray", "_diff", "_degree", "_newPos", "_watchPos"];
_pos = _this select 0;
_radius = _this select 1;
_unit = _this select 2;
_grp = group _unit;
_units = units _grp;
_validUnits = [];
{
    if (vehicle _x == _x) then {
        _validUnits = _validUnits + [_x];
    };
} forEach _units;
hint format ["%1",_validUnits];
_count = count _validUnits;
if (_count == 0) exitWith {};

_move_fnc1 = {
	private ["_unit","_posArray","_movePos", "_watchPos"];
	_unit = _this select 0;
	_posArray = _this select 1;
	_movePos = _posArray select 0;
	_watchPos = _posArray select 1;
	_unit doMove _movePos;
	_unit moveTo _movePos;
	_unit setBehaviour "AWARE";
	_unit setCombatMode "RED";
	_unit setSpeedMode "NORMAL";
	_unit setUnitPos "MIDDLE";
	_unit doWatch _watchPos;
	_unit doFollow (leader _unit);
};

_diff = 360/_count;
_movePosArray = [];
for "_i" from 0 to (_count - 1) do {
	_degree = 1 + _i*_diff;
	_newPos = 	[[_radius*(sin _degree), _radius*(cos _degree), 0], [_pos select 0,_pos select 1, 0]] call BIS_fnc_vectorAdd;
	_watchPos = [[100*(sin _degree), 100*(cos _degree), 0], [_pos select 0, _pos select 1, 0]] call BIS_fnc_vectorAdd;
	_movePosArray = _movePosArray + [[_newPos, _watchPos]];
};
/*
for "_i" from 0 to (_count - 1) do {
	_unit = _validUnits select _i;
	[_unit, _movePosArray select _i] spawn _move_fnc1;

	if (daytime > 18.50 || daytime < 4.50) then {

	_unit spawn {

		while {alive _this} do {

				if ((((behaviour _this) == "STEALTH") || ((behaviour _this) == "COMBAT")) && !(_this hasWeapon "NVGoggles")) then  {_this addweapon "NVGoggles"};
				uisleep 10;
			};
		while {alive _this} do {

				if ((((behaviour _this) == "AWARE") || ((behaviour _this) == "SAFE")) && (_this hasWeapon "NVGoggles")) then  {_this removeweapon "NVGoggles"};
				uisleep 10;
			};
		};
	};
};
*/
//hint format ["%1",_movePosArray]; copyToClipboard format ["%1",_movePosArray];
_unit groupChat (selectRandom ["Form a circle.", "Watch all directions.", "360 Formation."]);

/*
_radius = 100;
_x and _y = "coordinates or the position of an object/marker";
_dir = random 360;
_pos = [(_x + (random _radius) * sin _dir), (_y + (random _radius) * cos _dir), 0];
unit doMove _pos;
*/
