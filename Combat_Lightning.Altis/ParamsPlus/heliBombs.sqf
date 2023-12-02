////////   "ParamsPlus\heliBombs.sqf"  ////////
if !(("AirBombs" call BIS_fnc_getParamValue) isEqualTo 2) exitWith {};
private ["_heli"];
_heli = _this select 0;
_actions = actionIDs _heli;
_array = [];

uisleep 4;

hintSilent parseText format["<t size='1.25' color='#00FFFF'>Addaction HeliBombs!</t>"];
PAPABEAR=[playerSide,"HQ"]; PAPABEAR SideChat "Addaction HeliBombs!";

for [{_i= (count _actions)-1},{_i>-1},{_i=_i-1}] do {
	_params = _heli actionParams (_actions select _i);
	_array = _array + [(_params select 0)];
	};

if !(("<t color='#00FFFF'>Deploy Bombs</t>") in _array) then {

	_heli addAction ["<t color='#00FFFF'>Deploy Bombs</t>", {
		private ["_heli","_caller","_airEnd","_airName","_mrkrcolor"];
		params ["_heli","_caller","_actionId","_arguments"];
		_heli = _this select 0;
		_caller = _this select 1;
		_actionID = _this select 2;
		_arguments = _this select 3;
		_ammotype = _this select 3 select 0; // type of ammo
		_height   = _this select 3 select 1; // height of drop
		_rounds   = _this select 3 select 2; // how many
		_bombminrange = _this select 3 select 3; // min range
		_bombmaxrange = _this select 3 select 4; // max range

		_locationTxt = text nearestLocation [getPos _heli, ["NameCity","NameCityCapital","NameVillage","NameLocal","NameMarine"]];
		hintSilent parseText format["<t size='1.25' color='#00FFFF'>%1</t>",_locationTxt];

		_location = nearestLocation [getPos _heli, ["NameCity","NameCityCapital","NameVillage","NameLocal","NameMarine"]];
		_locationPos = locationPosition _location;

		[_locationPos] spawn DropBombs;
		
		_ammo = switch (_ammotype) do {
			case 0:{"R_57mm_HE"};
		    case 1:{"Sh_105_HE"};
		    case 2:{"Bo_GBU12_LGB"};//M_NLAW_AT_F//G_40mm_HE//R_80mm_HE//M_PG_AT//ammo_Missile_Cruise_01
		    case 3:{"M_Stinger_AA"};
		    case 4:{"R_80mm_HE"};
		    case 5:{"ARTY_Sh_122_HE"};
		    case 6:{"Sh_85_AP"};
		    case 7:{"M_RPG32_F"};
		    case 8:{"ammo_Missile_Cruise_01"};
		    };

		for "_i" from 1 to _rounds do {
		 	uisleep random 0.8;
		 	_newpos = [_locationPos, _bombminrange, _bombmaxrange, 0, 0, 0, 0] call BIS_fnc_findSafePos;
		  	_bomb = _ammo createVehicle [(_newpos select 0),(_newpos select 1),_height];
			_bomb setVectorUp [0, 9, 0.1];
		};
	},
	[8,400,25,floor (random 50) + 50,floor (random 300) + 100],
	10,
	false,
	true,
	"",
	"(('AirBombs' call BIS_fnc_getParamValue) isEqualTo 2)",		//"!(isNull objectParent _this)",
	-1,
	true,
	"",
	""];
};


DropBombs = { 
 
private ["_bombminrange","_bombmaxrange","_msgbomb1","_targetPos","_bombselect","_bombarray","_bombtype","_bombcount","_newpos"]; 
 
_targetPos = _this select 0; 
 
_bombminrange = floor (random 50) + 50; 
_bombmaxrange = floor (random 300) + 100; 
 
_bombselect = []; 
_bombarray = [["ammo_Missile_Cruise_01",[1,2,3,4,5]],["ammo_Missile_Cruise_01",[1,2,3,4,5,6,7]],["ammo_Missile_Cruise_01",[1,2,3,4,5,6,7,8,9,10]]]; 
_bombselect = _bombarray select (floor (random (count _bombarray))); 
_bombtype = _bombselect select 0; 
_bombcount = _bombselect select 1; 
sleep 5; 
{ 
 _newpos = [_targetPos, _bombminrange, _bombmaxrange, 0, 0, 0, 0] call BIS_fnc_findSafePos; 
 bomb = createVehicle [_bombtype, [(_newpos select 0),(_newpos select 1), 400], [], 0, "CAN_COLLIDE"]; 
 bomb setVectorUp [0, 9, 0.1];
 uisleep 2; 
} forEach _bombcount; 

};

