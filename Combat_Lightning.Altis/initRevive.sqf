if (("InitRevive" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};
player addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
	if ((toLower _selection) in ["arms","hands","legs"]) exitWith {_damage};	
		if (_damage >= 1) then {			
			_unit setCaptive true;
			_unit allowDamage true;
			_unit setUnconscious true;
			_unit setVariable ["BIS_revive_incapacitated",true,true];

				[
				_unit, /* 0 object */
				"Revive/Heal Self", /* 1 action title */
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa", /* 2 idle icon */
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa", /* 3 progress icon */
				"(alive _this) && (_this getVariable ['BIS_revive_incapacitated', false])", /* 4 condition to show */
				"true", /* 5 condition for action */
				{}, /* 6 code executed on start */
				{}, /* 7 code executed per tick */
				{
				params ["_target", "_caller", "_actionId", "_arguments"];
				["#rev", 1, _target] call BIS_fnc_reviveOnState;
				_target setVariable ["BIS_revive_incapacitated", false,true];
				_target setDamage 0;
				_target setUnconscious false;
				_target playMove "AmovPpneMstpSnonWnonDnon";
				[_target,_actionId] spawn {
					params ["_target", "_actionId"];
	    			["CROSSROAD", "10 seconds to find cover"] spawn BIS_fnc_showSubtitle;
	    			uiSleep 10;
	  				_target allowDamage true;
	  				_target setCaptive false;
	  				[_target,_actionID] remoteExec ["BIS_fnc_holdActionRemove", 0];
	  				[_target,_actionId] remoteExec ["fnc_RemoveActions", 0];
					if (!("Medikit" in items _target)) then {_target removeItem "FirstAidKit";};					
					["CROSSROAD", "Enemy can attack you, I repeat, enemy can attack you, Crossroad, out."] spawn BIS_fnc_showSubtitle;
					[playerSide, "HQ"] commandChat "SetCaptive is Off!";
				};	
				//[_target] call fnc_RemoveActions;
				//[_target,_actionID] remoteExec ["BIS_fnc_holdActionRemove", 0];	
				}, /* 8 code executed on completion */
				{["Failed", "You Interrupted the action!"] call BIS_fnc_showSubtitle}, /* 9 code executed on interruption */
				[], /* 10 arguments */
				5, /* 11 action duration */
				100000000000000, /* 12 priority */
				true, /* 13 remove on completion */
				true, /* 14 show unconscious */
				true /* 15 show window */
			 	] 
			call Bis_fnc_holdActionAdd;
		};			
	(_damage min 0.99)
	}];




//waitUntil {isNil "RscFiringDrillTime_done"};

/*
[this,

"Meet with Alexis Kouris",

"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",

"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",

"isNil 'var_resist' && _this distance _target < 3",

"isNil 'var_resist' && _caller distance _target < 3",

{},

{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FFFF00'>Briefing</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#CCCCCC'>%1&#37; Complete</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]},

{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#00FF00'>Briefed</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; missionNamespace setVariable ["var_resist",true,true]; sleep 5; "" remoteExec ["hintSilent"]},

{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]},

[],

15,

10] call bis_fnc_holdActionAdd;

*********************************

private _toRemoteExec = {
    laptopHackHoldActionId = [
      _myLaptop,
      "Hack Laptop",
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
      "_this distance _target < 3",
      "_caller distance _target < 3",
      {},
      {},
      { _this call MY_fnc_hackingCompleted },
      {},
      [],
      12,
      0,
      true,
      false
  ] call BIS_fnc_holdActionAdd;
};
[[], _toRemoteExec] remoteExec ["spawn", 0, _myLaptop];	
[_myLaptop, laptopHackHoldActionId] remoteExec ["BIS_fnc_holdActionRemove", 0];
*/



