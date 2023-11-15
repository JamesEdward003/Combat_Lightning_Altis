// execVM "predicam\cam_init.sqf" //
if (("BI_CP_CamOldReWrite" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};
camOldRewriteSpect = {
   [] execVM "Predicam\CameraOld.sqf";
   if ((date select 3) < 6 or (date select 3) > 19) then {camUseNVG true} else {camUseNVG false};
   [["CamOldReWriteInfo","CamOldReWriteManager"],25,"",35,"",true,true,false,false] call BIS_fnc_advHint;   
};

switch ("BI_CP_CamOldReWrite" call BIS_fnc_getParamValue) do {

   case (("BI_CP_CamOldReWrite" call BIS_fnc_getParamValue) isEqualTo 1): 
            {};
   case (("BI_CP_CamOldReWrite" call BIS_fnc_getParamValue) isEqualTo 2):
            {waitUntil {!isNil "BIS_CP_initDone"};
            [] spawn camOldRewriteSpect;};
   case (("BI_CP_CamOldReWrite" call BIS_fnc_getParamValue) isEqualTo 3):
            {tempspect = true;publicVariable "tempspect";
               SPECT_KEYDOWN_FNC = {
               private ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", "_handled"];
               params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt", ["_handled", false, [false]]];
               //params["_ctrl","_dikCode","_shift","_ctrlKey", "_alt", ["_handled",false], ["_display", displayNull, [displayNull]]];
                  
                  switch (_dikCode) do {
                        
                                 //Shift-Keypad O
                     case 82 : {
                          
                        if (_shift) then {
                          
                           if (tempspect) then {tempspect = false;
                              [] spawn camOldRewriteSpect;
                           };
                           _handled = true;     
                        }; 
                                 
                     };
                    
                  }; 
                  waituntil {!isnull (finddisplay 46)};
                  (findDisplay 46) displayAddEventHandler ["KeyDown","_this call SPECT_KEYDOWN_FNC;false;"];

                  waitUntil {!(isNull (findDisplay 46))};
                  (findDisplay 46) displayAddEventHandler ["KeyUp", "tempspect = true;false;"];          
               };
            };           
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
