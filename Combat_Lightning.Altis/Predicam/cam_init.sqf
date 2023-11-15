// execVM "predicam\cam_init.sqf" //
if (("BI_CP_Cam" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};

camspect = {
   _enemySides = [side player] call BIS_fnc_enemySides;
   _radius = 1000;
   _list = [];
   _list = (allGroups select {side _x == BIS_CP_enemySide && (leader _x) distance BIS_CP_targetLocationPos <= BIS_CP_radius_insertion});

   (leader (_list select 0)) spawn {_this call BIS_fnc_cameraOld};
   if ((date select 3) < 6 or (date select 3) > 19) then {camUseNVG true} else {camUseNVG false};
   [["CamInfo","CamManager"],25,"",35,"",true,true,false,false] call BIS_fnc_advHint;
};

if (("BI_CP_Cam" call BIS_fnc_getParamValue) isEqualTo 2) then {
   waitUntil {!isNil "BIS_CP_initDone"};
   [] spawn camspect;
};

if (("BI_CP_Cam" call BIS_fnc_getParamValue) isEqualTo 3) then {
   tempspect = true;publicVariable "tempspect";
   SPECT_KEYDOWN_FNC = {
   private ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled"];
   params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
   //params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
         
      switch (_dikCode) do {
            
                     //Shift-Keypad O
         case 82 : {
              
            if (_shift) then {
              
               if (tempspect) then {tempspect = false;
                  [] spawn camspect;
               };
               _handled = true;     
            }; 
                     
         };
        
      }; 
           
   };
   waituntil {!isnull (finddisplay 46)};
   (findDisplay 46) displayAddEventHandler ["KeyDown","_this call SPECT_KEYDOWN_FNC;false;"];

   waitUntil {!(isNull (findDisplay 46))};
   (findDisplay 46) displayAddEventHandler ["KeyUp", "tempspect = true;false;"];
};

tempspect0 = true;publicVariable "tempspect0";
SPECT0_KEYDOWN_FNC = {
private["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled"];
params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
//params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
      
    switch (_dikCode) do {
         
                  //Ctrl-Keypad O
         case 82 : {
           
            if (_ctrlKey) then {
           
               if (tempspect0) then {tempspect0 = false;
               player cameraEffect ["terminate","back"];
            };
            _handled = true;     
         };                      
      };        
   };            
};        

[playerSide, "HQ"] commandChat "Camera Enabled Shift-Keypad 0";

// waituntil {!(IsNull (findDisplay 46))};
// _keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "hint str _this"];

//==And the key EventHandler to execute the script...

waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call SPECT0_KEYDOWN_FNC;false;"];

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyUp", "tempspect0 = true;false;"];


/*
player addEventHandler ["Respawn", {
   params ["_unit", "_corpse"];
   _unit execVM "predicam\cam_init.sqf";
}];
*/
/* 
camChat = {
   
   uisleep 6;

   ["<t color='#FFCC33' size='1.2'>You have selected the 'Camera' parameter.<br />Use LCtrl-Keypad O to Turn Off.<br />Use LShift-Keypad O to Turn On!</t>",0,.01,10,1] spawn BIS_fnc_dynamicText;

   while {(!(isNil "BIS_DEBUG_CAM"))} do {      

      systemChat "Press NumPad 0 To Return";

      systemChat "Press Left Mouse Button To Teleport Camera";

      systemChat "Press Ctrl + Left Mouse Button To Teleport Player";

      systemChat "Press WASD Keys To Move";

      systemChat "Press F To Lock On Object";

      systemChat "Press L To Remove CrossHair";

      systemChat "Press Ctrl then Alt-Tab then Ctrl-V to copy and paste to CopyToClipboard.txt";

      uisleep 20;
   };
};
*/
