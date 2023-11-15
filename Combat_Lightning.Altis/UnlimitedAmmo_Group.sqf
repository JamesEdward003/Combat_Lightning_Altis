// "UnlimitedAmmo_Group.sqf" //
private ["_unit"];
if (("BI_CP_UnlimitedAmmo" call BIS_fnc_getParamValue) isEqualTo 1) exitWith {};

switch ("BI_CP_UnlimitedAmmo" call BIS_fnc_getParamValue) do
{
	case 1: {
		
			for "_i" from 0 to count (units group player) - 1 do
			
				{
					_unit = (units group player) select _i;
				
				switch true do 
				
					{
						case (side _unit isEqualTo WEST) :  {
						
							//if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {_unit action ["nvGoggles", _unit]};

							if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Unlimited Ammo Not Enabled!",name _unit];

							};

							_unit setDamage 0;
								
						};
						case (side _unit isEqualTo EAST) :  {
						
							//if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {_unit action ["nvGoggles", _unit]};

							if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Unlimited Ammo Not Enabled!",name _unit];

							};

							_unit setDamage 0;
							
						};
						case (side _unit isEqualTo RESISTANCE) :  {
						
							//if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {_unit action ["nvGoggles", _unit]};

							if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Unlimited Ammo Not Enabled!",name _unit];

							};

							_unit setDamage 0;
							
						};
						case (side _unit isEqualTo CIVILIAN) :  {
						
							//if (((dayTime > ((date call BIS_fnc_sunriseSunsetTime) select 0) - 0.5) && (dayTime < ((date call BIS_fnc_sunriseSunsetTime) select 1) + 0.5)) isEqualTo false) then {_unit action ["nvGoggles", _unit]};

							if (isPlayer _unit) then {

							[playerSide, "HQ"] commandChat format ["%1, Unlimited Ammo Not Enabled!",name _unit];

							};

							_unit setDamage 0;
							
						};
					};		
				};						
			};
	case 2: {	
					
			for "_i" from 0 to count (units group player) - 1 do
			
				{
					_unit = (units group player) select _i;

				switch true do 
				
					{
						case (side _unit isEqualTo WEST) :  {
																					
							_unit execVM "UnlimitedAmmo.sqf";	
						};
						case (side _unit isEqualTo EAST) :  {
													
							_unit execVM "UnlimitedAmmo.sqf";
						};
						case (side _unit isEqualTo RESISTANCE) :  {
																			
							_unit execVM "UnlimitedAmmo.sqf";
						};
						case (side _unit isEqualTo CIVILIAN) :  {
													
							_unit execVM "UnlimitedAmmo.sqf";
						};
					};		
				};						
			};
	case 3: {
				
			for "_i" from 0 to count (if ismultiplayer then {playableunits} else {switchableunits}) - 1 do
			
				{
					_unit = (if ismultiplayer then {playableunits} else {switchableunits}) select _i;
				
				switch true do 
				
					{
						case (side _unit isEqualTo WEST) :  {
													
							_unit execVM "UnlimitedAmmo.sqf";	
						};
						case (side _unit isEqualTo EAST) :  {
													
							_unit execVM "UnlimitedAmmo.sqf";	
						};
						case (side _unit isEqualTo RESISTANCE) :  {
													
							_unit execVM "UnlimitedAmmo.sqf";
						};
						case (side _unit isEqualTo CIVILIAN) :  {
													
							_unit execVM "UnlimitedAmmo.sqf";	
						};
					};		
				};	
			};					
};

