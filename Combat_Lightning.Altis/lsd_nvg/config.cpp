class CfgPatches
{
	class lsd_nvg
	{
		units[]={};
		weapons[]={};
		fileName="lsd_nvg.pbo";
		Version=1.1;
		requiredVersion=1;
		requiredAddons[]=
		{
			"A3_Characters_F_BLUFOR",
			"Extended_EventHandlers",
			"cba_main"
		};
	};
};
class cfgWeapons
{
	class Default;
	class Binocular;
	class NVGoggles: Binocular
	{
		modelOptics="";
	};
	class NVGoggles_OPFOR: Binocular
	{
		modelOptics="";
	};
	class NVGoggles_INDEP: Binocular
	{
		modelOptics="";
	};
};
class Extended_PreInit_EventHandlers
{
	lsd_nvg_init="[] execVM 'lsd_nvg\init.sqf'";
};
class RscTitles
{
	class lsd_Rsc_nvHint
	{
		idd=-1;
		onLoad="with uiNameSpace do { lsd_Rsc_nvHint = (_this select 0) }";
		movingEnable=0;
		fadeIn=0;
		fadeOut=0.5;
		duration=1;
		class Controls
		{
			class lsd_Rsc_nvHint_Label
			{
				idc=-1;
				type=0;
				style=2;
				x=0;
				y="(safeZoneH * 0.750) + safeZoneY + 0.005";
				w=1;
				h=0.033;
				colorBackground[]={0,0,0,0};
				colorText[]={1,1,1,1};
				font="TahomaB";
				sizeEx=0.024;
				text="NV Sensitivity:";
				shadow=2;
			};
			class lsd_Rsc_nvHint_Text
			{
				idc=1;
				type=13;
				style=2;
				x=0;
				y="(safeZoneH * 0.750) + safeZoneY + 0.033";
				w=1;
				h=0.039999999;
				colorBackground[]={0,0,0,0};
				colorText[]={1,1,1,1};
				font="Zeppelin32";
				size=0.039209999;
				text="";
				shadow=2;
				lineSpacing=1;
				class Attributes
				{
					align="center";
				};
			};
		};
	};
};
