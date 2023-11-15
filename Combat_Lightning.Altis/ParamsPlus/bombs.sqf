//  paramsplus/bombs.sqf  //
//  null=[5,400,25,80] execvm "bombs.sqf"  //
//if (!isServer) exitWith {};
private ["_heli","_ammo","_ammotype","_height","_rounds","_spread","_pos","_bomb"];
_unit = _this select 0;
_actions = actionIDs _unit;
_array = [];

for [{_i= (count _actions)-1},{_i>-1},{_i=_i-1}] do {
     _params = _unit actionParams (_actions select _i);
     _array = _array + [(_params select 0)];
     };

if !(("<t color='#00FFFF'>Deploy Bombs</t>") in _array) then {

Bombs = _unit addAction ["<t color='#00FFFF'>Deploy Bombs</t>", {
     params ["_target", "_caller", "_actionId", "_arguments"];

_ammotype = _this select 3 select 0; // type of ammo
_height   = _this select 3 select 1; // height of drop
_rounds   = _this select 3 select 2; // how many
_spread   = _this select 3 select 3; // area

_pos  = screenToWorld [0.5,0.5];// land position 
if (!isnull cursortarget) then { _pos = getpos cursortarget};// building / object position

switch (_ammotype) do {
case 0:{_ammo = "R_57mm_HE"};
     case 1:{_ammo = "Sh_105_HE"};
     case 2:{_ammo = "Bo_GBU12_LGB"};
     case 3:{_ammo = "M_Stinger_AA"};
     case 4:{_ammo = "R_80mm_HE"};
     case 5:{_ammo = "ARTY_Sh_122_HE"};
     case 6:{_ammo = "Sh_85_AP"};
     case 7:{_ammo = "Bo_FAB_250"};
     case 8:{_ammo = "Grenade"};
     };

for "_x" from 1 to _rounds do {
 sleep random 0.8;
  _bomb = _ammo createVehicle [( _pos select 0)+(random _spread)-_spread/2, (_pos select 1)+(random _spread)-_spread/2,_height];
_bomb setVectorUp [0, 9, 0.1];
};
},
[5,400,25,80],
10,
false,
true,
"",
"isNull objectParent _this",
-1,
true,
"",
""];
};
