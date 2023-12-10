// "initPlayerServer.sqf" //
if !(hasInterface) exitWith {};

[playerSide, "HQ"] commandChat "Initiating InitPlayerServer!";

_respawnmrkr = switch (playerSide) do {
	case WEST: 			{"respawn_west_base"};
	case EAST: 			{"respawn_east_base"};
	case RESISTANCE: 	{"respawn_guerrila_base"};
	case CIVILIAN: 		{"respawn_civilian_base"};
};

[missionnamespace,"arsenalOpened", {
    titletext [format ["Welcome, your role is: %1.", getText(configFile >> "CfgVehicles" >> (typeOf player) >> "displayName")],"PLAIN DOWN"];
}] call bis_fnc_addScriptedEventhandler;

[missionnamespace,"arsenalClosed", {
    [player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
    titletext ["\nArsenal loadout saved.", "PLAIN DOWN"];
}] call bis_fnc_addScriptedEventhandler;

{if (_x in (units group player)) then  {
	_x addEventHandler ["InventoryClosed", {
		params ["_unit", "_container"];
		_addWeapon = [_unit,currentWeapon _unit,1] call BIS_fnc_addWeapon;
		_unit setVariable ["loadout",(getUnitLoadout _unit)];
		titletext ["\nLoadout Saved", "PLAIN DOWN"];
	}];
}} forEach (if ismultiplayer then {playableunits} else {switchableunits});

addMissionEventHandler ["TeamSwitch", {
    params ["_previousUnit", "_newUnit"];
    [_previousUnit, _newUnit] execVM "OnTeamSwitch.sqf";
}];

addMissionEventHandler ["MapSingleClick", {
    params ["_units", "_pos", "_alt", "_shift"];
	    if (_shift) then {
    	for "_i" from count waypoints (group player) - 1 to 0 step -1 do
	    {
	        deleteWaypoint [(group player), _i];
	    };
		_hpad = switch (playerSide) do {
			case west: 			{hpad};
			case east: 			{hpad2};
			case resistance: 	{hpad3};
			case civilian:		{hpad5};
		};
	    if (isNull _hpad) then {
	    	_hpad = "Land_HelipadEmpty_F" createVehicle _pos;
	    	_hpad setPos (getPos _hpad findEmptyPosition [20,100,"B_Heli_Transport_03_F"]);
			_hpad setDir getDir (nearestBuilding _hpad);
		} else {
			_hpad setPos _pos;
	    	_hpad setPos (getPos _hpad findEmptyPosition [10,100,"B_Heli_Transport_03_F"]);
			_hpad setDir getDir (nearestBuilding _hpad);
		};
		_wp = (group player) addWaypoint [getPos _hpad, 0];
		_wp setWaypointType "GUARD";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointFormation "WEDGE";
		_wp setWaypointSpeed "NORMAL";		

		execVM "waypoint.sqf";
    };
}];

[] spawn {
	f1_options = {
		spawnoptions = 
		[
			["",true],
			["Quick Save", [2], "", -5, [["expression", "enableSaving [true, true];saveGame"]], "1", "1"]
		];
		spawnoptions pushBack ["Group HALO", [3], "", -5, [["expression", "execVM 'Bis_Halo.sqf'"]], "1", "1"];
		spawnoptions pushBack ["Shoulder Weapon", [4], "", -5, [["expression", "player action ['switchWeapon', player, player, -1]"]], "1", "1"];
		spawnoptions pushBack ["Group Teleport", [5], "", -5, [["expression", "execVM 'onMapClickTeleportGroup.sqf'"]], "1", "1"];
		spawnoptions pushBack ["Unflip Vehicle", [6], "", -5, [["expression", "[cursorTarget] execVM 'flipVehicle.sqf'"]], "1", "1"];		
		spawnoptions pushBack ["Create LAT Group", [7], "", -5, [["expression", "_latGrp = [screenToWorld [0.5,0.5], playerSide, ['B_W_Soldier_SL_F','B_W_Soldier_F','B_W_soldier_M_F','B_W_Soldier_LAT_F','B_W_Soldier_A_F','B_W_Medic_F'], [], ['Colonel','Major','Captain','Lieutenant','Sergeant','Corporal']] call BIS_fnc_spawnGroup;_latGrp copyWaypoints (group player);"]], "1", "1"];
		spawnoptions pushBack ["Create LAT Unit", [8], "", -5, [["expression", "['B_Soldier_LAT_F',position player,group player] execVM 'create.sqf';"]], "1", "1"];
		spawnoptions pushBack ["Create Medic", [9], "", -5, [["expression", "['B_Medic_F',position player,group player] execVM 'create.sqf';"]], "1", "1"];
		spawnoptions pushBack ["Add Ammo & FirstAid", [10], "", -5, [["expression", "[player] call fnc_addFirstAidKitsAndMags"]], "1", "1"];
		spawnoptions pushBack ["Reset Rating", [11], "", -5, [["expression","execVM 'paramsPlus\resetRating.sqf'"]], "1", "1"];

		showCommandingMenu "#USER:spawnoptions";
	};
	_radio=createTrigger["EmptyDetector",[0,0]];
	_radio setTriggerActivation["Alpha","PRESENT",true];
	_radio setTriggerStatements["this","0 spawn f1_options",""];
	1 setRadioMsg "OPTIONS - PLAYER";
};
/*
		spawnoptions pushBack ["Silence #2 Unit", [10], "", -5, [["expression", "((units group player) select 1) disableAI 'radioProtocol'"]], "1", "1"];
		spawnoptions pushBack ["Voice Able #2 Unit", [11], "", -5, [["expression", "((units group player) select 1) enableAI 'radioProtocol'"]], "1", "1"];
*/
[] spawn {
	f2_options = {
		spawnoptions = 
		[
			["",true],
			["Quick Save", [2], "", -5, [["expression", "enableSaving [true, true];saveGame"]], "1", "1"]
		];
		spawnoptions pushBack ["CT Lightning Zap", [3], "", -5, [["expression", "[cursorTarget, nil, true] spawn BIS_fnc_moduleLightning"]], "1", "1"];
		spawnoptions pushBack ["CT Join Player", [4], "", -5, [["expression", "[cursorTarget] join (group player)"]], "1", "1"];
		spawnoptions pushBack ["CT GrpNull", [5], "", -5, [["expression", "[cursorTarget] join grpNull"]], "1", "1"];
		spawnoptions pushBack ["CT Arsenal", [6], "", -5, [["expression", "cursorTarget addaction ['Open Virtual Arsenal', { ['Open',true] call BIS_fnc_arsenal }]"]], "1", "1"];
		spawnoptions pushBack ["CT Garage", [7], "", -5, [["expression", "cursorTarget addaction ['Open Virtual Garage', { ['Open',true] call BIS_fnc_garage }]"]], "1", "1"];
		spawnoptions pushBack ["CT Garage Center", [8], "", -5, [["expression", "BIS_fnc_garage_center = createVehicle ['Land_HelipadEmpty_F', screenToWorld [0.5,0.5], [], 0, 'CAN_COLLIDE']"]], "1", "1"];
		spawnoptions pushBack ["Get BackPack", [9], "", -5, [["expression", "player addBackpackGlobal 'B_AssaultPack_khk'"]], "1", "1"];
		spawnoptions pushBack ["SetUnitLoadout", [10], "", -5, [["expression", "[missionNamespace, ['player_loadout',getUnitLoadout player]] remoteExec ['setVariable', groupOwner (group player)]"]], "1", "1"];
		spawnoptions pushBack ["GetUnitLoadout", [11], "", -5, [["expression", "[player, (missionNamespace getVariable ['player_loadout', []])] remoteExec ['setUnitLoadout', groupOwner (group player)]"]], "1", "1"];		
		showCommandingMenu "#USER:spawnoptions";
	};
	_radio=createTrigger["EmptyDetector",[0,0]];
	_radio setTriggerActivation["Bravo","PRESENT",true];
	_radio setTriggerStatements["this","0 spawn f2_options",""];
	2 setRadioMsg "OPTIONS - GROUP";
};

[] spawn {  // (vehicle player) addMagazineTurret [_removeMag,[-1]];
	f3_options = {
		spawnoptions = 
		[
			["",true],
			["Vehicle Unlock", [2], "", -5, [["expression", "cursorTarget setVehicleLock 'UNLOCKED'"]], "1", "1"]
		];
		spawnoptions pushBack ["Vehicle Reload", [3], "", -5, [["expression", "(vehicle player) setVehicleAmmo 1"]], "1", "1"];
		spawnoptions pushBack ["LimitSpeed 100", [4], "", -5, [["expression", "[(vehicle player),100] execVM 'paramsplus\limitSpeed.sqf'"]], "1", "1"];
		spawnoptions pushBack ["LimitSpeed 200", [5], "", -5, [["expression", "[(vehicle player),200] execVM 'paramsplus\limitSpeed.sqf'"]], "1", "1"];
		spawnoptions pushBack ["LimitSpeed 400", [6], "", -5, [["expression", "[(vehicle player),400] execVM 'paramsplus\limitSpeed.sqf'"]], "1", "1"];		
		spawnoptions pushBack ["FlyInHeight 40", [7], "", -5, [["expression", "(vehicle player) flyInHeight 40;"]], "1", "1"];
		spawnoptions pushBack ["FlyInHeight 200", [8], "", -5, [["expression", "(vehicle player) flyInHeight 200;"]], "1", "1"];
		spawnoptions pushBack ["STOP", [9], "", -5, [["expression", "[(vehicle player),0] execVM 'paramsplus\limitSpeed.sqf'"]], "1", "1"];
		spawnoptions pushBack ["LAND", [10], "", -5, [["expression", "(vehicle player) land 'LAND'"]], "1", "1"];
		spawnoptions pushBack ["EJECT", [11], "", -5, [["expression", "player action ['Eject', vehicle player]"]], "1", "1"];
		showCommandingMenu "#USER:spawnoptions";
	};
	_radio=createTrigger["EmptyDetector",[0,0]];
	_radio setTriggerActivation["Charlie","PRESENT",true];
	_radio setTriggerStatements["this","0 spawn f3_options",""];
	3 setRadioMsg "OPTIONS - FLIGHT";
};
/*
[] spawn {
	f3_options = {
		spawnoptions = 
		[
			["",true],
			["Volume", [2], "", -5, [["expression", "if (musicVolume > 0) then { 1 fadeMusic 0; player commandChat 'Music volume - 0'; } else { 1 fadeMusic 1; player commandChat 'Music volume - 1'; };"]], "1", "1"]
		];
		spawnoptions pushBack ["OM_Intro",[3],"",-5,[["expression","playMusic 'OM_Intro'"]],"1","1"];
		spawnoptions pushBack ["OM_Music01",[4],"",-5,[["expression","playMusic 'OM_Music01'"]],"1","1"];
		spawnoptions pushBack ["OM_Music02",[5],"",-5,[["expression","playMusic 'OM_Music02'"]],"1","1"];
		spawnoptions pushBack ["OM_Music03",[6],"",-5,[["expression","playMusic 'OM_Music03'"]],"1","1"];
		spawnoptions pushBack ["LeadTrack02_F_Bootcamp",[7],"",-5,[["expression","playMusic 'LeadTrack02_F_Bootcamp'"]],"1","1"];
		spawnoptions pushBack ["LeadTrack03_F_Bootcamp",[8],"",-5,[["expression","playMusic 'LeadTrack03_F_Bootcamp'"]],"1","1"];
		spawnoptions pushBack ["Track_C_01",[9],"",-5,[["expression","playMusic 'Track_C_01'"]],"1","1"];
		spawnoptions pushBack ["Track_C_02",[10],"",-5,[["expression","playMusic 'Track_C_02'"]],"1","1"];
		spawnoptions pushBack ["Track_C_03",[11],"",-5,[["expression","playMusic 'Track_C_03'"]],"1","1"];
		showCommandingMenu "#USER:spawnoptions";
	};
	_radio=createTrigger["EmptyDetector",[0,0]];
	_radio setTriggerActivation["Charlie","PRESENT",true];
	_radio setTriggerStatements["this","0 spawn f3_options",""];
	3 setRadioMsg "OPTIONS - MUSIC";
};
*/
[] spawn {
	f4_options = {
		spawnoptions = 
		[
			["",true],
			["ENABLE AI", [2], "", -5, [["expression", "{_x enableAi 'ALL'} forEach units group player"]], "1", "1"]
		];
		spawnoptions pushBack ["AUTOTARGET", [3], "", -5, [["expression", "{_x disableAi 'AUTOTARGET'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["TARGET", [4], "", -5, [["expression", "{_x disableAi 'TARGET'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["SUPPRESSION", [5], "", -5, [["expression", "{_x disableAi 'SUPPRESSION'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["PATH", [6], "", -5, [["expression", "{_x disableAi 'PATH'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["COVER", [7], "", -5, [["expression", "{_x disableAi 'COVER'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["LIGHTS", [8], "", -5, [["expression", "{_x disableAi 'LIGHTS'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["NVG", [9], "", -5, [["expression", "{_x disableAi 'NVG'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["RADIOPROTOCOL", [10], "", -5, [["expression", "{_x disableAi 'RADIOPROTOCOL'} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["AIMINGERROR", [11], "", -5, [["expression", "{_x disableAi 'AIMINGERROR'} forEach units group player"]], "1", "1"];
		showCommandingMenu "#USER:spawnoptions";
	};
	_radio=createTrigger["EmptyDetector",[0,0]];
	_radio setTriggerActivation["Delta","PRESENT",true];
	_radio setTriggerStatements["this","0 spawn f4_options",""];
	4 setRadioMsg "OPTIONS - FSM";
};

[] spawn {
	f5_options = {
		spawnoptions = 
		[
			["",true],
			["Quick Save", [2], "", -5, [["expression", "enableSaving [true, true];saveGame"]], "1", "1"]
		];
		spawnoptions pushBack ["Heal Player", [3], "", -5, [["expression", "[player] execVM 'HealPlayer.sqf'"]], "1", "1"];
		spawnoptions pushBack ["Do Follow", [4], "", -5, [["expression", "{_x doFollow player} forEach units group player"]], "1", "1"];
		spawnoptions pushBack ["MapClick Waypoint", [5], "", -5, [["expression", "execVM 'waypoint.sqf'"]], "1", "1"];
		spawnoptions pushBack ["CT Neutralize", [6], "", -5, [["expression", "cursorTarget call BIS_fnc_neutralizeUnit"]], "1", "1"];
		spawnoptions pushBack ["OnGroupIcon", [7], "", -5, [["expression", "execVM 'OnGroupIcon.sqf'"]], "1", "1"];
		spawnoptions pushBack ["Mortar Bag", [8], "", -5, [["expression", "call KK_playerAddMortarBag"]], "1", "1"];
		spawnoptions pushBack ["CT Recruits", [9], "", -5, [["expression", "[cursortarget] execVM 'bon_recruit_units\open_dialog.sqf'"]], "1", "1"];
		spawnoptions pushBack ["CT Add Ammo & FirstAid", [10], "", -5, [["expression", "[cursortarget] call fnc_addFirstAidKitsAndMags"]], "1", "1"];
		spawnoptions pushBack ["Add Ammo & FirstAid", [11], "", -5, [["expression", "[player] call fnc_addFirstAidKitsAndMags"]], "1", "1"];
		showCommandingMenu "#USER:spawnoptions";
	};
	_radio=createTrigger["EmptyDetector",[0,0]];
	_radio setTriggerActivation["Echo","PRESENT",true];
	_radio setTriggerStatements["this","0 spawn f5_options",""];
	5 setRadioMsg "OPTIONS - FORMATION";
};

_trg6 = createTrigger ["EmptyDetector", [0,0,0]];
_trg6 setTriggerActivation ["Foxtrot", "PRESENT", true];
_trg6 setTriggerText "DISABLE RADIO";
_trg6 setTriggerStatements ["this", "
enableRadio false;
enableSentences false;
{_x disableConversation true} forEach units group player;
hint parseText format['<t size=''1.25'' color=''#FF5500''>Radio Transmissions Disabled!</t>'];
", ""];

_trg7 = createTrigger ["EmptyDetector", [0,0,0]];
_trg7 setTriggerActivation ["Golf", "PRESENT", true];
_trg7 setTriggerText "ENABLE RADIO";
_trg7 setTriggerStatements ["this", "
enableRadio true;
enableSentences true;
{_x disableConversation false} forEach units group player;
hint parseText format['<t size=''1.25'' color=''#00FFFF''>Radio Transmissions Enabled!</t>'];
", ""];

if isMultiplayer then { 

_trg8 = createTrigger ["EmptyDetector", [0,0,0]];
_trg8 setTriggerActivation ["Hotel", "PRESENT", true];
_trg8 setTriggerText "RESPAWN TICKET ADD";
_trg8 setTriggerStatements ["this", "[playerSide, 1] call BIS_fnc_respawnTickets;", ""];

} else {

_trg9 = createTrigger ["EmptyDetector", [0,0,0]];
_trg9 setTriggerActivation ["India", "PRESENT", true];
_trg9 setTriggerText "LOAD GAME";
_trg9 setTriggerStatements ["this", "LoadGame", ""];

};

_trg10 = createTrigger ["EmptyDetector", [0,0,0]];
_trg10 setTriggerActivation ["Juliet", "PRESENT", true];
_trg10 setTriggerText "SAVE GAME";
_trg10 setTriggerStatements ["this", "enableSaving true; SaveGame;", ""];

waitUntil {BIS_CP_targetLocationID > -1};

[
	["CROSSROAD", "Mission is a go, I repeat, mission is a go! Crossroad, out.", 0]
] spawn BIS_fnc_EXP_camp_playSubtitles;

waitUntil {!isNil "BIS_CP_initDone"};

_mrkrColor = switch (playerSide) do 
	{
		case west: 			{"ColorBLUFOR"};
		case east: 			{"ColorOPFOR"};
		case resistance: 	{"ColorIndependent"};
		case civilian: 		{"ColorCivilian"};
	};
_rallyvar = switch (playerSide) do 
	{
		case WEST: 			{"respawn_west"};
		case EAST: 			{"respawn_east"};
		case RESISTANCE: 	{"respawn_guerrila"};
		case CIVILIAN: 		{"respawn_civilian"};
	};

uisleep 20;
   
createMarkerLocal [_rallyvar, position player];
_rallyvar setMarkerTypeLocal "respawn_inf";
_rallyvar setMarkerShapeLocal "Icon";
_rallyvar setMarkerTextLocal _rallyvar;
_rallyvar setMarkerSizeLocal [1,1];
_rallyvar setMarkerColorLocal _mrkrColor; 

_logicGroup = createGroup (playerSide);
_rallyvar = _logicGroup createUnit ["ModuleRespawnPosition_F",position player, [], 0, "FORM"]; 

[playerSide, "HQ"] commandChat "Initiating Respawn Marker At Player's Position!";

BIS_holdActionSFX = (getArray (configFile >> "CfgSounds" >> "Orange_Action_Wheel" >> "sound")) param [0, ""];
BIS_holdActionSFX = BIS_holdActionSFX + ".wss";
BIS_holdActionProgress = 
{
	private _progressTick = _this select 4; 
	if ((_progressTick % 2) == 0) exitwith {}; 
	
	private _coef = _progressTick / 24; 
	playSound3D [BIS_holdActionSFX, player, false, getPosASL player, 1, 0.9 + 0.2 * _coef];
};

fnc_Garage99 = {
	_pos = getPos BIS_garage_center_666;BIS_fnc_garage_center = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];["Open", true] call BIS_fnc_garage;};
fnc_Garage98 = {
	_pos = getPos BIS_garage_center_444;BIS_fnc_garage_center = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];["Open", true] call BIS_fnc_garage;};
fnc_Garage97 = {
	_pos = getPos BIS_garage_center_111;BIS_fnc_garage_center = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];["Open", true] call BIS_fnc_garage;};
fnc_Garage96 = {
	_pos = getPos BIS_garage_center_555;BIS_fnc_garage_center = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];["Open", true] call BIS_fnc_garage;};
fnc_Garage95 = {
	_pos = getPos BIS_garage_center_333;BIS_fnc_garage_center = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];["Open", true] call BIS_fnc_garage;};
fnc_Garage94 = {
	_pos = getPos BIS_garage_center_222;BIS_fnc_garage_center = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];["Open", true] call BIS_fnc_garage;};

{[_x, "Open the Arsenal", "\A3\Ui_f\data\Logos\a_64_ca.paa", "\A3\Ui_f\data\Logos\a_64_ca.paa", "(_this distance _target < 6) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {["Open",true] call BIS_fnc_arsenal;}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;} forEach [crat99,crat98,crat97,crat96,crat95,crat94];
[gar99, "Open the Airstrip Garage", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "(_this distance _target < 6) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {[[], fnc_Garage99] remoteExec ["call", 0];}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;
[gar98, "Open the Road Garage", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "(_this distance _target < 6) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {[[], fnc_Garage98] remoteExec ["call", 0];}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;
[gar97, "Open the Helipad Garage", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "(_this distance _target < 6) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {[[], fnc_Garage97] remoteExec ["call", 0];}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;
[gar96, "Open the Garage", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "(_this distance _target < 6) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {[[], fnc_Garage96] remoteExec ["call", 0];}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;
[gar95, "Open the Garage", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "(_this distance _target < 6) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {[[], fnc_Garage95] remoteExec ["call", 0];}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;
[gar94, "Open the Garage", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "\A3\Ui_f\data\igui\cfg\actions\getinpilot_ca.paa", "(_this distance _target < 6) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {[[], fnc_Garage94] remoteExec ["call", 0];}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;

kouris execVM "Intel\intel_kouris.sqf";

[BIS_laptop01, localize "STR_A3_Orange_Faction_IDAP_action_article", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_view_article_ca", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_view_article_ca", "(_this distance _target < 3) && (isNull (findDisplay 2035))", "isNull (findDisplay 2035)", {}, BIS_holdActionProgress, {BIS_laptop01 say3D "Orange_Read_Article"; [] execVM "Intel\article.sqf"}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;

[BIS_TV1, localize "STR_A3_Orange_Faction_IDAP_action_FM", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_access_fm_ca", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_access_fm_ca", "(_this distance _target < 3) && (isNull (findDisplay 162))", "isNull (findDisplay 162)", {}, BIS_holdActionProgress, {BIS_TV1 say3D "Orange_Access_FM"; ["InternationalHumanitarianLaw", "Overview", findDisplay 46, localize "STR_A3_Orange_Faction_IDAP_FM_filter_LoW"] call BIS_fnc_openFieldManual}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;

[BIS_laptop1, localize "STR_A3_Orange_Faction_IDAP_action_article", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_view_article_ca", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_view_article_ca", "(_this distance _target < 3) && (isNull (findDisplay 2035))", "isNull (findDisplay 2035)", {}, BIS_holdActionProgress, {BIS_laptop1 say3D "Orange_Read_Article"; [] execVM "\a3\Missions_F_Orange\Campaign\Functions\fn_showCampaignArticle.sqf"}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;

[News01, localize "STR_A3_Orange_Faction_IDAP_action_article", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_view_article_ca", "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_view_article_ca", "(_this distance _target < 3) && (isNull (findDisplay 2035))", "isNull (findDisplay 2035)", {}, BIS_holdActionProgress, {BIS_laptop1 say3D "Orange_Read_Article"; [] execVM "\a3\Missions_F_Orange\Campaign\Functions\fn_showCampaignArticle.sqf"}, {}, [], 0.5, nil, false] call BIS_fnc_holdActionAdd;

//[[displayTV02,displayLaptop02]] execVM "MIL_Mirror\initialise.sqf";

private _toRemoteExec = {  
    laptopHackHoldActionId = [  
	  	laptopp2,  
	   	"Extra Tasks",  
	   	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
	  	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
	   	"_this distance _target < 4",  
	   	"_caller distance _target < 4",  
	   	{},  
	   	{},  
	   	{ execVM "extraTasks.sqf" },  
	   	{},  
	   	[],  
	 	12,  
	  	0,  
	 	true,  
	    false  
  	] call BIS_fnc_holdActionAdd;  
};  
[[], _toRemoteExec] remoteExec ["spawn", 0, laptopp2];   
//[laptopp2, laptopHackHoldActionId] remoteExec ["BIS_fnc_holdActionRemove", 0];

private _toRemoteExec = {  
	radioHackHoldActionId = [  
		supph2, 
		"Meet with Alexis Kouris", 
		"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"isNil 'var_meet' && _this distance _target < 4", 
		"isNil 'var_meet' && _caller distance _target < 4", 
		{}, 
		{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FFFF00'>Briefing</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#00FF00'>(%1); Complete</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]}, 
		{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#00FF00'>Briefed</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; execVM "extratask1.sqf"; missionNamespace setVariable ["var_meet",true,true];_target say3D "Orange_Access_FM"; sleep 5; "" remoteExec ["hintSilent"]}, 
		{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; sleep 5; "" remoteExec ["hintSilent"]}, 
		[], 
		12,  
		0,  
		true,  
		false  
	] call BIS_fnc_holdActionAdd;
};  
[[], _toRemoteExec] remoteExec ["spawn", 0, supph2];   

[missionNamespace,(player modelToWorld [0,0,0]),_respawnmrkr] call BIS_fnc_addRespawnPosition;

//[supph2, radioHackHoldActionId] remoteExec ["BIS_fnc_holdActionRemove", 0];
/*
private _toRemoteExec = {  
	tvHackHoldActionId = [  
		tablet01, 
		"UAV TV ONE", 
		"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
		"_this distance _target < 4", 
		"_caller distance _target < 4", 
		{}, 
		{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>UAV TV ONE</t><br/><br/><t size='1.5' color='#FFFF00'>Incomplete</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#00FF00'>(%1)  Loading...</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]}, 
		{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>UAV TV ONE</t><br/><br/><t size='1.5' color='#00FF00'>Complete<br/>Check Monitor</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; [tv,_caller] execVM "predicam\liveFeedUAV_init.sqf"; _target say3D "Orange_Access_FM"; sleep 5; "" remoteExec ["hintSilent"]}, 
		{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>UAV TV ONE</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; sleep 5; "" remoteExec ["hintSilent"]}, 
		[], 
		12,  
		0,  
		false,  
		false  
	] call BIS_fnc_holdActionAdd;
};  
[[], _toRemoteExec] remoteExec ["spawn", 0, tablet01];   
//[tv, tvHackHoldActionId] remoteExec ["BIS_fnc_holdActionRemove", 0];
*/
/*
private _toRemoteExec = {  
    laptopHackHoldActionId = [  
      laptopp2,  
      "Extra Tasks",  
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
      "_this distance _target < 4",  
      "_caller distance _target < 4",  
      {},  
      {},  
      { execVM "extraTasks.sqf" },  
      {},  
      [],  
      12,  
      0,  
      true,  
      false  
  ] call BIS_fnc_holdActionAdd;  
};  
[[], _toRemoteExec] remoteExec ["spawn", 0, laptopp2];   
[laptopp2, laptopHackHoldActionId] remoteExec ["BIS_fnc_holdActionRemove", 0];

[this, 
"Meet with Alexis Kouris", 
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa", 
"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
"isNil 'var_meet' && _this distance _target < 4", 
"isNil 'var_meet' && _caller distance _target < 4", 
{}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FFFF00'>Briefing</t><br/><t color='#FFFF00'></t><br/><br/><t size='1.25' color='#00FF00'>(%1); Complete</t><br/><br/>",round ((_this select 4) * 4.16),name (_this select 1)] remoteExec ["hintSilent"]}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#00FF00'>Briefed</t><br/><t color='#00FF00'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"]; execVM "extratask1.sqf"; missionNamespace setVariable ["var_meet",true,true]; sleep 5; "" remoteExec ["hintSilent"]}, 
{parseText format["<br/><img size='2' image='\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa'/><br/><br/><t size='1.5'>Meet with Alexis Kouris</t><br/><br/><t size='1.5' color='#FF0000'>Cancelled</t><br/><t color='#FF0000'>(%1)</t><br/><br/><br/><br/>",name (_this select 1)] remoteExec ["hintSilent"];}, 
[], 
12,  
0,  
true,  
false  
] call BIS_fnc_holdActionAdd;

this setVariable ["RscAttributeDiaryRecord_texture","a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa", true]; 
   [this,"RscAttributeDiaryRecord",["Top Secret Docs","<br /><execute expression=""[(group player), 'my intel task', ['an intel task', 'secret docs', ''], [0,0,0], 'ASSIGNED', 0] call BIS_fnc_taskCreate"">These Docs outline the enemies defenses</execute><br />",""]] call bis_fnc_setServerVariable; 
   this setVariable ["recipients", west, true]; 
   [this,"init"] spawn bis_fnc_initIntelObject; 

this setVariable ["RscAttributeDiaryRecord_texture","a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa", true]; 
[this,"RscAttributeDiaryRecord",["Top Secret Docs","These Docs outline the enemies defenses",""]] call bis_fnc_setServerVariable; 
this setVariable ["recipients", west, true]; 
[this,"init"] spawn bis_fnc_initIntelObject;

[this, "Intel\intel_kouris.sqf"] remoteExec ["execVM", 0, this];

private _toRemoteExec = {  
    laptopHackHoldActionId = [  
      laptopp2,  
      "Extra Tasks",  
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",  
      "_this distance _target < 4",  
      "_caller distance _target < 4",  
      {},  
      {},  
      { execVM "extraTasks.sqf" },  
      {},  
      [],  
      12,  
      0,  
      true,  
      false  
  ] call BIS_fnc_holdActionAdd;  
};  
[[], _toRemoteExec] remoteExec ["spawn", 0, laptopp2];   
[laptopp2, laptopHackHoldActionId] remoteExec ["BIS_fnc_holdActionRemove", 0];


*/

