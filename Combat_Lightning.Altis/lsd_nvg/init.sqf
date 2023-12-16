//-----init.sqf-----//
#define PATH "lsd_nvg\"
#define MAIN_DISPLAY (findDisplay 46)

if ( !isDedicated ) then
{
	// init shit
	lsd_nvkeymap 	= compile (preprocessFileLineNumbers (PATH + "f\lsd_nvkeymap.sqf"));
	lsd_nvOn 				= false;
	lsd_nvSensitivity 		= 20;
	lsd_nvSensitivityBar 	= [
		"      Dummy        ", 
		"|||||||||||||||||||<t color='#666666'></t>", 
		"||||||||||||||||||<t color='#666666'>|</t>", 
		"|||||||||||||||||<t color='#666666'>||</t>", 
		"||||||||||||||||<t color='#666666'>|||</t>", 
		"|||||||||||||||<t color='#666666'>||||</t>", 
		"||||||||||||||<t color='#666666'>|||||</t>", 
		"|||||||||||||<t color='#666666'>||||||</t>", 
		"||||||||||||<t color='#666666'>|||||||</t>", 
		"|||||||||||<t color='#666666'>||||||||</t>", 
		"||||||||||<t color='#666666'>|||||||||</t>", 
		"|||||||||<t color='#666666'>||||||||||</t>", 
		"||||||||<t color='#666666'>|||||||||||</t>", 
		"|||||||<t color='#666666'>||||||||||||</t>", 
		"||||||<t color='#666666'>|||||||||||||</t>", 
		"|||||<t color='#666666'>||||||||||||||</t>", 
		"||||<t color='#666666'>|||||||||||||||</t>", 
		"|||<t color='#666666'>||||||||||||||||</t>", 
		"||<t color='#666666'>|||||||||||||||||</t>", 
		"|<t color='#666666'>||||||||||||||||||</t>", 
		"     Automatic     "
	]; 
	
	// wait until in game before adding the keyEH
	waitUntil { !isNull MAIN_DISPLAY };
	MAIN_DISPLAY displayAddEventHandler ["KeyDown", "_this call lsd_nvkeymap"];
	
	_fCheckVisionMode = {
		if ( !(isNull player) ) then 
		{
			if ( currentVisionMode player == 1) then 
			{
				if ( !lsd_nvOn ) then 
				{ 
					if ( lsd_nvSensitivity == 20 ) then // go to auto mode
					{
						setAperture -1;
					} else // manual mode
					{
						setAperture (lsd_nvSensitivity / 2);
					};
					lsd_nvOn = true;
				};
			} else
			{
				if ( lsd_nvOn ) then 
				{ 
					setAperture -1;
					lsd_nvOn = false 
				};
			};
		};
	};
	[_fCheckVisionMode, 0, 0] call CBA_fnc_addPerFrameHandler; 
};
