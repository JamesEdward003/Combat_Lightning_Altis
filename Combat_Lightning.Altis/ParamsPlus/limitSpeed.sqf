//  paramsplus/limitSpeed.sqf  //
_vehicle = _this select 0;
_speed = _this select 1;

_vehicle limitSpeed _speed;
(driver _vehicle) limitSpeed _speed;
(driver _vehicle) setBehaviour "CARELESS";
