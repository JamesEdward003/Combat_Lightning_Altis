////////////////////////////////////////////////////////////////////////////
// =======================================================================================
// PLAYER WILL BE TELEPORTED with CTRL - T press
// =======================================================================================
//===DisplayAddEventHandler===//===To find the number on YOUR keyboard===//
//	waituntil {!(IsNull (findDisplay 46))};
//	_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "hint str _this"];
//===Add an EventHandler to the main display to view chosen objects...with additions :)
//(findDisplay 46) displayRemoveEventHandler ["KeyDown", _KeyDown];
//(findDisplay 46) displayRemoveEventHandler ["KeyUp", _KeyUp];

CtrlT_TeleportPlayer = {
tport = true;
TELEPORT_PLAYER_KEYDOWN_FNC = {
private["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled"];
params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
//params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
    	
    switch (_dikCode) do {
			
                	//Ctrl-T
        case 20 : {
	        
	        if (_ctrlKey) then {
	        
	     		if (tport) then {tport = false;execVM "onMapClickTeleportPlayer.sqf";};
				_handled = true;		
				};	
		            	
	        };
	     
	    }; 
	        
	};
        
//==And the key EventHandler to execute the script...
waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call TELEPORT_PLAYER_KEYDOWN_FNC;false;"];

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyUp", "tport = true;false;"];

};


/*
player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	_unit execVM "CtrlT_TeleportPlayer.sqf";
}];
*/

for "_i" from 0 to count (if ismultiplayer then {playableunits} else {switchableunits}) - 1 do
{
	_unit = (if ismultiplayer then {playableunits} else {switchableunits}) select _i;

	if ((isPlayer _unit) && (isFormationLeader _unit)) then {

		call CtrlT_TeleportPlayer ;

		hintSilent composeText ["Ctrl-T Teleport Player keypress enabled", lineBreak, "Press Ctrl-T"];

		[playerSide, "HQ"] commandChat "Ctrl-T Teleport Player Keypress Enabled!";
	};
};						


