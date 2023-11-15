// "CtrlC_Lightning.sqf" ///////////////////////////////////////////////////
// =======================================================================================
// LIGHTNING WILL STRIKE WHAT THE PLAYER IS LOOKING AT with Ctrl - C press
// =======================================================================================
//===DisplayAddEventHandler===//===To find the number on YOUR keyboard===//
//	waituntil {!(IsNull (findDisplay 46))};
//	_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "hintSilent str _this"];
//===Add an EventHandler to the main display to view chosen objects...with additions :)
//(findDisplay 46) displayRemoveEventHandler ["KeyDown", _KeyDown];
//(findDisplay 46) displayRemoveEventHandler ["KeyUp", _KeyUp];
if (("Ctrl_C_Lightning" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};

CtrlC_Lightning = {

tempctrlc = true;
LIGHTNING_KEYDOWN_FNC = {
private["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled", "_strikeTarget", "_strikeLoc"];
params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
//params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
    	
	switch (_dikCode) do {
	
			//Ctrl-C
		case 46 : {
        
			if (_ctrlKey) then {
        
     			if (tempctrlc) then {  
          
					tempctrlc = false;
					
					_strikeTarget = cursorObject;

					[_strikeTarget] spawn {
											
						private["_strikeTarget", "_strikeLoc"];
						
						params ["_strikeTarget"];

						_strikeLoc =  (getPos _strikeTarget);
						
						if (_strikeLoc isequalto [0,0,0]) then {
							
							hintSilent "!";
						
						}else{

							[_strikeTarget,nil,true] call BIS_fnc_moduleLightning;

							hintSilent "";
							
						};
					};
				};    	     
				_handled = true;	
			};	
		};	            	
	};     
}; 
        
//==And the key EventHandler to execute the script...
waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call LIGHTNING_KEYDOWN_FNC;false;"];

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyUp", "tempctrlc = true;false;"];

};


/*
player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	_unit execVM "CtrlC_Lightning.sqf";
}];
*/

for "_i" from 0 to count (if ismultiplayer then {playableunits} else {switchableunits}) - 1 do
{
	_unit = (if ismultiplayer then {playableunits} else {switchableunits}) select _i;

	if ((isPlayer _unit) && (isFormationLeader _unit)) then {

		call CtrlC_Lightning;

		hintSilent composeText ["Ctrl-C Lightning keypress enabled", lineBreak, "Press Ctrl-C"];

		[playerSide, "HQ"] commandChat "Ctrl-C Lightning Keypress Enabled!";
	};
};	

