params ["_mirror"];

if (((player distance _mirror) < 50) && (hasInterface)) then {
	[_mirror] call {
		params ["_mirror",["_glassSources",[]]];
		{
			_brokenGlass = "#particlesource" createVehicleLocal [0,0,10];
			_brokenGlass setPosASL (_mirror modelToWorldWorld _x);
			_brokenGlass setParticleClass "BrokenGlass1N_0300_0800";
			_glassSources pushBack _brokenGlass;
		} forEach [
			[-0.5,0,0.3],
			[-0.5,0,-0.3],
			[0,0,0.3],
			[0,0,-0.3],
			[0.5,0,0.3],
			[0.5,0,-0.3]
		];
		nul = [_glassSources] spawn {
			params ["_glassSources"];
			sleep 0.5;
			{deleteVehicle _x} forEach _glassSources;
		};
	};
};