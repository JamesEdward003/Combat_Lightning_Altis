//-----fullScreenNV.sqf-----//
ModernWarfare = {

if (isDedicated) exitWith {};
if (player != player) then {waitUntil {player == player};};

	[] spawn {
		while {true} do {
		waitUntil {(currentVisionMode player) == 1};

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

		waitUntil {(currentVisionMode player) != 1};

		ppEffectDestroy PP_radial; 
		ppEffectDestroy PP_dynamic;
		ppEffectDestroy pp_Color;
		};
	};
};

Sicario = {
if (isDedicated) exitWith {};
if (player != player) then {waitUntil {player == player};};

	[] spawn {
		while {true} do {
		waitUntil {(currentVisionMode player) == 1};

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

		waitUntil {(currentVisionMode player) != 1};

		ppEffectDestroy PP_radial; 
		ppEffectDestroy PP_chrom; 
		ppEffectDestroy PP_dynamic;
		ppEffectDestroy pp_Color;

		PP_film = ppEffectCreate ["FilmGrain",2000];
		PP_film ppEffectEnable true;
		PP_film ppEffectAdjust [0.14,1,1,0.5,0.5,true];
		PP_film ppEffectCommit 0;
		};
	};
};

if (!hasInterface) exitWith {}; // DO NOT DELETE THIS!

SL_var_fullScreenNV =
[
	"G_B_Diving",
	"G_Combat_Goggles_tna_F", // Combat Goggles (Green).
	"G_Balaclava_TI_G_tna_F"  // Stealth Balaclava (Green, Goggles).
];

SL_fn_fullScreenNV = {
	params ["_displayCode","_keyCode","_isShift","_isCtrl","_isAlt"];
	_handled = false;
	if ((_keyCode in actionKeys "NightVision") && (goggles player in SL_var_fullScreenNV) && (getConnectedUAV player isNotEqualTo [])) then
	{
		switch SL_var_fullScreenNVMode do
		{
			case 0: {
				if (cameraView != "GUNNER") then
				{
					player action ["nvGoggles", player];
					SL_var_fullScreenNVMode = currentVisionMode player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
			case 1: {
				if (cameraView != "GUNNER") then
				{
					player action ["nvGogglesOff", player];
					SL_var_fullScreenNVMode = currentVisionMode player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
		};
	};
	if ((_keyCode in actionKeys "NightVision") && !(goggles player in SL_var_fullScreenNV) && (getConnectedUAV player isNotEqualTo [])) then
	{
		switch SL_var_fullScreenNVMode do
		{
			case 0: {
				if (cameraView != "GUNNER") then
				{
					player action ["nvGoggles", player];
					SL_var_fullScreenNVMode = currentVisionMode player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
			case 1: {
				if (cameraView != "GUNNER") then
				{
					player action ["nvGogglesOff", player];
					SL_var_fullScreenNVMode = currentVisionMode player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
		};
	};
	if ((_keyCode in actionKeys "NightVision") && (goggles player in SL_var_fullScreenNV) && (getConnectedUAV player isEqualTo [])) then
	{
		switch SL_var_fullScreenNVMode do
		{
			case 0: {
				if (cameraView == "GUNNER") then
				{
					player action ["nvGoggles", player];
					SL_var_fullScreenNVMode = currentVisionMode getConnectedUAVUnit player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
			case 1: {
				if (cameraView == "GUNNER") then
				{
					player action ["nvGogglesOff", player];
					SL_var_fullScreenNVMode = currentVisionMode getConnectedUAVUnit player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
		};
	};
	if ((_keyCode in actionKeys "NightVision") && !(goggles player in SL_var_fullScreenNV) && (getConnectedUAV player isEqualTo [])) then
	{
		switch SL_var_fullScreenNVMode do
		{
			case 0: {
				if (cameraView == "GUNNER") then
				{
					player action ["nvGoggles", player];
					SL_var_fullScreenNVMode = currentVisionMode getConnectedUAVUnit player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
			case 1: {
				if (cameraView == "GUNNER") then
				{
					player action ["nvGogglesOff", player];
					SL_var_fullScreenNVMode = currentVisionMode getConnectedUAVUnit player;
					[] call ModernWarfare;
					_handled = true;
				};
			};
		};
	};	
	_handled
};
if (getConnectedUAV player isNotEqualTo []) then {SL_var_fullScreenNVMode = currentVisionMode player;};
if (getConnectedUAV player isEqualTo []) then {SL_var_fullScreenNVMode = currentVisionMode getConnectedUAVUnit player;};

waitUntil {!(isNull (findDisplay 46))};
(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call SL_fn_fullScreenNV;"];
