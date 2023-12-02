// heliGunners.sqf //
private ["_heli"];
_heli = _this select 0;

_heli addAction [ "Disable Door Gunners", {
		params [ "_target", "_caller", "_id", "_args" ];
		
		//Get vehicles turret paths
		_turrets = allTurrets _target;
		//Get vehicles base config path
		_baseConfig = configFile >> "CfgVehicles" >> typeOf _target;
		
		//For each turret path
		{
			//Set turrets config path as vehicles base path
			_turretConfig = _baseConfig;
			
			//For each index in the turret path
			{
				//Get the turrets config path
				_turretConfig = ( _turretConfig >> "turrets" ) select _x;
			}forEach _x;
			
			//Once we have found the turrets config path
			//If its "gunnerName" field includes the text "door gunner"
			if ( getText( _turretConfig >> "gunnerName" ) find "door gunner" > -1 ) then {
				//Update _turrets with the unit actually occupying that turret
				_turrets set[ _forEachIndex, _target turretUnit _x ];
			}else{
				//Otherwise set it as objnull no unit
				_turrets set[ _forEachIndex, objNull ];
			};
		}forEach _turrets;
		
		//Get an array of all the turret units, minus any that are null or are a player
		_doorGunners = _turrets select{ !isNull _x && { !isPlayer _x } };
		
		//If the current action text starts with a "d"
		//Then we are disabling
		_disable = _target actionParams _id select 0 select [ 0, 1 ] == "d";
		
		//For each of the door gunners
		{
			//Call this code 
			[ [ _x, _disable ], {
				params[ "_gunner", "_disable" ];
				if !( _disable ) then {
					_gunner enableAI "TARGET";
					_gunner enableAI "AUTOTARGET";
					_gunner enableAI "WEAPONAIM";
					_gunner enableAI "AUTOCOMBAT";
					(vehicle _gunner) flyInHeight 20;
				}else{
					_gunner disableAI "TARGET";
					_gunner disableAI "AUTOTARGET";
					_gunner disableAI "WEAPONAIM";
					_gunner disableAI "AUTOCOMBAT";
					(vehicle _gunner) flyInHeight 60;
				};
			} ] remoteExec[ "BIS_fnc_call", _x ]; //_x where the unit is local
		}forEach _doorGunners;
		
		//Get new action text
		_text = format[ "%1 Door Gunners", [ "Disable", "Enable" ] select _disable ];
		//Update action text on all clients and JIP
		[ _target, [ _id, _text ] ] remoteExec[ "setUserActionText", 0, _target ]; //_target as persistence, until the vehicle is destroyed or deleted
	},
	[],
	1,
	false,
	true,
	"",
	//Only allow the driver of the vehicle this action is placed on to use this action
	""	//"driver _target isEqualTo _this"
];

