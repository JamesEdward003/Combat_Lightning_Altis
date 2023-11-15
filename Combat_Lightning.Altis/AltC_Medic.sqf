////////////////////////////////////////////////////////////////////////////
// =======================================================================================
// Selected medics will attend to the player and heal Alt_C_Medic with Alt - C press
// =======================================================================================
//===DisplayAddEventHandler===//===To find the number on YOUR keyboard===//
	// waituntil {!(IsNull (findDisplay 46))};
	// _keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "hint str _this"];
//===Add an EventHandler to the main display to view chosen objects...with additions :)
//(findDisplay 46) displayRemoveEventHandler ["KeyDown", _KeyDown];
//(findDisplay 46) displayRemoveEventHandler ["KeyUp", _KeyUp];
if (("Alt_C_Medic" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};

AltC_Medic = {

tempheal = true;
HEAL_KEYDOWN_FNC = {
private["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled"];
params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
//params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
    	
    switch (_dikCode) do {
			
                	//Alt-C
        case 46 : {
	        
	        if (_alt) then {
	        
	     		if (tempheal) then {tempheal = false; [player] execVM "HealPlayer.sqf";};
				_handled = true;		
				};	
		            	
	        };
	     
	    }; 
	        
	};
        
//==And the key EventHandler to execute the script...
waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call HEAL_KEYDOWN_FNC;false;"];

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyUp", "tempheal = true;false;"];

};


/*
player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	_unit execVM "AltC_Medic.sqf";
}];
*/

for "_i" from 0 to count (if ismultiplayer then {playableunits} else {switchableunits}) - 1 do
{
	_unit = (if ismultiplayer then {playableunits} else {switchableunits}) select _i;

	if ((isPlayer _unit) && (isFormationLeader _unit)) then {

		call AltC_Medic;

		hintSilent composeText ["Alt-C Medic keypress enabled", lineBreak, "Press Alt-C"];

		[playerSide, "HQ"] commandChat "Alt-C Medic Keypress Enabled!";
	};
};						


