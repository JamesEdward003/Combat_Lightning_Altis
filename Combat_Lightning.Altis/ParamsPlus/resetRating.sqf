///////// "ParamsPlus\resetRating.sqf" //////////
hintSilent parseText format["<t size='1.25' color='#FF5500'>'%1 rating player',rating player</t>"];
BNRG_fnc_setRating = { 
   params ["_wantedRating", "_unit"]; 
   private _currentRating = rating _unit; 
   private _difference = _wantedRating - _currentRating; 
   _unit addRating _difference; 
}; 
 
[1000, player] call BNRG_fnc_setRating;

