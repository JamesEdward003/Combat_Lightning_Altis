//----targetHighestRank.sqf----//
_unit = _this;
_nearTargets = (getPos _unit) nearEntities [["Man"],1000]; //  "House", "Air", "Car", "Motorcycle", "Tank", 
_targetFilter = switch (playerSide) do {
    case west:			{ side _x == east OR side _x == resistance };
    case east:			{ side _x == west OR side _x == resistance };
    case resistance:	{ side _x == west OR side _x == east };
    case civilian:		{ side _x == east OR side _x == resistance };
};
_targets = _nearTargets select _targetFilter;
hintC format ["%1",_targets];
_targetsRanking = _targets findIf {rankID _x > 0 pushBackUnique _x};
hintC format ["%1",_targetsRanking];
_targetsHighestRanking = _targetsRanking sort false;
hintC format ["%1",_targetsHighestRanking];
_targetHighestRanking = _targetsHighestRanking select 0;
hintC format ["%1",_targetHighestRanking];
{	private _targetHighestRanking = _x;
	(playerSide) reportRemoteTarget [_x, 3600]; 
	uisleep 1;
	_x confirmSensorTarget [(playerSide), true]; 
	uisleep 1;	
	{ 
		_x setWeaponReloadingTime [gunner _x, currentMuzzle gunner _x, 0];

		_x fireAtTarget [_targetHighestRanking, "weapon_vls_01"];

		uisleep 2;

	} forEach _VLS_Array;
} forEach _targetHighestRanking;

