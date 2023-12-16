//-----fullScreenNightVision.sqf-----//
nvgoff = {

	PP_radial = ppEffectCreate ["radialBlur",100]; 
	PP_radial ppEffectEnable true; 
	PP_radial ppEffectAdjust [0.02,0.13,0.21,0.36]; 
	PP_radial ppEffectCommit 0;  
	PP_dynamic = ppEffectCreate ["DynamicBlur",100]; 
	PP_dynamic ppEffectEnable true; 
	PP_dynamic ppEffectAdjust [0.35]; 
	PP_dynamic ppEffectCommit 0; 
	PP_film = ppEffectCreate ["FilmGrain",2000]; 
	PP_film ppEffectEnable true; 
	PP_film ppEffectAdjust [0.14,1,1,0.5,0.5,true];
	PP_film ppEffectCommit 0;
	pp_Color = ppEffectCreate ["ColorCorrections", 1502];  
	pp_Color ppEffectEnable true;
	pp_Color ppEffectAdjust [1, 0.6, 0, [0, 0.1, 0.2, 0], [0, 1, 1.2, 0], [1, 1, 1, 0]];      
	pp_Color ppEffectCommit 0;
	pp_Color ppEffectForceInNVG true;
};

// ppEffectDestroy PP_radial; 
// ppEffectDestroy PP_dynamic;
// ppEffectDestroy pp_Color;

nvgon = {

	PP_radial = ppEffectCreate ["radialBlur",100]; 
	PP_radial ppEffectEnable true; 
	PP_radial ppEffectAdjust [0.02,0.13,0.21,0.36]; 
	PP_radial ppEffectCommit 0; 
	PP_chrom = ppEffectCreate ["ChromAberration",200]; 
	PP_chrom ppEffectEnable true; 
	PP_chrom ppEffectAdjust [-0.01,-0.01,true]; 
	PP_chrom ppEffectCommit 0; 
	PP_dynamic = ppEffectCreate ["DynamicBlur",400]; 
	PP_dynamic ppEffectEnable true; 
	PP_dynamic ppEffectAdjust [0.35]; 
	PP_dynamic ppEffectCommit 0; 
	PP_film = ppEffectCreate ["FilmGrain",2000]; 
	PP_film ppEffectEnable true; 
	PP_film ppEffectAdjust [0.30,1,2,2,1.99,true]; 
	PP_film ppEffectCommit 0;
	pp_Color = ppEffectCreate ["ColorCorrections", 1500];  
	pp_Color ppEffectEnable true;
	pp_Color ppEffectAdjust [1,1,0,0,0,0,0,0.5,1,1,0.4,0.299,0.587,0.114,0];
	pp_Color ppEffectCommit 0;
	pp_Color ppEffectForceInNVG true;
};

// ppEffectDestroy PP_radial; 
// ppEffectDestroy PP_chrom; 
// ppEffectDestroy PP_dynamic;
// ppEffectDestroy pp_Color;

// PP_film = ppEffectCreate ["FilmGrain",2000];
// PP_film ppEffectEnable true;
// PP_film ppEffectAdjust [0.14,1,1,0.5,0.5,true];
// PP_film ppEffectCommit 0;

if (!hasInterface) exitWith {}; // DO NOT DELETE THIS!

SL_var_fullScreenNightVision =
[
	"G_B_Diving",
	"G_Combat_Goggles_tna_F", // Combat Goggles (Green).
	"G_Balaclava_TI_G_tna_F"  // Stealth Balaclava (Green, Goggles).
];

SL_fn_fullScreenNightVision = {
	params ["_displayCode","_keyCode","_isShift","_isCtrl","_isAlt"];
	_handled = false;
	if ((_keyCode in actionKeys "NightVision") && (goggles player in SL_var_fullScreenNightVision)) then
	{
		switch SL_var_fullScreenNightVisionMode do
		{
			case 0: {
				if (cameraView != "GUNNER") then
				{
					player action ["nvGoggles", player];
					SL_var_fullScreenNightVisionMode = currentVisionMode player;
					[] call nvgon;
					_handled = true;
				};
			};
			case 1: {
				if (cameraView != "GUNNER") then
				{
					player action ["nvGogglesOff", player];
					SL_var_fullScreenNightVisionMode = currentVisionMode player;
					[] call nvgon;
					_handled = true;
				};
			};
		};
	};
	_handled
};

player addEventHandler ["GetOutMan", {
	params ["_player", "_role", "_vehicle", "_turret"];
	if (goggles _player in SL_var_fullScreenNightVision) then
	{
		switch SL_var_fullScreenNightVisionMode do
		{
			case 1: {
				_player action ["nvGoggles", _player];
				SL_var_fullScreenNightVisionMode = currentVisionMode _player;
			};
			case 0: {
				_player action ["nvGogglesOff", _player];
				SL_var_fullScreenNightVisionMode = currentVisionMode _player;
			};
		};
	};
}];

player addEventHandler ["Put", {
	params ["_player", "_container", "_item"];
	if (goggles _player in SL_var_fullScreenNightVision) then
	{
		switch SL_var_fullScreenNightVisionMode do
		{
			case 1: {
				_player action ["nvGoggles", _player];
				SL_var_fullScreenNightVisionMode = currentVisionMode _player;
			};
			case 0: {
				_player action ["nvGogglesOff", _player];
				SL_var_fullScreenNightVisionMode = currentVisionMode _player;
			};
		};
	};
}];

player addEventHandler ["Take", {
	params ["_player", "_container", "_item"];
	if (goggles _player in SL_var_fullScreenNightVision) then
	{
		switch SL_var_fullScreenNightVisionMode do
		{
			case 1: {
				_player action ["nvGoggles", _player];
				SL_var_fullScreenNightVisionMode = currentVisionMode _player;
			};
			case 0: {
				_player action ["nvGogglesOff", _player];
				SL_var_fullScreenNightVisionMode = currentVisionMode _player;
			};
		};
	};
}];

SL_var_fullScreenNightVisionMode = currentVisionMode player;

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call SL_fn_fullScreenNightVision;"];
