///////  _unit execVM "loadouts_multiterrain.sqf";  ///////
if ( "BI_CP_loadouts_mtp" call BIS_fnc_getParamValue isEqualTo 1 ) exitWith {};

/*
B_W_Soldier_SL_F (Scramble_1)
B_W_Soldier_F (Scramble_2)
B_W_Soldier_LAT_F (Scramble_3)
B_W_soldier_M_F (Scramble_4)
B_W_Soldier_TL_F (Scramble_5)
B_W_Soldier_AR_F (Scramble_6)
B_W_Soldier_A_F (Scramble_7)
B_W_Medic_F (Scramble_8)
*/

private ["_unit"];

_unit = _this;

switch (typeOf _unit) do {

	case "B_W_Soldier_SL_F": {	//	GRENADE-LAUNCHER/MINE-DETECTOR/LASER-DESIGNATOR/DEMO-CHARGE EQUIPPED SQUAD LEADER "WhiteHead_14","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToUniform "Laserbatteries";
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "DemoCharge_Remote_Mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "11Rnd_45ACP_Mag";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_14","male11eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

	case "B_W_Soldier_F": {	//	GRENADE-LAUNCHER/TOOL-KIT/RANGE-FINDER EQUIPPED RIFLEMAN "WhiteHead_19","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 4 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShellBlue";};
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 8 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_19","male11eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

	case "B_W_Soldier_LAT_F": {	//	GRENADE-LAUNCHER/MINE-DETECTOR/RANGE-FINDER/PCML EQUIPPED RIFLEMAN (AT) "AsianHead_A3_01","male04eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "bipod_02_F_arid";
_unit addWeapon "launch_NLAW_F";
_unit addSecondaryWeaponItem "NLAW_F";
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellOrange";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "FirstAidKit";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "MineDetector";
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "NLAW_F";};
_unit addHeadgear "H_Booniehat_mcamo";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"AsianHead_A3_01","male04eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

	case "B_W_soldier_M_F": {	//	MXM/LASER-DESIGNATOR/UAV/TOOL-KIT EQUIPPED MARKSMAN "WhiteHead_16","male08eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MXM_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "bipod_02_F_lush";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator_01_khk_F";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToVest "SmokeShellPurple";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "HandGrenade";};
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_16","male08eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

	case "B_W_Soldier_TL_F": {	//	GRENADE-LAUNCHER/DEMO-CHARGE/CHEMICAL-DETECTOR/UAV/RANGE-FINDER EQUIPPED TEAM LEADER "WhiteHead_10","male05eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 6 do {_unit addItemToVest "SmokeShellRed";};
for "_i" from 1 to 2 do {_unit addItemToVest "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ChemicalDetector_01_watch_F";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_10","male05eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

	case "B_W_Soldier_AR_F": {	//	MXM/UAV/TOOLKIT/MINE-DETECTOR/RANGE-FINDER EQUIPPED AUTORIFLEMAN "WhiteHead_18","male06eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MXM_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "bipod_02_F_lush";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "MineDetector";
for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellPurple";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "SmokeShellPurple";};
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_18","male06eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

	case "B_W_Soldier_A_F": {	// MXC/UAV/MINE-DETECTOR/CHEMICAL-DETECTOR/RANGE-FINDER AMMO BEARER "AfricanHead_03","male10eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MXC_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "MineDetector";
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 3 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 6 do {_unit addItemToVest "SmokeShellYellow";};
for "_i" from 1 to 12 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "NLAW_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ChemicalDetector_01_watch_F";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"AfricanHead_03","male10eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

	case "B_W_Medic_F": {	//	EBR/MEDI-KIT/UAV/MINE-DETECTOR/RANGE-FINDER EQUIPPED COMBAT LIFE SAVER "AfricanHead_02","male02eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "srifle_EBR_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "20Rnd_762x51_Mag";
_unit addPrimaryWeaponItem "bipod_01_F_khk";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 5 do {_unit addItemToVest "20Rnd_762x51_Mag";};
for "_i" from 1 to 8 do {_unit addItemToVest "SmokeShell";};
_unit addItemToBackpack "Medikit";
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "20Rnd_762x51_Mag";};
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"AfricanHead_02","male02eng"] call BIS_fnc_setIdentity;
[_unit,"EAF_5thRegiment"] call BIS_fnc_setUnitInsignia;
};

/*
B_Soldier_SL_F (Ramble_1)
B_soldier_AR_F (Ramble_2)
B_medic_F (Ramble_3)
B_Soldier_GL_F (Ramble_4)
B_Soldier_GL_F (Ramble_5)
B_soldier_M_F (Ramble_6)
B_soldier_AT_F (Ramble_7)
B_medic_F (Ramble_8)
*/

	case "B_Soldier_SL_F": {	//	GRENADELAUNCHER/TOOLKIT/MINEDETECTOR/LASERDESIGNATOR/UAV EQUIPPED SQUAD LEADER "WhiteHead_19","male02eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 3 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";
_unit addItemToBackpack "11Rnd_45ACP_Mag";
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Cap_usblack";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_19","male02eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_soldier_AR_F": {	//	GRENADELAUNCHER/RANGEFINDER/UAV EQUIPPED AUTORIFLEMAN "WhiteHead_08","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 4 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShellYellow";};
for "_i" from 1 to 4 do {_unit addItemToVest "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "SmokeShellYellow";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_08","male11eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_medic_F": {	//	MEDIKIT/RANGEFINDER/UAV EQUIPPED Combat Life Saver "WhiteHead_17","male09eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "srifle_EBR_F";
_unit addPrimaryWeaponItem "muzzle_snds_B";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "20Rnd_762x51_Mag";
_unit addPrimaryWeaponItem "bipod_02_F_arid";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
for "_i" from 1 to 6 do {_unit addItemToVest "20Rnd_762x51_Mag";};
_unit addItemToBackpack "Medikit";
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "SmokeShell";};
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_17","male09eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_Soldier_GL_F": {	//	GRENADELAUNCHER/RANGEFINDER/UAV EQUIPPED Grenadier "WhiteHead_15","male08eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 4 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShellYellow";};
for "_i" from 1 to 4 do {_unit addItemToVest "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShellYellow";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetSpecB_paint2";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_15","male08eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_soldier_M_F": {	//	MINEDETECTOR/RANGEFINDER/UAV EQUIPPED Marksman "WhiteHead_14","male09eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MXM_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "bipod_02_F_lush";
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_mtp";
_unit addBackpack "B_AssaultPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "MineDetector";
for "_i" from 1 to 4 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShellBlue";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "APERSMine_Range_Mag";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShellBlue";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetSpecB_snakeskin";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_14","male09eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_soldier_LAT_F": {	//	GRENADELAUNCHER/PCML/MINEDETECTOR/RANGEFINDER/UAV EQUIPPED Rifleman (LAT) "WhiteHead_14","male09eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "bipod_02_F_arid";
_unit addWeapon "launch_NLAW_F";
_unit addSecondaryWeaponItem "NLAW_F";
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellOrange";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "MineDetector";
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "NLAW_F";};
_unit addHeadgear "H_Booniehat_mcamo";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_14","male09eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_soldier_AT_F": {	//	GRENADELAUNCHER/PCML/MINEDETECTOR/RANGEFINDER/UAV EQUIPPED Rifleman (LAT) "WhiteHead_14","male09eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "bipod_02_F_arid";
_unit addWeapon "launch_NLAW_F";
_unit addSecondaryWeaponItem "NLAW_F";
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellOrange";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "MineDetector";
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "NLAW_F";};
_unit addHeadgear "H_Booniehat_mcamo";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "I_E_UavTerminal";
_unit linkItem "O_NVGoggles_grn_F";

comment "Set identity";
[_unit,"WhiteHead_17","male06eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_officer_F": {	//	GRENADE LAUNCHER/LASERDESIGNATOR EQUIPPED OFFICER "WhiteHead_08","male09eng"

comment "Exported from Arsenal by DIEHARD";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_Katiba_GL_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_green";
_unit addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "Laserbatteries";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "UGL_FlareGreen_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareRed_F";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_green";};
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_MilCap_mcamo";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles";

comment "Set identity";
[_unit,"WhiteHead_08","male09eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_Soldier_TL_F": {	//	GRENADE LAUNCHER/LASERDESIGNATOR EQUIPPED TEAM LEADER "WhiteHead_08","male09eng"

comment "Exported from Arsenal by DIEHARD";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_Katiba_GL_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_green";
_unit addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "Laserbatteries";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "UGL_FlareGreen_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareRed_F";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_green";};
_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_Cap_usblack";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles";

comment "Set identity";
[_unit,"WhiteHead_08","male09eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_recon_JTAC_F": {	//	GRENADE LAUNCHER/LASERDESIGNATOR EQUIPPED JTAC "WhiteHead_08","male02eng"

comment "Exported from Arsenal by DIEHARD";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_Katiba_GL_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_green";
_unit addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "Laserbatteries";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "UGL_FlareGreen_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareRed_F";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_green";};
_unit addHeadgear "H_Cap_usblack";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles";

comment "Set identity";
[_unit,"WhiteHead_08","male02eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_Soldier_F": {	//	GRENADE LAUNCHER/LASERDESIGNATOR EQUIPPED Rifleman "WhiteHead_08","male08eng"

comment "Exported from Arsenal by DIEHARD";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_mag";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareGreen_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareRed_F";};
for "_i" from 1 to 7 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShell";};
_unit addHeadgear "H_Cap_usblack";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles";

comment "Set identity";
[_unit,"WhiteHead_08","male08eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_soldier_repair_F": {	//	GRENADE LAUNCHER/LASERDESIGNATOR/MINE DETECTOR/TOOLKIT EQUIPPED Repair Specialist "WhiteHead_08","male07eng"

comment "Exported from Arsenal by DIEHARD";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_mag";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareGreen_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareRed_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
_unit addHeadgear "H_Cap_usblack";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles";

comment "Set identity";
[_unit,"WhiteHead_08","male07eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

/*
B_Captain_Pettka_F (Gamble_1)
B_CTRG_soldier_AR_A_F (Gamble_2)
B_Story_Protagonist_F (Gamble_3)
B_Story_Pilot_F (Gamble_4)
B_Story_SF_Captain_F (Gamble_5)
B_CTRG_soldier_engineer_exp_F (Gamble_6)
B_CTRG_soldier_GL_LAT_F (Gamble_7)
B_CTRG_soldier_M_medic_F (Gamble_8)
*/

	case "B_Captain_Pettka_F": { 		//  Pettka Grenadier "Whitehead_02","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Beret_Colonel";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"Whitehead_02","male11eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_CTRG_soldier_AR_A_F": {	//  McKay - Autorifleman "WhiteHead_04","male06eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";
_unit addItemToBackpack "11Rnd_45ACP_Mag";
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_04","male06eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_Story_Protagonist_F": {	//  Kerry "WhiteHead_03","male05eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";
_unit addItemToBackpack "11Rnd_45ACP_Mag";
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_03","male05eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_Story_Pilot_F": {	//  Larkin "Default","male07eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "LMG_Mk200_F";
_unit addPrimaryWeaponItem "optic_Aco";
_unit addPrimaryWeaponItem "200Rnd_65x39_cased_Box";
_unit addWeapon "launch_O_Titan_short_F";
_unit addSecondaryWeaponItem "Titan_AT";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
_unit addItemToVest "200Rnd_65x39_cased_Box";
for "_i" from 1 to 4 do {_unit addItemToVest "SmokeShellOrange";};
_unit addItemToVest "200Rnd_65x39_cased_Box_Tracer";
for "_i" from 1 to 4 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "Titan_AT";
for "_i" from 1 to 2 do {_unit addItemToBackpack "Titan_AP";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
_unit addHeadgear "H_HelmetB";
_unit addGoggles "G_Combat";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles";

comment "Set identity";
[_unit,"WhiteHead_06","male07eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_Story_SF_Captain_F": {	//  Captain Miller  -  Sharpshooter "WhiteHead_22_a","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "srifle_LRR_camo_F";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "7Rnd_408_Mag";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToUniform "SmokeShellBlue";};
_unit addItemToUniform "SmokeShellGreen";
for "_i" from 1 to 7 do {_unit addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToVest "7Rnd_408_Mag";};
for "_i" from 1 to 4 do {_unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
_unit addItemToVest "SmokeShell";
for "_i" from 1 to 4 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShell";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "7Rnd_408_Mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "MiniGrenade";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "11Rnd_45ACP_Mag";};
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_22_a","male11eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_CTRG_soldier_engineer_exp_F": {		//  Hardy - Explosives_Specialist "WhiteHead_07","male08eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_07","male08eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_CTRG_soldier_GL_LAT_F": {		//  Northgate - GL/LAT "WhiteHead_11","male02engb"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "launch_NLAW_F";
_unit addSecondaryWeaponItem "NLAW_F";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_Carryall_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
_unit addItemToBackpack "NLAW_F";
//_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_11","male02engb"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_CTRG_soldier_M_medic_F": {		//  James - Combat_Life_Saver "WhiteHead_06","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 7 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
_unit addItemToBackpack "Medikit";
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_06","male11eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_Captain_Jay_F": {	//  Captain Jay "WhiteHead_08","male09eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_Black_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_black_mag";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_black_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "3Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
//_unit addItemToBackpack "Medikit";
_unit addItemToBackpack "30Rnd_65x39_caseless_black_mag";
_unit addItemToBackpack "11Rnd_45ACP_Mag";
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_08","male09eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

	case "B_CTRG_Sharphooter_F": {	//  Captain O'Connor "WhiteHead_17","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "srifle_DMR_02_camo_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_AMS";
_unit addPrimaryWeaponItem "10Rnd_338_Mag";
_unit addPrimaryWeaponItem "bipod_01_F_blk";
_unit addWeapon "hgun_Pistol_heavy_01_MRD_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addWeapon "Rangefinder";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
for "_i" from 1 to 5 do {_unit addItemToVest "10Rnd_338_Mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
_unit addItemToBackpack "Laserbatteries";
_unit addHeadgear "H_Beret_02";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"WhiteHead_17","male11eng"] call BIS_fnc_setIdentity;
[_unit,"111thID"] call BIS_fnc_setUnitInsignia;
};

/*
	case "B_Captain_Dwarden_F": {	//  Dwarden_Dress "Dwarden","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "SMG_03_TR_black"; // "arifle_MX_GL_F"; // 

_unit addPrimaryWeaponItem "50Rnd_570x28_SMG_03"; // "30Rnd_65x39_caseless_mag"; //
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 3 do {_unit addItemToVest "50Rnd_570x28_SMG_03";}; // "30Rnd_65x39_caseless_mag";}; // 
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "1Rnd_SmokeYellow_Grenade_shell";};
_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_Beret_gen_F";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"Dwarden","male11eng"] call BIS_fnc_setIdentity; // Dwarden // Default 
[_unit,"Curator"] call BIS_fnc_setUnitInsignia;
};
*/
	case "B_Captain_Dwarden_F": {	//  Dwarden_Scout "Dwarden","male11eng"

comment "Exported from Arsenal by RENFRO";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _unit) exitWith {};

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "arifle_MX_GL_F"; // "SMG_03_TR_black";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_mag"; // "50Rnd_570x28_SMG_03";
_unit addPrimaryWeaponItem "3Rnd_HE_Grenade_shell";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_mtp";
_unit addBackpack "B_TacticalPack_mcamo";

comment "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "Laserdesignator";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToVest "B_UavTerminal";
_unit addItemToVest "MineDetector";
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_65x39_caseless_mag";}; // "50Rnd_570x28_SMG_03";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "1Rnd_SmokeYellow_Grenade_shell";};
_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_Beret_gen_F";
_unit addGoggles "G_Goggles_VR";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

comment "Set identity";
[_unit,"Dwarden","male11eng"] call BIS_fnc_setIdentity; // Dwarden // Default
[_unit,"Curator"] call BIS_fnc_setUnitInsignia;
};
};

//if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {_unit action ["nvGoggles", _unit]};

if (isMultiPlayer) then
{	
	_unit addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		_unit execVM "loadouts_multiterrain.sqf";
	}];
};

if (!isPlayer _unit) then {

	[_unit,["<t color='#00FFFF'>Deploy Ammo</t>","(_unit select 0) call fnc_addFirstAidKitsAndMags",[],10,false,true,"","_unit distance _target < 2"]] remoteExec ["addAction",2];
};
//_unit call fnc_addFirstAidKitsAndMags;

//_unit setVehicleAmmo 1;
[_unit, 1] remoteExec ["setVehicleAmmo",groupOwner (group _unit)];

_unit setVariable ["LoadoutDone", true];

if (needReload _unit == 1) then { reload _unit; _unit groupRadio "SentSupportReady"; };

if (isPlayer _unit) then {[playerSide, "HQ"] commandChat "MultiTerrain Loadouts Enabled!";};
