//////////////////////////////////////////////////////////////////
// 		[vehicle] execVM "ParamsPlus\vehicleMarker.sqf"; 
//////////////////////////////////////////////////////////////////
private ["_vehicle","_vehType","_classname","_displayname","_marker","_group","_grp","_mrkrCnt","_text","_mrkrName","_mrkrcolor","_markertype","_array"];
_vehicle 		= _this select 0;
_vehType 		= getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
_classname 		= typeOf _vehicle;
_displayname 	= gettext (configfile >> "CfgVehicles" >> _className >> "displayName");
_marker 		= objNull;
_group		 	= group _vehicle;	
_mrkrCnt 	 	= missionNamespace getVariable "markerCount";

_text = toArray(str _group);
_text set[0,"**DELETE**"];
_text set[1,"**DELETE**"];
_text = _text - ["**DELETE**"];
_grp = toString(_text);

if (!(isNil { missionNamespace getVariable "markerCount"})) then
		{
		_mrkrCnt = missionNamespace getVariable "markerCount";
		_mrkrCnt = _mrkrCnt + 1;
		missionNamespace setVariable ["markerCount", _mrkrCnt, true];
}  else {		
		_mrkrCnt = 1;
		missionNamespace setVariable ["markerCount", _mrkrCnt, true];
};

_mrkrCnt = missionNamespace getVariable "markerCount";	
_mrkrName = format ["%1_%2",_vehType,_mrkrCnt];

_mrkrColor = switch (side _vehicle) do 
	{
		case west: 			{"colorBLUFOR"};
		case east: 			{"colorOPFOR"};
		case resistance: 	{"colorIndependent"};
		default 			{"ColorCivilian"};
	};
		
switch (side _vehicle) do 
	{
	case west: {	
			_markerType = switch true do 
			{
			case (_classname iskindof "camanbase"): {"b_inf"};
			case (_classname iskindof "car" || _classname iskindof "motorcycle"): {"b_mech_inf"};
			case (_classname iskindof "tank"|| _classname iskindof "wheeled_apc"): {"b_armor"};
			case (_classname iskindof "plane"): {"b_plane"};
			case (_classname isKindOf "helicopter"): {"b_air"};
			case (_classname iskindof "ship" || _classname iskindof "staticship"): {"b_naval"};
			case (_classname iskindof "staticweapon"): {"b_inf"};
			case (_classname iskindof "slingload_base_f"): {"mil_dot"};
			case (_classname iskindof "reammobox_f"): {"mil_dot"};
			case (_classname iskindof "logic"): {"mil_dot"};
			default {"b_support"};
			};
		};	
	case east: {		
			_markerType = switch true do 
			{
			case (_classname iskindof "camanbase"): {"o_inf"};
			case (_classname iskindof "car" ||_classname iskindof "motorcycle"): {"o_mech_inf"};
			case (_classname iskindof "tank"|| _classname iskindof "wheeled_apc"): {"o_armor"};
			case (_classname iskindof "air"): {"o_plane"};
			case (_classname isKindOf "helicopter"): {"o_air"};
			case (_classname iskindof "ship"): {"o_naval"};
			case (_classname iskindof "staticweapon"): {"o_inf"};
			case (_classname iskindof "slingload_base_f"): {"mil_dot"};
			case (_classname iskindof "reammobox_f"): {"mil_dot"};
			case (_classname iskindof "logic"): {"mil_dot"};
			default {"o_support"};
			};	
		};
	case resistance: {		
			_markerType = switch true do 
			{
			case (_classname iskindof "camanbase"): {"n_inf"};
			case (_classname iskindof "car" || _classname iskindof "motorcycle"): {"n_mech_inf"};
			case (_classname iskindof "tank"|| _classname iskindof "wheeled_apc"): {"n_armor"};
			case (_classname iskindof "air"): {"n_plane"};
			case (_classname isKindOf "helicopter"): {"n_air"};
			case (_classname iskindof "ship"): {"n_naval"};
			case (_classname iskindof "staticweapon"): {"n_inf"};
			case (_classname iskindof "slingload_base_f"): {"mil_dot"};
			case (_classname iskindof "reammobox_f"): {"mil_dot"};
			case (_classname iskindof "logic"): {"mil_dot"};
			default {"n_support"};
			};	
		};
	case civilian: {		
			_markerType = switch true do 
			{
			case (_classname iskindof "camanbase"): {"n_inf"};
			case (_classname iskindof "car" || _classname iskindof "motorcycle"): {"n_mech_inf"};
			case (_classname iskindof "tank"|| _classname iskindof "wheeled_apc"): {"n_armor"};
			case (_classname iskindof "air"): {"n_plane"};
			case (_classname isKindOf "helicopter"): {"n_air"};
			case (_classname iskindof "ship"): {"n_naval"};
			case (_classname iskindof "staticweapon"): {"n_inf"};
			case (_classname iskindof "slingload_base_f"): {"mil_dot"};
			case (_classname iskindof "reammobox_f"): {"mil_dot"};
			case (_classname iskindof "logic"): {"mil_dot"};
			default {"n_support"};
			};	
		};
	}; 	
	
if (isMultiPlayer) then {	
	_vehicle addEventHandler ["Respawn",{_this execVM "ParamsPlus\vehicleMarker.sqf"}];
};

_array = ["slingload_base_f", "reammobox_f"];

if (_classname isKindOf "slingload_base_f" or _classname isKindOf "reammobox_f") then {
	_marker = createMarkerLocal [_mrkrName, position _vehicle];
	_marker setMarkerTypeLocal _markerType;
	_marker setMarkerColorLocal _mrkrColor;
	_marker setMarkerTextLocal _displayName;
	_marker setMarkerSizeLocal [0.5,0.5];
	hintSilent parseText format["<t size='1' color='#00FFFF'>AmmoBox on the map marker!</t>"];
} else {
	While {alive _vehicle} do {
		_marker = createMarkerLocal [_mrkrName, position _vehicle];
		_marker setMarkerTypeLocal _markerType;
		_marker setMarkerColorLocal _mrkrColor;
		_marker setMarkerTextLocal _displayName;
		_marker setMarkerSizeLocal [0.5,0.5];
		sleep 2;
		deleteMarkerLocal _marker;
	};
};

