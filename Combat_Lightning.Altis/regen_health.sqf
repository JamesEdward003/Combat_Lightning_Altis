//////////////////////////////////////////////////////////////////
// [_x,15,1] execVM "regen_health.sqf";
_PRegenHealth = "PRegenHealth" call BIS_fnc_getParamValue;
if (_PRegenHealth isEqualTo 1) exitWith {};
private ["_unit","_armor","_recovery","_newDamage","_PRegenHealth"];
_unit = _this;
_rhv = missionNameSpace getVariable "RegenHealthVar";
_armor = _rhv/100;

//hintSilent parsetext format ["<t size='0.85' color='#00bbff' align='left'>Regen Script Started for: </t><t size='0.85' color='#00bbff' align='left'> %1</t>", name _unit];

if (isMultiPlayer) then
{	
	_unit addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		_unit execVM "regen_health.sqf";
	}];

	_unit addMPEventHandler ["MPHit", {
		params ["_unit", "_causedBy", "_damage", "_instigator"];
		[_unit,_causedBy] remoteExec ["lookat", group _unit];
	    _armor = _rhv/100;
	    getDammage _unit;
	    scopeName "main";
	    while {((getDammage _unit) > .1)} do {
	        scopeName "loop1";
	        _newDamage = (damage _unit) - _armor;
	        _unit setdamage _newDamage;
	        //hintSilent parsetext format ["<t size='0.85' align='left'>Unit Name: </t><t size='0.85' color='#00bbff' align='left'>%1</t><br/><t size='0.85' align='left'>Before Regen: </t><t size='0.85' color='#00bbff' align='left'> %2</t><br/><t size='0.85' align='left'>After Regen: $</t> <t size='0.85' color='#00bbff' align='left'> %3</t>", name _unit, damage _unit, round _newdamage];
	        if ((lifeState _unit == "incapacitated" or !alive _unit or (!(_unit call BIS_fnc_reviveEnabled) and getDammage _unit >=0.86))) then {breakTo "main"}; // Breaks all scopes and return to "main"
	        if ((getDammage _unit) < .1) then {breakOut  "loop1"}; // Breaks scope named "loop1"
	    };
	}];
};

if (!isMultiPlayer) then
{	
scopeName "main";
 	while {alive _unit} do {
      	scopeName "loop1";
      	getDammage _unit;
      	while {((getDammage _unit) > .1)} do {
         	scopeName "loop2";
			_newDamage = (damage _unit) - _armor;
			_unit setdamage _newDamage;
			//hintSilent parsetext format ["<t size='0.85' align='left'>Unit Name: </t><t size='0.85' color='#00bbff' align='left'>%1</t><br/><t size='0.85' align='left'>Before Regen: </t><t size='0.85' color='#00bbff' align='left'> %2</t><br/><t size='0.85' align='left'>After Regen: $</t> <t size='0.85' color='#00bbff' align='left'> %3</t>", name _unit, damage _unit, round _newdamage];
          	if ((getDammage _unit) > .9) then {breakTo "main"}; // Breaks all scopes and return to "main"
          	if ((getDammage _unit) < .1) then {breakOut  "loop2"}; // Breaks scope named "loop2"
      	sleep  .01; };
  	sleep  1; }; 
};
//scopeName "main";
// while {true} do {
//      scopeName "loop1";
//      while {true} do {
//         scopeName "loop2";
//          if (condition1) then {breakTo "main"}; // Breaks all scopes and return to "main"
//          if (condition2) then {breakOut  "loop2"}; // Breaks scope named "loop2"
//      sleep  1; };
//  sleep  1; }; 
