//  extraTasks.sqf  //
if (!isServer) exitWith {};

0 = [] spawn {
sleep 1;

0 = [] spawn {
[west,["task1"],["Go to the area and destroy enemy artillery","Go to the area and destroy enemy artillery",""], getPosATL envee1 ,1,2,true,"destroy"] call BIS_fnc_taskCreate;
waitUntil{(!(alive envee1) AND !(alive envee2))};
["task1", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
};

waitUntil{(!(alive envee1) AND !(alive envee2))};
[west,["task2"],[format[" Go to the area and kill two officers, first %1",name Attar],format[" Go to the area and kill two officers %1",name Attar],""], getPosATL Attar,1,2,true,"kill"] call BIS_fnc_taskCreate;
waitUntil{!(alive Attar)};
["task2", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

[west,["task3"],[format[" Go to the area and kill two officers, second, %1",name Viper_2],format[" Go to the area and kill two officers %1",name Viper_2],""], getPosATL Viper_2,1,2,true,"kill"] call BIS_fnc_taskCreate;
waitUntil{!(alive Viper_2)};
["task3", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

[west,["task4"],["Optional intel","Optional intel",""], getMarkerPos "marker_00" ,1,2,true,"move"] call BIS_fnc_taskCreate;
waitUntil{sleep 1;(({isPlayer _x && _x distance (getMarkerPos "marker_00") < 5} count playableUnits > 0));};
["task4", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

[west,["task5"],["Exfill at the position ","Exfill at the position ",""], BIS_CP_exfilPos ,1,2,true,"move"] call BIS_fnc_taskCreate;
waitUntil{sleep 1;(({isPlayer _x && _x distance BIS_CP_exfilPos < 5} count playableUnits > 0));};
["task5", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

_markerstr = createMarker ["marker_22",[14717.4,16776.7,0]];
_markerstr setMarkerShape "ICON";
[west,["task6"],["Exfill at the base ","Exfill at the base ",""], getMarkerPos "marker_22" ,1,2,true,"move"] call BIS_fnc_taskCreate;
waitUntil{sleep 1;(({isPlayer _x && _x distance (getMarkerPos "marker_22") < 5} count playableUnits > 0));};
["task6", "SUCCEEDED",true] spawn BIS_fnc_taskSetState;

};
//(_this select 1) createDiaryRecord ["Diary", ["Alexis Kouris", "Meet with Alexis Kouris."]]
//{(_this select 1) createDiaryRecord ["Diary", ["Title of Entry", "Details of entry here."]]} 
//player setVehiclePosition [[14633.7,16798.5,0.125], ["scout_intel_1","scout_intel_2","scout_intel_3","scout_intel_4"], 0, "CAN_COLLIDE"];
/*

call{this attachTo [desk, [-.4, .2, .425]];this setDir ((getDir this) + 45);};[this, 
"Meet with Alexis Kouris", 
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa", 
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
"isNil 'var_meet' && _this distance _target < 4", 
"isNil 'var_meet' && _caller distance _target < 4", 
{}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FFFF00'>Briefing</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#00FF00'>(%1); Complete</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#00FF00'>Briefed</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; execVM "extratask1.sqf"; missionNamespace setVariable ["var_meet",true,true]; sleep 5; "" remoteExec ["hintSilent"]}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"];}, 
[], 
15, 
10] call bis_fnc_holdActionAdd;

call{this attachTo [desk, [-.4, .2, .425]];this setDir ((getDir this) + 45);};  
[this,
"Meet with Alexis Kouris", 
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa", 
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
"isNil 'var_resist' && _this distance _target < 4", 
"isNil 'var_resist' && _caller distance _target < 4", 
{}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FFFF00'>Briefing</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#00FF00'>(%1); Complete</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#00FF00'>Briefed</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; missionNamespace setVariable ["var_resist",true,true]; sleep 5; "" remoteExec ["hintSilent"]}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"];_null=[] execVM "extratask1.sqf"}, 
[], 
15, 
10] call bis_fnc_holdActionAdd;

You can check if the action has been completed with this code:

(missionNamespace getVariable ["var_resist",false])
*/
/*
private _toRemoteExec = { 
    laptopHackHoldActionId = [ 
      laptopp2, 
      "Extra Tasks", 
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
      "_this distance _target < 4", 
      "_caller distance _target < 4", 
      {}, 
      {}, 
      { execVM "extraTasks.sqf" }, 
      {}, 
      [], 
      12, 
      0, 
      true, 
      false 
  ] call BIS_fnc_holdActionAdd; 
}; 
[[], _toRemoteExec] remoteExec ["spawn", 0, laptopp2];  
[laptopp2, laptopHackHoldActionId] remoteExec ["BIS_fnc_holdActionRemove", 0];
*/

//this setVehiclePosition [[14633.7,16798.5,0.125], ["scout_intel_1","scout_intel_2","scout_intel_3","scout_intel_4"], 0, "CAN_COLLIDE"];

/*
call{this attachTo [desk, [-.4, .2, .425]];this setDir ((getDir this) + 45);};[this, 
 
"Meet with Alexis Kouris",  
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",  
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
"isNil 'var_example' && _this distance _target < 6",  
"isNil 'var_example' && _caller distance _target < 6", 
{}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FFFF00'>Briefing</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#CCCCCC'>%1&#37; Complete</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]},  
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#00FF00'>Briefed</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; missionNamespace setVariable ["var_resist",true,true]; sleep 5; "" remoteExec ["hintSilent"]},  //_Task = [Gambler, "Alexis Kouris", ["Meet with Alexis Kouris","Alexis Kouris"], getPos Kouris, "ASSIGNED", 10, true] call BIS_fnc_taskCreate;
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"];},  
[],  
15,  
10] call bis_fnc_holdActionAdd;
*/

/*
if (isServer) then {
this setVariable ["RscAttributeDiaryRecord_texture","a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa", true];
[this,"RscAttributeDiaryRecord",["Top Secret Docs","These Docs outline the enemies defenses",""]] call bis_fnc_setServerVariable;
this setVariable ["recipients", west, true];
[this,"init"] spawn bis_fnc_initIntelObject;
};
*/

/*
if (isServer) then {
   this setVariable ["RscAttributeDiaryRecord_texture","a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa", true];
   [this,"RscAttributeDiaryRecord",["Top Secret Docs","<br /><execute expression=""[(group player), 'my intel task', ['an intel task', 'secret docs', ''], [0,0,0], 'ASSIGNED', 0] call BIS_fnc_taskCreate"">These Docs outline the enemies defenses</execute><br />",""]] call bis_fnc_setServerVariable;
   this setVariable ["recipients", west, true];
   [this,"init"] spawn bis_fnc_initIntelObject;
}; 
*/

/*
_towns = nearestLocations [[worldSize / 2, worldsize / 2, 0], ["NameVillage","NameCity","NameCityCapital"], 25000]; 
_RandomTownPosition = position (_towns select (floor (random (count _towns))));

_m = createMarker [format ["mrk%1",random 100000],_RandomTownPosition];
_m setMarkerShape "ELLIPSE";
_m setMarkerSize [900,900];
_m setMarkerBrush "BDiagonal";
_m setMarkerAlpha 0.3;
_m setMarkerColor "ColorOPFOR";

_pos = getMarkerPos _m;

_loc = text (nearestLocations [_pos, ["Airport", "NameLocal", "NameVillage", "NameCity"],20000] select 1);

_markerAO = createMarker ["Area.", position player ];
_markerAO setMarkerPos [4231.82,18056,0];
_markerAO setMarkerShape "ICON";
_markerAO setMarkerColor "colorOPFOR";
_markerAO setMarkerType "Faction_TKA_EP1";
_markerAO setMarkerText format ["Enemy forces near: %1", _loc];

_randPos = [_pos , 0, 600, 12, 0, 0.3, 0] call BIS_fnc_findSafePos;
*/
/*
this addEventHandler ["Take", {
  params ["_unit", "_container", "_item"];
}];

Kouris addItemToBackpack "Intel_File2_F"; documents2
if ((unitBackpack Kouris isKindof "B_Messenger_Olive_F") && (!("Intel_File2_F" in (items Kouris + assignedItems Kouris)))) then {Kouris addItemToBackpack "Intel_File2_F";};

Intel_File1_F = documents1

private _toRemoteExec = { 
    backPackHackHoldActionId = [ 
      unitBackpack Kouris, 
      "Kouris' Intel", 
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
      "_this distance _target < 4", 
      "_caller distance _target < 4", 
      {}, 
      {}, 
      { if ((unitBackpack Kouris isKindof "B_Messenger_Olive_F") && ("Intel_File2_F" in (items Kouris + assignedItems Kouris))) then {Kouris removeItemFromBackpack "Intel_File2_F";} }, 
      {}, 
      [], 
      12, 
      0, 
      true, 
      false 
  ] call BIS_fnc_holdActionAdd; 
}; 
[[], _toRemoteExec] remoteExec ["spawn", 0, unitBackpack Kouris]; 
*/
