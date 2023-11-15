/////--"RSkill--/////
// [side,skillMin,skillAimMin,skillMax,skillAimMax] call BIS_fnc_EXP_camp_setSkill
private ["_unit","_RSkill"];
_RSkill = "RSkill" call BIS_fnc_getParamValue;

switch (_RSkill) do
{
	case 1: {
		
			[RESISTANCE,0.1,0.2,0.6,0.6] call BIS_fnc_EXP_camp_setSkill;									
	};
	case 2: {

			[RESISTANCE,0.2,0.3,0.7,0.7] call BIS_fnc_EXP_camp_setSkill;					
	};
	case 3: {
		
			[RESISTANCE,0.3,0.4,0.8,0.8] call BIS_fnc_EXP_camp_setSkill;									
	};
	case 4: {

			[RESISTANCE,0.4,0.5,0.9,0.9] call BIS_fnc_EXP_camp_setSkill;						
	};
	case 5: {

			[RESISTANCE,0.6,0.7,1.0,1.0] call BIS_fnc_EXP_camp_setSkill;						
	};
};

[playerSide, "HQ"] commandChat "RESISTANCE SKILL SET!";

