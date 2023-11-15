// "Military_Symbol_Module.sqf" //
private ["_MSymbols"];
_MSymbols = "MSymbols" call BIS_fnc_getParamValue;

switch (_MSymbols) do
{
	case 1: 	{
		
				setGroupIconsVisible [false,false];	

			};
	case 2: 	{

				setGroupIconsVisible [true,false];
	
			};
			
	case 3: 	{	

				setGroupIconsVisible [false,true];

			};
	case 4: 	{	

				setGroupIconsVisible [true,true];
								
			};
};

