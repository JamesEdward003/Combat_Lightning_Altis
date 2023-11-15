// execVM "predicam\predicam_init.sqf" //
if (("BI_CP_IntroCam" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};

spect = {
   predicam = true;publicVariable "predicam";
   _enemySides = [side player] call BIS_fnc_enemySides;
   _radius = 1000;
   _list = [];
   _list = (allGroups select {side _x == BIS_CP_enemySide && (leader _x) distance BIS_CP_targetLocationPos <= BIS_CP_radius_insertion});

   [(leader (_list select 0)), 60,190,30,300,2,true, true] execVM "predicam\predicam.sqf";

   _spects = [(leader (_list select 1)), (leader (_list select 2)), (leader (_list select 3)), (leader (_list select 4)), (leader (_list select 5))];

   ["<t color='#FFCC33' size='1.2'>You have selected the 'Intro Cam' parameter.<br />Use Ctrl-Keypad O to Exit.</t>",0,.01,20,1] spawn BIS_fnc_dynamicText;

   [["PrediCamInfo","PrediCamManager"],25,"",35,"",true,true,false,false] call BIS_fnc_advHint;

   while {predicam} do
   {
      uisleep 1;
      {
      
         sleep 10;
         predicamunit = _x;
         waitUntil {predicamready >= 2};

      } forEach _spects;
   };
};

if (("BI_CP_IntroCam" call BIS_fnc_getParamValue) isEqualTo 2) then {
   waitUntil {!isNil "BIS_CP_initDone"};
   [] spawn spect;
};  
if (_BI_CP_IntroCam isEqualTo 3) then {
   [] spawn {
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
                     [] spawn spect;
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
               predicam = false;
               [["SquadInfo","SquadManager"],25,"",35,"",true,true,false,false] call BIS_fnc_advHint;
            };
            _handled = true;     
         };                      
      };        
   };            
};        
waituntil {!isnull (finddisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call SPECT0_KEYDOWN_FNC;false;"];

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyUp", "tempspect0 = true;false;"];


