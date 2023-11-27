params [
	"_mirror",
	"_surface","_camPos","_dir1","_camera"
];
_surface = toLower (format["%1surface",_mirror]);
_mirror setObjectTexture [0,"a3\structures_f\civ\infoboards\data\mapboard_default_co.paa"];

///////
//Set up and create the camera (mirror).
///////

_camPos = getPosATL _mirror;
_camPos set [2,((getPosATL _mirror) select 2) + 0.6];
_dir1 = (getDir _mirror) + 180;

_camera = "camera" camCreate _camPos;
_camera cameraEffect ["Internal","Front",_surface];
_camera camPreparePos _camPos;
_camera camPrepareTarget (getPos _mirror);
_camera camPrepareFOV 1;
_camera camCommitPrepared 0;

///////
//Run mirror effect.
///////

nul = [_mirror,_dir1,_camera,_camPos,_surface] spawn {
	params ["_mirror","_dir1","_camera","_camPos","_surface","_dir2"];
	while {!(isNull _camera)} do {
		waitUntil {(player distance _mirror) < 50};
		if (isNull _camera) exitWith {};
		_mirror setObjectTexture [0,format["#(argb,512,512,1)r2t(%1,1)",_surface]];
		while {((player distance _mirror) < 50) && (!(isNull _camera))} do {
			_dir2 = _dir1 - ((player getDir _mirror) - (getDir _mirror));
			_camera camPrepareTarget [
				(_camPos getPos [player distance _mirror,_dir2]) select 0,
				(_camPos getPos [player distance _mirror,_dir2]) select 1,
				_camPos select 2
			];
			_camera camCommitPrepared 0;
		};
		if (!(isNull _camera)) then {
			_mirror setObjectTexture [0,"a3\structures_f\civ\infoboards\data\mapboard_default_co.paa"];
		};
	};
};

_camera