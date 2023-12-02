//    intel_kouris.sqf    //
//[_this, "Intel_File2_F"] remoteExec ["addItemToBackpack", 0, _this];
//[_this, "Medikit"] remoteExec ["addItemToBackpack", 0, _this];
//_this addItemToBackpack "Medikit";

private _toRemoteExec = { 
    backPackHackHoldActionId = [ 
      _this, 
      "Kouris Intel", 
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
      "_this distance _target < 4", 
      "_caller distance _target < 4", 
      {}, 
      {parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Talk with Alexis Kouris</t><br/><br/><t size='1.5' color='#FFFF00'>Getting Clearance</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#FFFF00'>%1 Ready</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]}, 
      {parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Connect with Alexis Kouris</t><br/><br/><t size='1.5' color='#00FF00'>Talk</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; [_target, "Intel\QA_kouris.sqf"] remoteExec ["execVM", 0, _target];_target say3D "Orange_Access_FM"; sleep 5; "" remoteExec ["hintSilent"]}, 
      {parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Talk with Alexis Kouris</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; sleep 5; "" remoteExec ["hintSilent"]},
      [], 
      12, 
      0, 
      true, 
      false 
  ] call BIS_fnc_holdActionAdd; 
}; 
[_this, _toRemoteExec] remoteExec ["call", 0, _this]; 

//if ((unitBackpack Kouris isKindof "B_Messenger_Olive_F") && (!("Intel_File2_F" in (items Kouris + assignedItems Kouris)))) then {Kouris addItemToBackpack "Intel_File2_F";};

//[_this, "Intel\QA.sqf"] remoteExec ["execVM", 0, _this]; 

//this setVehiclePosition [[14633.7,16798.5,0.125], ["scout_intel_1","scout_intel_2","scout_intel_3","scout_intel_4"], 0, "CAN_COLLIDE"];


