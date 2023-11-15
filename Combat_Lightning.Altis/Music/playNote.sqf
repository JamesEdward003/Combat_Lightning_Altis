// playNote.sqf //
_source = _this select 0;

playNote={
	params ["_note",["_length",1],["_source",player]];
	_mySound="a3\Ui_F_Curator\Data\Sound\CfgSound\ping0";
	_pitch=1;
	
	switch (toUpper _note) do {
		case "DL": { _mySound=_mySound+"2"; _pitch=0.66740; };
		case "EL": { _mySound=_mySound+"2"; _pitch=0.74913; };
		case "FL": { _mySound=_mySound+"2"; _pitch=0.79368; };
		case "G": { _mySound=_mySound+"2"; _pitch=0.89090; };
		case "A": { _mySound=_mySound+"2" };
		case "B": { _mySound=_mySound+"2"; _pitch=1.12245; };
		case "C": { _mySound=_mySound+"2"; _pitch=1.18922; };
		case "D": { _mySound=_mySound+"2"; _pitch=1.33481; };
		case "E": { _mySound=_mySound+"2"; _pitch=1.49831; };
		case "F": { _mySound=_mySound+"2"; _pitch=1.58740; };
		default { hint "I don't know this note" };
	};
	
	_mySound=_mySound+".wss";
	_cTime=time+_length;
	playSound3d[_mySound, _source,false,_source,5,_pitch];
	waitUntil {time>_cTime};
};
uisleep 6;
[_source] execVM "Music\odeToJoy.sqf";

