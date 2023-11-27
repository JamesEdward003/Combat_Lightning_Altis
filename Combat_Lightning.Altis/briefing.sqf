// "briefing.sqf" //
waitUntil {!isNil {player}};
waitUntil {player == player};
if (!isNil {player getVariable "Briefing"}) exitWith {};

player setVariable ["Briefing",true];

player createDiarySubject ["MyPage","Instructions"];

player createDiaryRecord ["MyPage", ["Instructions", "These missions can be played in singleplayer with game saves. They can also be played<br/>in multiplayer with respawn and access to selectable parameters.<br/>Alt-C Medic will allow you to heal yourself in<br/>a disabled state preventing the loss of briefing and task appointments. It will employ a<br/>medic within 100 meters to revive you while unconscious. Ctrl-C Lightning zaps<br/>an enemy with one from the clouds. Alt-T Group Teleport, Ctrl-T Player Teleport, Unflip<br/>Vehicle, Vehicle Unlock, MissileStrike, MortarStrike, Player Halo, Group Halo, Para Drop<br/>Reinforcements, and many others.<br/><br/>These missions use the Arma 3 basic game to run. Optionally, I use addon mods<br/>CBA_A3 and Enhanced Movement from the Steam Workshop."]];

player createDiaryRecord ["Diary", ["Rules Of Engagement","Captain Pettka's  10 Rules Of Engagement<br/><br/>Rule #1 - Don't get shot.<br/>Rule #2 - Short, controlled bursts.<br/>Rule #3 - Be proud you are a soldier.<br/>Rule #4 - Watch your bullet drop.<br/>Rule #5 - Patch your wounds.<br/>Rule #6 - Keep a full mag.<br/>Rule #7 - If in doubt, fall back.<br/>Rule #8 - Keep the enemy suppressed.<br/>Rule #9 - Follow orders.<br/>Rule #10 - Beware of confined spaces."]];

player createDiaryRecord ["Diary", ["Help", "Hints from Captain Pettka:<br/>
- Press 'Ctrl-C' for a Lightning Bolt to cursor target.<br/>
- Press 'Alt-C' to call a Medic to revive.<br/>
- Press 'Alt-T' for Group Teleport.<br/> 
- Press 'Ctrl-T' for Player Teleport.<br/>
- Press 'NUMPAD /' to toggle Scope/Open Sight.<br/>
- Press 'CapsLock' to shoulder rifle/holster handgun.<br/>
- Press '[ or ]' for L and R Panel GPS, Radar and MiniMap.<br/>
- Press 'V' twice in rapid succession to Open Parachute!<br/>
- Press '0-8' or '0-0' for Extra Support."]];

//player createDiaryRecord ["Diary", ["Extra Tasks","<execute expression='[1] call compilefinal preprocessFileLineNumbers ""extraTasks.sqf"";'>PRESS</execute>"], taskNull, "", false];
//player createDiaryRecord ["Diary", ["Execute","<execute expression='hint ""Some code"";'>Some text</execute>"], taskNull, "", false];
player createDiaryRecord ["Diary", ["Execute","<execute expression='hintSilent ""Firing Squad\nLethal Injection\nHang by the Neck""'>Your Choice</execute>"], taskNull, "", false];

player createDiaryRecord ["Diary", ["Extra Task Two","<execute expression='[1] call compilefinal preprocessFileLineNumbers ""extraTask2.sqf"";'>Green Menace!</execute>"], taskNull, "", false];

player createDiaryRecord ["Diary", ["Extra Task One","<execute expression='[1] call compilefinal preprocessFileLineNumbers ""extraTask1.sqf"";'>Red Threat!</execute>"], taskNull, "", false];

player createDiaryRecord ["Diary", ["Lightning", "<img image='\A3\Ui_F_Curator\Data\Logos\arma3_curator_artwork.jpg' width='500' height='800'/>"], taskNull, "", false]; //anti-air

player createDiaryRecord ["Diary", ["Surveillance Pictures","Picture No.1<br/>Time: 6.41 UTC<br/>Date: 13.11.2035<br/>Type: ZSU-39 Tigris Tracked Anti-Air<br/>Location: <marker name='envee1'>Altis</marker><br/><img image='\A3\EditorPreviews_F\Data\CfgVehicles\O_APC_Tracked_02_AA_F.jpg' width='367' height='256'/><br/><br/><br/><br/>Picture No.2<br/>Time: 6.44 UTC<br/>Date: 13.11.2035<br/>Type: 2S9 Sochor Mobile-Arty<br/>Location: <marker name='envee2'>Altis</marker><br/><img image='\A3\EditorPreviews_F\Data\CfgVehicles\O_MBT_02_arty_F.jpg' width='367' height='256'/><br/><br/><br/><br/>Picture No.3<br/>Time: 6.48 UTC<br/>Date: 13.11.2035<br/>Type: AWC 302 Nyx (AA) Tracked Anti-Air<br/>Location: <marker name='envee3'>Altis</marker><br/><img image='\A3\EditorPreviews_F_Tank\Data\CfgVehicles\I_LT_01_AA_F.jpg' width='367' height='256'/><br/><br/><br/><br/>Picture No.4<br/>Time: 6.49 UTC<br/>Date: 13.11.2035<br/>Type: FV-720 Mora APC Tracked Cannon<br/>Location: <marker name='envee4'>Altis</marker><br/><img image='\A3\EditorPreviews_F\Data\CfgVehicles\I_APC_tracked_03_cannon_F.jpg' width='367' height='256'/><br/><br/><br/><br/>"]];

waitUntil { (isServer || !isNull player) };

player setVariable ["Briefing",true];

[playerSide, "HQ"] commandChat "Briefing Done!";

SIR_fnc_Intel_1 = {
[
	[
		["title","Combat Lightning"],
		["meta",["Jim Ed Renfro",[2035,2,24,11,38],"CET"]],
		["textbold","Stealth After Nightfall Might Be Just The Ticket!"],
		["image",["\A3\Ui_F_Curator\Data\Logos\arma3_curator_artwork.jpg","Combat Lightning"]],
		["box",["\a3\Missions_F_Orange\Data\Img\Faction_IDAP_overview_CA.paa","Combat Lightning will turn you on!"]],
		["text","Get a load of THIS action!!!"],
		["textlocked",["Have a hankering to shoot up town?","STAY HOME PLEASE"]],
		["author",["Hq8EHMyUsC.paa<br/>\A3\Ui_f\data\GUI\Cfg\UnitInsignia\111thID_ca.paa","Jim Ed Renfro is a Make Arma Not War Soldier"]]
	]
] call BIS_fnc_showAANArticle;
};

player createDiaryRecord ["Diary", ["Intel from CROSSROAD", "
<execute expression='[] call SIR_fnc_Intel_1'>Intel_1</execute>
"]];
/*
player createDiaryRecord ["Diary", ["Intel", "Friendly base is on the ""base"" <marker name='base'>marker</marker>"]];

player createDiaryRecord ["Diary", ["Fonts","<font color='#7FFF00' size='30' face='TahomaB'>Font formatting and images and linebreaks are available to the diary record.</font>"], taskNull, "",false];

player createDiaryRecord ["Diary", ["Images", "<img image='\A3\Ui_F_Curator\Data\Logos\arma3_curator_artwork.jpg' width='500' height='800'/>"], taskNull, "", false];

player createDiaryRecord ["Diary", ["Linebreaks","Line1.<br/>Line2..<br/>Line3...<br/><br/><br/><br/>Line7......."], taskNull, "", false];
*/

