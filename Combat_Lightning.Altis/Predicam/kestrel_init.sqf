// execVM "predicam\kestrel_init.sqf" //
if (("BI_CP_Kestrel" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};

kestrelspect = {
   _enemySides = [side player] call BIS_fnc_enemySides;
   _radius = 1000;
   _list = [];
   _list = (allGroups select {side _x == BIS_CP_enemySide && (leader _x) distance BIS_CP_targetLocationPos <= BIS_CP_radius_insertion});

   cam = "Kestrel_Random_F" camCreate ((leader (_list select 0)) modelToWorld [0,0,100]);
   cam cameraEffect ["fixedwithzoom", "back"];
   cam camCommand "manual on";
   ["<t color='#FFCC33' size='1.2'>You have selected the 'Kestrel Flyer' parameter.<br />Use Ctrl-Keypad O to Turn Off.<br />Use Alt-Keypad O to Turn On!</t>",0,.01,20,1] spawn BIS_fnc_dynamicText;
};

if (("BI_CP_Kestrel" call BIS_fnc_getParamValue) isEqualTo 2) then {
   waitUntil {!isNil "BIS_CP_initDone"};
   [] spawn kestrelspect;
};

/*
    Kestrel_Random_F
    ButterFly_random
    DragonFly
    HoneyBee
    Cicada
    HouseFly
    Mosquito

"Internal", "External", "Fixed", "FixedWithZoom", "Terminate"

   "TOP"
   "LEFT"
   "RIGHT"
   "FRONT"
   "BACK"
   "LEFT FRONT"
   "RIGHT FRONT"
   "LEFT BACK"
   "RIGHT BACK"
   "LEFT TOP"
   "RIGHT TOP"
   "FRONT TOP"
   "BACK TOP"
   "BOTTOM"
*/
if (("BI_CP_Kestrel" call BIS_fnc_getParamValue) isEqualTo 3) then {
   tempkest = true;publicVariable "tempkest";
   KEST_KEYDOWN_FNC = {
   private["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled"];
   params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
   //params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
         
      switch (_dikCode) do {
            
                     //Alt-Keypad O
         case 82 : {
              
            if (_alt) then {
              
               if (tempkest) then {tempkest = false;
                  [] spawn kestrelspect;
               };
               _handled = true;     
            }; 
                     
         };
        
      }; 
           
   };
};

tempkest0 = true;publicVariable "tempkest0";
KEST0_KEYDOWN_FNC = {
private["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled"];
params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
//params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
      
   switch (_dikCode) do {
         
                  //Ctrl-Keypad O
      case 82 : {
           
         if (_ctrlKey) then {
           
            if (tempkest0) then {tempkest0 = false;
               player cameraEffect ["terminate","back"];
               camDestroy cam;
            };
            _handled = true;     
         };                      
      };        
   };   
   waituntil {!isnull (finddisplay 46)};
   (findDisplay 46) displayAddEventHandler ["KeyDown","_this call KEST_KEYDOWN_FNC;false;"];

   waitUntil {!(isNull (findDisplay 46))};
   (findDisplay 46) displayAddEventHandler ["KeyUp", "tempkest = true;false;"];         
};        

[playerSide, "HQ"] commandChat "Kestrel Flyer Enabled - Shift-Keypad 0!";

// waituntil {!(IsNull (findDisplay 46))};
// _keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "hint str _this"];

//==And the key EventHandler to execute the script...

waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call KEST0_KEYDOWN_FNC;false;"];

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyUp", "tempkest0 = true;false;"];

/*
player addEventHandler ["Respawn", {
   params ["_unit", "_corpse"];
   _unit execVM "predicam\kestrel_init.sqf";
}];
*/
