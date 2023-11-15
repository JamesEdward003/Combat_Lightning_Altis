/*
predicam.sqf

Parameters:
   Object to follow initially
   Horizontal camera distance to object 
   Angle from where the camera tracks the object (0 = same dir as object, 90 right, 180 back, 270 left)
   Vertical camera distance to object
   Delay between finishing camera object tracking and end of script execution
   Should the camera be destroyed once predicam script exits?  
   Preload camera before switching from current unit to a new one?



Once the script is running, you may change the target changing predicamunit global variable. You may change also relative position of the camera for the new unit changing predicampos global variable. predicampos structure is [Horizontal camera distance to object, angle, vertical distance to object]
To destroy the camera, set predicam = false
predicamready >= 2 means the last unit area has been preloaded
*/

private["_unit", "_rangex", "_ang", "_rangey", "_maxtime", "_return", "_ground", "_delay", "_posu", "_angf", "_pos", "_cam", "_timecur", "_asl1", "_vel", "_asl2", "_angf", "_posc", "_als3", "_alt", "_delaytofinish", "_preload"];


_unit          = _this select 0;
_rangex        = _this select 1;
_ang           = _this select 2;
_rangey        = _this select 3;
_maxtime       = _this select 4;
_delaytofinish = _this select 5;
_return        = _this select 6;
_preload       = _this select 7;

_ground = "logic" createVehicleLocal [0,0,0];
_delay = 0.05;
showCinemaBorder false;
_cam = "camera" camcreate [0, 0, 0];
_cam cameraeffect ["internal", "back"];

_posu = getPos _unit;
_angf = (getDir _unit) + _ang;
_pos = [(_posu select 0) + sin(_angf)*_rangex, (_posu select 1) + cos(_angf)*_rangex, (_posu select 2) + _rangey];


_cam camSetPos _pos;
_cam camSetTarget _unit;
_cam camSetFov 1.0;
_cam camCommit 0;

if ((date select 3) < 6 or (date select 3) > 19) then {camUseNVG true} else {camUseNVG false};

predicam = true;
predicamready = 0;
predicamunit = _unit;
predicampos = [_rangex, _ang, _rangey];
_timecur = 0.0;

_unit = predicamunit;

while {predicam && (!isNull _unit)} do
{
   _rangex = predicampos select 0;
   _ang = predicampos select 1;
   _rangey = predicampos select 2;

   _posu = getPos _unit;

   _asl1 = getPosASL _unit select 2;
   _vel = velocity _unit;
   _asl2 = _asl1+(_vel select 2)*_delay + _rangey;
   _angf = (getDir _unit)+_ang;
   _posc = [(_posu select 0)+(_vel select 0)*_delay+sin(_angf)*_rangex, (_posu select 1)+(_vel select 1)*_delay+cos(_angf)*_rangex,_asl2];
   _ground setPos [_posc select 0, _posc select 1, 0];
   _asl3 = getPosASL _ground select 2;
   _alt = _asl2 - _asl3;
   _posc = [_posc select 0, _posc select 1, _alt];
   _cam camSetPos _posc;
   _cam camCommit (_delay+0.5);
   sleep _delay;

   if ((_unit isNotEqualTo predicamunit) && (predicamready isEqualTo 0) && !isNull _unit) then
   {
      predicamready = 1;
      [_preload] spawn 
      {
         if (_this select 0) then
         {
            waitUntil {preloadCamera getPos predicamunit};
         };
         predicamready = 2;
      };
   };

   if (predicamready == 2) then
   {
      predicamready = 3;
      []spawn 
      {
         sleep 1;
         predicamready = 0;
      };
      _unit = predicamunit;
      _posu = getPos _unit;
      _angf = (getDir _unit) + _ang;
      _pos = [(_posu select 0) + sin(_angf)*_rangex, (_posu select 1) + cos(_angf)*_rangex, (_posu select 2) + _rangey];

      _cam camSetPos _pos;
      _cam camSetTarget _unit;
      _cam camSetFov 1.0;
      _cam camCommit 0;
   };
};

sleep _delaytofinish;

if (_return) then
{
   _cam cameraeffect ["terminate", "back"];
};

camDestroy _cam;
deleteVehicle _ground;
