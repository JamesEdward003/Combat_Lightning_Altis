// "SP_Respawn_Group.sqf" //
private ["_unit"];
if ( ("GroupRespawnSP" call BIS_fnc_getParamValue) isEqualTo 1 ) exitWith {};

if isMultiplayer exitWith {};
	
switch ( "GroupRespawnSP" call BIS_fnc_getParamValue ) do {

	case 1: {
		
		for "_i" from 0 to count (units group player) - 1 do {

			_unit = (units group player) select _i;

				switch true do {

					case (side _unit isEqualTo WEST) : {

						if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Group Single Player Respawn Not Enabled!",name _unit];

						};

						_unit setDamage 0;						
					};								
					case (side _unit isEqualTo EAST) : {

						if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Group Single Player Respawn Not Enabled!",name _unit];

						};

						_unit setDamage 0;
					};	
					case (side _unit isEqualTo RESISTANCE) : {
					
						if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Group Single Player Respawn Not Enabled!",name _unit];

						};

						_unit setDamage 0;
					};	
					case (side _unit isEqualTo CIVILIAN) : {
					
						if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Group Single Player Respawn Not Enabled!",name _unit];

						};

						_unit setDamage 0;
					};	
				};								
			};
		};

	case 2: {	
					
		for "_i" from 0 to count (units group player) - 1 do {

			_unit = (units group player) select _i;

				switch true do {

					case (side _unit isEqualTo WEST) : {
																				
						_unit execVM "SP_Respawn.sqf";	
					};
					case (side _unit isEqualTo EAST) : {
												
						_unit execVM "SP_Respawn.sqf";
					};
					case (side _unit isEqualTo RESISTANCE) : {
																	
						_unit execVM "SP_Respawn.sqf";
					};
					case (side _unit isEqualTo CIVILIAN) : {
												
						_unit execVM "SP_Respawn.sqf";
					};
				};		
			};						
		};

	case 3: {
				
		for "_i" from 0 to count (if ismultiplayer then {playableunits} else {switchableunits}) - 1 do {

			_unit = (if ismultiplayer then {playableunits} else {switchableunits}) select _i;
				
				switch true do {

					case (side _unit isEqualTo WEST) : {
												
						_unit execVM "SP_Respawn.sqf";	
					};
					case (side _unit isEqualTo EAST) : {
												
						_unit execVM "SP_Respawn.sqf";	
					};
					case (side _unit isEqualTo RESISTANCE) : {
												
						_unit execVM "SP_Respawn.sqf";
					};
					case (side _unit isEqualTo CIVILIAN) : {
												
						_unit execVM "SP_Respawn.sqf";	
					};
				};		
			};					
		};
};
