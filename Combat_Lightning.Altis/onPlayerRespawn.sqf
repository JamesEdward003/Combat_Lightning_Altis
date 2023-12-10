if (("FirstAidKit" in items player) or {("Medikit" in items _this)}) then
		{
			[
			player,
			"Revive/Heal Self",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
			"(alive _this) && (_this getVariable ['BIS_revive_incapacitated', false]) && (('FirstAidKit' in items _this) OR ('Medikit' in items _this))",
			"true",
			{},
			{},
			{
			["#rev", 1, _caller] call BIS_fnc_reviveOnState;
			if (!("Medikit" in items _caller)) then
			{
			_caller removeItem 'FirstAidKit';
			};
			_caller setVariable ["BIS_revive_incapacitated", false,true];
			_caller setVariable ["UnitDown",false,true];
			_caller setDamage 0;
			_caller setUnconscious false;
			_caller setVariable ["ReviveAdded",false];
			
			if not (_caller getVariable ["FiredEHAdded",false]) then
				{
				_caller addEventHandler ["Fired",{(_this select 0) setCaptive false;(_this select 0) setVariable ["FiredEHAdded",false];(_this select 0) removeEventHandler [_thisEvent,_thisEventHandler];}];
				_caller setVariable ["FiredEHAdded",true];
				};
				
			[_caller] spawn
				{
				params ["_caller"];
				
				_tme = time;
				
				waitUntil
					{
					sleep 1;
					
					(((time - _tme) > 30) or {(_caller getVariable ["ReviveAdded",false]) or {not (captive _caller)}})
					};
					
				if ((_caller getVariable ["ReviveAdded",false]) or {not (captive _caller)}) exitWith {};
				
				_caller setCaptive false;
				
				hint "Enemy can attack you!"
				};
			
			},
			{["Failed", "You Interrupted the action!"] call BIS_fnc_showSubtitle},
			[],
			1,
			1000000000000000,
			false,
			true
			] 
		call bis_fnc_holdActionAdd;
		};﻿