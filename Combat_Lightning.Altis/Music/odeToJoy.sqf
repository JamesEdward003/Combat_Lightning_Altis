// odeToJoy.sqf //
_source = _this select 0;

_odeToJoy={
	_source = _this select 0;
	_normal=0.4;
	_dot=_normal*1.5;
	_long=_normal*2;
	_short=_normal/2;
	

	["B",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["C",_normal,_source] call playNote;
	["D",_normal,_source] call playNote;
	["D",_normal,_source] call playNote;
	["C",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["B",_dot,_source] call playNote;
	["A",_short,_source] call playNote;
	["A",_long,_source] call playNote;
	
	["B",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["C",_normal,_source] call playNote;
	["D",_normal,_source] call playNote;
	["D",_normal,_source] call playNote;
	["C",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["A",_dot,_source] call playNote;
	["G",_short,_source] call playNote;
	["G",_long,_source] call playNote;
	
	["A",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["B",_short,_source] call playNote;
	["C",_short,_source] call playNote;
	["B",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["B",_short,_source] call playNote;
	["C",_short,_source] call playNote;
	["B",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["DL",_long,_source] call playNote;
	
	["B",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["C",_normal,_source] call playNote;
	["D",_normal,_source] call playNote;
	["D",_normal,_source] call playNote;
	["C",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["G",_normal,_source] call playNote;
	["A",_normal,_source] call playNote;
	["B",_normal,_source] call playNote;
	["A",_dot,_source] call playNote;
	["G",_short,_source] call playNote;
	["G",_long,_source] call playNote;
	
};

[_source] spawn _odeToJoy;
