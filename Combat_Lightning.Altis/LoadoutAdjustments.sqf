///  	_unit execVM "LoadoutAdjustments.sqf";	///
if ( "BI_CP_LoadoutAdjustments" call BIS_fnc_getParamValue isEqualTo 1 ) exitWith {};
private ["_unit","_nvList","_nv","_muzzleList","_ml","_ldList"];
params ["_unit"];

waitUntil { !isNil {_unit getVariable "LoadoutDone"} };

_nvList = ["NVGoggles","NVGoggles_INDEP","NVGoggles_OPFOR","NVGoggles_tna_F","NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","O_NVGoggles_ghex_F","NVGoggles","O_NVGoggles_hex_F","O_NVGoggles_urb_F","Integrated_NVG_F","Integrated_NVG_TI_0_F","Integrated_NVG_TI_1_F"];
// NV - Standardize usage among team to simplify add and remove night and day.

_muzzleList = ["muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_H_SW","muzzle_snds_acp","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","muzzle_snds_93mmg","muzzle_snds_93mmg_tan","muzzle_snds_570","muzzle_snds_H_khk_F","muzzle_snds_H_snd_F","muzzle_snds_m_khk_F","muzzle_snds_m_snd_F","muzzle_snds_58_blk_F","muzzle_snds_58_wdm_F","muzzle_snds_58_ghex_F","muzzle_snds_58_hex_F","muzzle_snds_B_khk_F","muzzle_snds_B_snd_F","muzzle_snds_65_TI_blk_F","muzzle_snds_65_TI_hex_F","muzzle_snds_65_TI_ghex_F","muzzle_snds_H_MG_blk_F","muzzle_snds_H_MG_khk_F","muzzle_snds_B_lush_F","muzzle_snds_B_arid_F"];
// Muzzles - muzzle_snds_H for rifle and muzzle_snds_acp for pistol used almost exclusively to simplify add and remove night and day.

_ldList = ["Binocular","Laserdesignator","Laserdesignator_02","Laserdesignator_03","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F"];
// Exclude Rangefinder from _ldList to be given to the ai sharpshooter, marksman, sniper and anti-tank for spotting purposes.
// "Rangefinder",

if (!(isPlayer _unit)) then {
	for "_i" from 0 to count _ldList -1 do {
		_ld = _ldList select _i;
		if (([_unit, _ld] call BIS_fnc_hasItem) isEqualTo true) then {		
			_unit removeMagazineGlobal "laserbatteries";
			_unit removeWeaponGlobal _ld;
		}	
	};
} else {
	if ((_unit getSlotItemName 617) isEqualTo "") then {
		_unit addMagazineGlobal "laserbatteries";
		_unit addWeaponGlobal "Laserdesignator";
	};
};

//if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then // day time == false

if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo true) then // day time == true
{
	if (([_unit, "G_Diving"] call BIS_fnc_hasItem) isEqualTo true) then {
		
		_unit unassignItem "G_Diving";
		_unit unLinkItem "G_Diving";
		_unit removeItem "G_Diving";
		_unit addItem "G_Goggles_VR";
		_unit assignItem "G_Goggles_VR";
		_unit linkItem "G_Goggles_VR";		
	};
	for "_i" from 0 to count _nvList -1 do {
		_nv = _nvList select _i;
		if (([_unit, _nv] call BIS_fnc_hasItem) isEqualTo true) then {
					
			_unit unassignItem _nv;	
			_unit unLinkItem _nv;
			_unit removeItem _nv;
			_unit removeWeapon _nv;				
		};	
	};
	for "_i" from 0 to count _muzzleList -1 do {
		_ml = _muzzleList select _i;
		if (([_unit, _ml] call BIS_fnc_hasItem) isEqualTo true) then {
				
			_unit unassignItem _ml;
			_unit unLinkItem _ml;
			_unit removePrimaryWeaponItem _ml;	
			_unit removeHandgunItem _ml;					
		};	
	};
} else {
	if (([_unit, "G_Goggles_VR"] call BIS_fnc_hasItem) isEqualTo true) then {
		
		_unit unassignItem "G_Goggles_VR";
		_unit unLinkItem "G_Goggles_VR";
		_unit removeItem "G_Goggles_VR";
		_unit addItem "G_Diving";
		_unit assignItem "G_Diving";	
		_unit linkItem "G_Diving";
	};
	if (([_unit, "NVGoggles"] call BIS_fnc_hasItem) isEqualTo false) then {

		_unit addItem "NVGoggles";
		_unit assignItem "NVGoggles";
		_unit linkItem "NVGoggles";		
	};	
	if (([_unit, "muzzle_snds_H"] call BIS_fnc_hasItem) isEqualTo false) then {
			
		_unit addItem "muzzle_snds_H";
		_unit assignItem "muzzle_snds_H";
		_unit linkItem "muzzle_snds_H";		
		_unit addPrimaryWeaponItem "muzzle_snds_H";		
	};	
	if (([_unit, "muzzle_snds_acp"] call BIS_fnc_hasItem) isEqualTo false) then {
			
		_unit addItem "muzzle_snds_acp";
		_unit assignItem "muzzle_snds_acp";
		_unit linkItem "muzzle_snds_acp";	
		_unit addHandgunItem "muzzle_snds_acp";			
	};	
};

if (isMultiPlayer) then
{	
	_unit addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		_unit execVM "ParamsPlus\LoadoutAdjustments.sqf";
	}];
};

_unit setVariable ["LoadoutAdjustmentsDone", true];

if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {_unit action ["nvGoggles", _unit]};

if (isPlayer _unit) then {

	[playerSide, "HQ"] commandChat "Loadout Adjustments Done!";

};

