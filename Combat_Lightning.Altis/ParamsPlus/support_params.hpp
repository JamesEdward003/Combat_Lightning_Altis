class CfgCommunicationMenu
{
    class Artillery
    {
        text = "Artillery Strike";      // Text displayed in the menu and in a notification
        submenu = "";                   // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this execVM 'ParamsPlus\arty.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa";  // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1";                   // Simple expression condition for enabling the item
        removeAfterExpressionCall = 0;  // 1 to remove the item after calling
//      [player,"Artillery"] call BIS_fnc_addCommMenuItem;
    };
    class Missile
    {
        text = "Missile Strike";        // Text displayed in the menu and in a notification
        submenu = "";                   // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this execVM 'ParamsPlus\arty_vls.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa";  // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1";                   // Simple expression condition for enabling the item
        removeAfterExpressionCall = 0;  // 1 to remove the item after calling
//      [player,"Missile"] call BIS_fnc_addCommMenuItem;
    };
    class LaserMissile
    {
        text = "Laser Missile Strike";      // Text displayed in the menu and in a notification
        submenu = "";                   // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this execVM 'ParamsPlus\arty_vls_laser.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa";  // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1";                   // Simple expression condition for enabling the item
        removeAfterExpressionCall = 0;  // 1 to remove the item after calling
//      [player,"LaserMissile"] call BIS_fnc_addCommMenuItem;
    };
    class Mortar
    {
        text = "Mortar Strike";     // Text displayed in the menu and in a notification
        submenu = "";                   // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this execVM 'ParamsPlus\mortar.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\mortar_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1";                   // Simple expression condition for enabling the item
        removeAfterExpressionCall = 0;  // 1 to remove the item after calling
//      [player,"SpawnMortar"] call BIS_fnc_addCommMenuItem;
    };
    class MortarBag
    {
        text = "Mortar Bag";        // Text displayed in the menu and in a notification
        submenu = "";                   // Submenu opened upon activation (expression is ignored when submenu is not empty.)
        expression = "_this execVM 'ParamsPlus\mortarBag.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\mortar_ca.paa"; // Icon displayed permanently next to the command menu
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa"; // Custom cursor displayed when the item is selected
        enable = "1";                   // Simple expression condition for enabling the item
        removeAfterExpressionCall = 0;  // 1 to remove the item after calling
//      [player,"SpawnMortarBag"] call BIS_fnc_addCommMenuItem;
    };
    class ParaTeam
    {
        text = "ParaTeam";
        submenu = "";
        expression = "_this execVM 'ParamsPlus\paraTeam.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";               
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"SpawnParaTeam"] call BIS_fnc_addCommMenuItem;
    };
    class ParaDrop
    {
        text = "ParaDrop";
        submenu = "";
        expression = "_this execVM 'ParamsPlus\paraDrop.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"SpawnParaDrop"] call BIS_fnc_addCommMenuItem;
    };
    class HaloJump
    {
        text = "Halo Jump";
        submenu = "";
        expression = "execVM 'ParamsPlus\Bis_Halo.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"HaloJump"] call BIS_fnc_addCommMenuItem;
    };
    class HaloJumpGroup
    {
        text = "Halo Jump Group";
        submenu = "";
        expression = "execVM 'ParamsPlus\Bis_Halo_Grp.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"HaloJumpGroup"] call BIS_fnc_addCommMenuItem;
    };
    class CargoDrop
    {
        text = "Cargo Drop";
        submenu = "";
        expression = "_this execVM 'ParamsPlus\cargodrop.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"SpawnCargoDrop"] call BIS_fnc_addCommMenuItem;
    };
    class AirSupport
    {
        text = "Helicopter CAS";
        submenu = "";
        expression = "_this execVM 'ParamsPlus\HeliCAS_circle.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"AirSupport"] call BIS_fnc_addCommMenuItem;
    };
    class AirLift
    {
        text = "7-Passenger AirLift";
        submenu = "";
        expression = "_this execVM 'ParamsPlus\HeliTransport.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"AirLift"] call BIS_fnc_addCommMenuItem;
    };
    class AirLift2
    {
        text = "14-Passenger AirLift2";
        submenu = "";
        expression = "_this execVM 'ParamsPlus\HeliTransport2.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"AirLift2"] call BIS_fnc_addCommMenuItem;
    };
    class WindSpeed
    {
        text = "Wind Speed";
        submenu = "";
        expression = "_this execVM 'ParamsPlus\WindSpeed.sqf'"; // [caller, pos, target, is3D, id]
        icon = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
        cursor = "\a3\Ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
        enable = "1";
        removeAfterExpressionCall = 0;
//      [player,"WindSpeed"] call BIS_fnc_addCommMenuItem;
    };  
};
