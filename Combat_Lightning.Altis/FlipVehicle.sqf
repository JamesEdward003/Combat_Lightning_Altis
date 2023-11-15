// FlipVehicle.sqf //
private ["_vehicle", "_caller", "_actionId", "_arguments", "_normalVec"];
_vehicle = _this select 0;

_vehicle addAction ["Flip vehicle",{
	params ["_vehicle", "_caller", "_actionId", "_arguments"];
	_normalVec = surfaceNormal getPos _vehicle;
	if (!local _vehicle) then {
		[_vehicle,_normalVec] remoteExec ["setVectorUp",_vehicle];
	} else {
		_vehicle setVectorUp _normalVec;
	};
	_vehicle setPosATL [getPosATL _vehicle select 0, getPosATL _vehicle select 1, 0];
},[],1.5,true,true,"","!((vectorUp _target apply {abs _x toFixed 2}) isEqualTo ((surfaceNormal getPos _target) apply {abs _x toFixed 2}))",5];

hintSilent parseText format ["<t size='1.25' color='#00FFFF'>Flip Vehicle Action Installed!</t>"];
