params ["_mirror"];

///////
//Add breaking glass EHs.
///////

_hitPartHandle = _mirror addEventHandler ["HitPart",{
	(_this select 0) params ["_mirror"];
	private _hitCount = _mirror getVariable (format["%1_hits",_mirror]);
	_hitCount = _hitCount + 1;
	private _breakChance = random _hitCount;

	if ((_hitCount >= 3) || (_breakChance > 0.75)) then {
		[_mirror] remoteExec ["MIL_fnc_Mirror_CancelMirror",0,true];
		[_mirror,[0,""]] remoteExec ["setObjectTexture",0,true];
		playSound3D [format["a3\sounds_f\arsenal\sfx\bullet_hits\glass_0%1.wss",round (random 8)],_mirror];
		
		{
			if (isPlayer _x) then {
				[_mirror] remoteExec ["MIL_fnc_Mirror_BrokenGlass",_x,false];
			};
		} forEach (nearestObjects [_mirror,["Man"],50]);

		} else {
		
		playSound3D [format["a3\sounds_f\arsenal\sfx\bullet_hits\glass_arm_0%1.wss",round (random 8)],_mirror];	
	};
	
	_mirror setVariable [format["%1_hits",_mirror],_hitCount,true];
}];
_mirror setVariable [format["%1_hitPartHandle",_mirror],_hitPartHandle,false];

_explosionHandle = _mirror addEventHandler ["Explosion",{
	params ["_mirror"];
	[_mirror] remoteExec ["MIL_fnc_Mirror_CancelMirror",0,true];
	[_mirror,[0,""]] remoteExec ["setObjectTexture",0,true];
	playSound3D [format["a3\sounds_f\arsenal\sfx\bullet_hits\glass_0%1.wss",round (random 8)],_mirror];
			
	{
		if (isPlayer _x) then {
			nul = [_mirror] spawn MIL_fnc_Mirror_BrokenGlass;
		};
	} forEach (nearestObjects [_mirror,["Man"],50]);
}];
_mirror setVariable [format["%1_explosionHandle",_mirror],_explosionHandle,false];

_return = [_mirror,_hitPartHandle,_explosionHandle];
_return