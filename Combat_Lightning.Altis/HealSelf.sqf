// player addAction ["<t color='#00FFFF'>Heal Self</t>","HealSelf.sqf",[],-99,false,false,"","((_target == _this) and (getDammage _target) > 0.1)"]; //
private ["_target"];
_target = _this select 0;

if (isMultiplayer) then {
	_target addEventHandler ["Respawn", {
		private ["_unit","_dead"];
		_unit = (_this select 0);
		_unit addAction ["<t color='#00FFFF'>Heal Self</t>","healSelf.sqf",[],-99,false,false,"","((_target == _this) and (getDammage _target) > 0.1) and (getDammage _target) < 0.99)"];
	}
]};


_target playMove "AinvPknlMstpSlayWrflDnon_medic";

uisleep 6;
		
_target setDamage 0;

_target setUnconscious false;

_target setCaptive false;	
		
uisleep 1;

//hintSilent parseText format["<t>You healed %1</t>", _target];

_target commandChat format["Unit %1 healed himself", name _target];



//player addAction ["<t color='#00FFFF'>Heal Self</t>","HealSelf.sqf",[],-99,false,false,"","((_target == _this) and (getDammage _target) > 0.1)"];
