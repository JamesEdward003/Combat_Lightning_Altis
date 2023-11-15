class Params
{
    class Param_Daytime
    {
        title = "Time of Day";
        texts[]={"00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"};
        values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
        default = 16;
        function = "BIS_fnc_paramDaytime"; 
    };
    class BIS_CP_weather
    {
        title = $STR_A3_rscattributeovercast_title;
        values[] = { 0, 1, 2, 3};
        texts[] = {$STR_A3_combatpatrol_params_7, $STR_A3_combatpatrol_params_8, $STR_A3_combatpatrol_params_9, $STR_A3_combatpatrol_params_10};
        default = 2;
    };
    class Param_ViewDistance
    {
        title = "View Distance (in metres)";
        texts[] = {"500","800","1000","2000","3000","4000","5000","6000"};
        values[] = {500,800,1000,2000,3000,4000,5000,6000};
        default = 2000;
        function = "BIS_fnc_paramViewDistance";
    };
    class BIS_CP_garrison
    {
        title = $STR_A3_combatpatrol_params_11;
        values[] = {0, 1, 2};
        texts[] = {$STR_A3_combatpatrol_params_12, $STR_A3_combatpatrol_params_13, $STR_A3_combatpatrol_params_14};
        default = 1;
    };
    class BIS_CP_reinforcements
    {
        title = $STR_A3_combatpatrol_params_15;
        values[] = {0, 1, 2};
        texts[] = {$STR_A3_combatpatrol_params_12, $STR_A3_combatpatrol_params_13, $STR_A3_combatpatrol_params_16};
        default = 1;
    };
    class BIS_CP_showInsertion
    {
        title = $STR_A3_combatpatrol_params_17;
        values[] = {0, 1};
        texts[] = {$STR_A3_cfgvehicles_modulestrategicmapimage_f_arguments_shadow_values_no_0, $STR_A3_cfgvehicles_modulestrategicmapimage_f_arguments_shadow_values_yes_0};
        default = 0;
    };
    class BIS_CP_tickets
    {
        title = $STR_A3_CombatPatrol_params_18;
        values[] = { 5, 10, 20, 50, 100 };
        texts[] = { "5", "10", "20", "50", "100" };
        default = 5;
    };
    class BIS_CP_enemyFaction
    {
        title = $STR_A3_combatpatrol_params_19;
        values[] = {0, 1, 2};
        texts[] = {$STR_A3_cfgfactionclasses_opf_f0, $STR_A3_cfgfactionclasses_ind_f0, $STR_A3_bis_fnc_respawnmenuposition_random};
        default = 2;
    };
    class BIS_CP_objective
    {
        title = $STR_A3_combatpatrol_params_22;
        values[] = {-1, 1, 2, 3};
        texts[] = {$STR_A3_bis_fnc_respawnmenuposition_random, $STR_A3_combatpatrol_params_26, $STR_A3_combatpatrol_params_27, $STR_A3_combatpatrol_params_28};
        default = -1;
    };
    class BIS_CP_locationSelection
    {
        title = $STR_A3_combatpatrol_params_20;
        values[] = {0, 1};
        texts[] = {$STR_A3_combatpatrol_params_21, $STR_A3_bis_fnc_respawnmenuposition_random};
        default = 0;
    };
    class BI_CP_startLocation
    {
        title = "Base Start";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 2;
        file = "BaseStart.sqf";
    };
    class Bskill     
    {
        title = "Blufor Skill";
        values[] = {1, 2, 3, 4, 5};
        texts[] = {"Rookie", "Recruit", "Veteran", "Expert", "Random"};
        default = 4;
        file = "Skill\BluSkill.sqf";
    };
    class Oskill     
    {
        title = "Opfor Skill";
        values[] = {1, 2, 3, 4, 5};
        texts[] = {"Rookie", "Recruit", "Veteran", "Expert", "Random"};
        default = 3;
        file = "Skill\OpSkill.sqf";
    };
    class Rskill     
    {
        title = "Resistance Skill";
        values[] = {1, 2, 3, 4, 5};
        texts[] = {"Rookie", "Recruit", "Veteran", "Expert", "Random"};
        default = 2;
        file = "Skill\RSkill.sqf";
    };
    class BloodEffect
    {
        title = "Blood Effects (additional)";
        texts[] = {"0%","20%","40%","60%","80%","100%"};
        values[] = {0, 2, 4, 6, 8, 10};
        default = 8;
        function = "BIS_fnc_bloodEffect";
    };
    class PRegenHealth       
    {
        title = "Health Regeneration";
        values[] = {1, 2, 3, 4};
        texts[] = {"Disabled","Fair","Middlin","Good"};
        default = 2;
        file = "Regen_Health_Group.sqf";
    };
    class Alt_C_Medic       
    {
        title = "Alt_C_Medic";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 2;
        file = "AltC_Medic.sqf";
    };
    class Ctrl_C_Lightning       
    {
        title = "Ctrl-C Lightning";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 2;
        file = "CtrlC_Lightning.sqf";
    };
    class BI_CP_loadouts_wl
    {
        title = "Woodland Loadouts";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Units Group Player","All Playable or Switchable Units"};
        default = 3;
        file = "loadouts_woodland_group.sqf";
    };
    class BI_CP_loadouts_mtp
    {
        title = "MultiTerrain Loadouts";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Units Group Player","All Playable or Switchable Units"};
        default = 1;
        file = "loadouts_multiterrain_group.sqf";
    };
    class PRallyPoint      
    { 
        title = "Group Leader UAV Backpack and Rally Point";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 2;
        file = "RallyPoint_Group.sqf";
    };
    class PRallyTent      
    { 
        title = "Group Leader Rally Tent";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 2;
        file = "RallyTent_Group.sqf";
    };
    class PMarkers       
    {
        title = "Group Markers";
        values[] = {1, 2, 3, 4};
        texts[] = {"Disabled","Units Group Player","All Playable or Switchable Units","All Units"};
        default = 2;
        file = "ParamsPlus\markers_Group.sqf";
        isGlobal = 1;
    };
    class BI_CP_UnlimitedAmmo       
    {
        title = "Unlimited Ammo";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Units Group Player","All Playable or Switchable Units"};
        default = 2;
        file = "UnlimitedAmmo_Group.sqf";
    };
    class BI_CP_LoadoutAdjustments       
    {
        title = "Loadout Adjustments (Night-Vision And Silencers)";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Units Group Player","All Playable or Switchable Units"};
        default = 3;
        file = "LoadoutAdjustments_Group.sqf";
    };
    class BI_CP_SettingsAdjustments       
    {
        title = "Settings Adjustments (Unit Traits, Stamina And Fatigue)";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Units Group Player","All Playable or Switchable Units"};
        default = 2;
        file = "SettingsAdjustments_Group.sqf";
    };
    class BI_CP_GroupIconOver
    {
        title = "GroupIconOver";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 1;
        file = "OnGroupIcon.sqf";
    };
    class BI_CP_IntroCam
    {
        title = "Intro Camera";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Enabled - Intro","Enabled - Shift-Keypad O"};
        default = 1;
        file = "predicam\predicam_init.sqf";
    };
    class BI_CP_Kestrel
    {
        title = "Kestrel Flyer";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Enabled - Intro","Enabled - Alt-Keypad O"};
        default = 1;
        file = "predicam\kestrel_init.sqf";
    };
    class BI_CP_Cam
    {
        title = "BIS_fnc_cameraOld";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Enabled - Intro","Enabled - Shift-Keypad O"};
        default = 1;
        file = "predicam\cam_init.sqf";
    };
    class BI_CP_CamOldReWrite
    {
        title = "CamOldReWrite";
        values[] = {1, 2, 3};
        texts[] = {"Disabled","Enabled - Intro","Enabled - Shift-Keypad O"};
        default = 1;
        file = "predicam\CameraOld_init.sqf";
    };
    class MissionStatus
    {
        title = "Mission Status";
        texts[] = {"Disabled","Enabled"};
        values[] = {1,2};
        default = 2;
        file = "MissionStatus.sqf";
    };
    class MissionSaves      
    { 
        title = "Mission Saves";
        values[] = {1, 2, 3, 4};
        texts[] = {"Saving Disabled, No Autosave","Saving Disabled, Autosave","Saving Enabled, No Autosave","Saving Enabled, Autosave"};
        default = 1;
        file = "MissionSaves.sqf";
    };
    class MSymbols       
    {
        title = "Military Symbols";
        values[] = {1, 2, 3, 4};
        texts[] = {"Disabled","Map Only","3d Only","Both"};
        default = 4;
        file = "ParamsPlus\Military_Symbol_Module.sqf";
    };
    class SinglePlayerRespawn
    {
        title = "Single Player Respawn";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 1;
        file = "SinglePlayer_Respawn.sqf";
    };
    class AiSinglePlayerRespawn
    {
        title = "Ai Single Player Respawn";
        values[] = {1, 2};
        texts[] = {"Disabled","Enabled"};
        default = 1;
        file = "SP_Respawn_Group.sqf";
    };
    class Artillery      
    { 
        title = "Artillery Strike";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class Missile     
    { 
        title = "Missile Strike";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class LaserMissile    
    { 
        title = "Laser Missile Strike";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class Mortar     
    { 
        title = "Mortar Strike";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 1;
    };
    class MortarBag    
    { 
        title = "Mortar Bag";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class ParaTeam    
    { 
        title = "ParaTeam";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class ParaDrop    
    { 
        title = "ParaDrop";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class HaloJump    
    { 
        title = "Halo Jump";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class HaloJumpGroup
    { 
        title = "Halo Jump Group";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class CargoDrop
    { 
        title = "Cargo Drop";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 1;
    };
    class AirSupport
    { 
        title = "Air Support";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 1;
    };
    class AirLift
    { 
        title = "7-Passenger AirLift";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class AirLift2
    { 
        title = "14-Passenger AirLift";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 2;
    };
    class WindSpeed
    { 
        title = "Wind Speed";
        texts[] = {"Disabled","Enabled"};
        values[] = {1, 2};
        default = 1;
    };
    #include "\a3\Functions_F\Params\paramRevive.hpp"
};
