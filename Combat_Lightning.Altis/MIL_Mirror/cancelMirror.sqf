params ["_mirror","_mirrorEHs","_mirrorArray","_newMirrorArray"];

_mirrorEHs = player getVariable "MirrorEHs";
if ((_mirrorEHs findIf {(_x select 0) == _mirror}) == -1) exitWith {};
_mirrorArray = _mirrorEHs select (_mirrorEHs findIf {(_x select 0) == _mirror});
_mirrorArray params ["_mirror","_hitPart","_explosion","_camera"];

_newMirrorArray = _mirrorEHs - [_mirrorArray];
player setVariable ["MirrorEHs",_newMirrorArray,false];

_mirror removeEventHandler ["HitPart",_hitPart];
_mirror removeEventHandler ["Explosion",_explosion];

_camera cameraEffect ["terminate","back",format["%1surface",_mirror]];
camDestroy _camera;