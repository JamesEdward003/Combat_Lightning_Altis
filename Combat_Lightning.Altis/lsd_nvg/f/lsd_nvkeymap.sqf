//-----lsd_nvkeymap.sqf-----//
#define PAGE_UP 201
#define PAGE_DOWN 209
#define MAX_SENSITIVITY 1
#define MIN_SENSITIVITY 20
#define INCREMENT 1

private ["_ctrlID", "_dikCode", "_shift", "_ctrl", "_alt", "_handled"]; 

_ctrlID		= _this select 0; 
_dikCode 	= _this select 1; 
_shift 		= _this select 2; 
_ctrl 		= _this select 3; 
_alt 		= _this select 4;
_handled	= false;



if ( dialog || visibleMap || !lsd_nvOn || !_shift) exitWith { false };


switch ( _dikCode ) do
{
	case PAGE_UP:
	{
		if ( lsd_nvSensitivity > MAX_SENSITIVITY ) then
		{
			lsd_nvSensitivity = lsd_nvSensitivity - INCREMENT;
			_handled = true;
		};
	};
	case PAGE_DOWN:
	{
		if ( lsd_nvSensitivity < MIN_SENSITIVITY ) then
		{
			lsd_nvSensitivity = lsd_nvSensitivity + INCREMENT;
			_handled = true;
		};
	};
};

if ( _handled ) then 
{
	if ( lsd_nvSensitivity == 20 ) then // go to auto mode
	{
		setAperture -1;
	} else // manual mode
	{
		setAperture ( lsd_nvSensitivity / 2);
	};
		
	1000 cutRsc ["LSD_Rsc_nvHint","PLAIN"];
	((uiNamespace getVariable "LSD_Rsc_nvHint") displayCtrl 1) ctrlSetStructuredText parseText(lsd_nvSensitivityBar select lsd_nvSensitivity);
};


_handled
  
