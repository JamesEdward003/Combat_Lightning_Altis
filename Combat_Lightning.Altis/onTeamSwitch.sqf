/////	"OnTeamSwitch.sqf"	/////
_from = _this select 0;
_to = _this select 1;

_from enableAI "TeamSwitch";

_to execVM "RallyPoint.sqf";

_to execVM "RallyTent.sqf";

_to execVM "UnlimitedAmmo.sqf";

_to execVM "LoadoutAdjustments.sqf";

[_to, 0.30] remoteExec ["setCustomAimCoef", groupOwner (group _to)];
[_to, 0.30] remoteExec ["setUnitRecoilCoefficient", groupOwner (group _to)];
[_to, false] remoteExec ["enableStamina", groupOwner (group _to)];
[_to, ["camouflageCoef",0.20]] remoteExec ["setUnitTrait", groupOwner (group _to)];
[_to, ["loadCoef",1.0]] remoteExec ["setUnitTrait", groupOwner (group _to)];

execVM  "initPlayerLocal.sqf";

execVM  "ParamsPlus\Military_Symbol_Module.sqf";

waitUntil {!isNil {_to getVariable "Briefing"}};

call BIS_fnc_CPObjBriefingSetup;

//processDiaryLink createDiaryLink ["Tasks", _from, ""];
//processDiaryLink createDiaryLink ["Tasks", (simpleTasks _from) select 0, ""];

addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if (!isNil "BIS_CP_initDone" && _mapIsOpened) then {	
		{ _x enableAi "MOVE" } forEach units group player;
		[["BaseInfo","BaseManager"],15,"",35,"",true,true,false,false] call BIS_fnc_advHint;
		//["<t color='#2cb88e' size='.88'>You have selected the Base Start parameter<br />You will start at the base</t>",0,.01,10,1] spawn BIS_fnc_dynamicText;
		//hintsilent format ["%1",_thisEventHandler];
		removeMissionEventHandler ["Map", _thisEventHandler];
	};
}];
