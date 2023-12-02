private ["_iconIdle", "_iconProgress", "_condShow", "_actionTitle"];

_iconIdle = "A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa";
_iconProgress = _iconIdle;
_condShow = "player distance IP_Colonel <= 3";
_actionTitle = localize "STR_IP_KSK_MEW_ACTION_UNTIE";

IP_UntieAction = [IP_Colonel, _actionTitle, _iconIdle, _iconProgress, _condShow, _condShow, {}, {}, {
	[IP_Colonel, IP_UntieAction] call BIS_fnc_holdActionRemove;
	IP_Untied = true;
	private _animEH = IP_Colonel addEventHandler ["AnimDone", {
		params ["_unit", "_anim"];
		
		if (_anim == "Acts_ExecutionVictim_Unbow") then {
			_unit removeEventHandler ["AnimDone", _unit getVariable "IP_animEH"];
			_unit setVariable ["IP_animEH", nil];
			removeGoggles  _unit;
		};
	}];

	IP_Colonel setVariable ["IP_animEH", _animEH];
	IP_Colonel playMoveNow "Acts_ExecutionVictim_Unbow";
}, {}, [], 4.0, 1000, false, true] call BIS_fnc_holdActionAdd;