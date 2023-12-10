//    QA_kouris.sqf    //
private ["_unit"];
_unit = _this;
_actions = actionIDs _unit;
_array = [];
_targets = switch (true) do {
  case (!isNull (missionNamespace getVariable ["BIS_CP_objective_vehicle1", objNull]) && !isNull (missionNamespace getVariable ["BIS_CP_objective_vehicle2", objNull])): {
    _tgt1 = getPosATL BIS_CP_objective_vehicle1;
    _tgt2 = getPosATL BIS_CP_objective_vehicle2;
  };
  case (!isNull (BIS_HVT) && !isNull (BIS_HVTVehicle)): {
    _tgt1 = getPosATL BIS_HVT;
    _tgt2 = getPosATL BIS_HVTVehicle;
  };
  case (!isNull (BIS_comms)): {
    _tgt1 = getPosATL BIS_comms;
    _tgt2 = getPosATL BIS_comms;
  };
};
for [{_i= (count _actions)-1},{_i>-1},{_i=_i-1}] do {
  _params = _unit actionParams (_actions select _i);
  _array = _array + [(_params select 0)];
  };
if !(("<t color='#00FFFF'>Talk</t>") in _array) then {
  _unit addAction ["<t color='#00FFFF'>Talk</t>", {
    private ["_target","_caller","_actionId","_arguments"];
    params ["_target","_caller","_actionId","_arguments"];

    [_target,_caller,_arguments] spawn {
      params ["_target","_caller","_arguments"];
      _result = selectRandom [
        ["Got intel for you. Want me to join your group?", "Confirm", true, true],
        ["Got intel. Should I join your group?", "Confirm", true, true],
        ["My intel would be very helpful. Join group?", "Confirm", true, true],
        ["Join me with your group and get intel.", "Confirm", true, true]];      
        _result call BIS_fnc_guiMessage;
        //hint format ["%1",_result];
      if ((_result call BIS_fnc_guiMessage) isEqualTo true) then {
        _target setUnitRank "CORPORAL";
        _target forceSpeed (_target getSpeed "FAST");
        [_target] joinSilent (group _caller);
        _target setCaptive FALSE;
        _target enableAi "TARGET";
        doStop _target;
        titleText [format ['<t color=''#ffdd22'' size=''1.25''>%1</t><br/>***********',(_arguments select 0)], 'PLAIN DOWN', -1, true, true];
        "radar_10" setMarkerAlphaLocal .4;
SIR_fnc_Kouris_2 = { // East-Enemy
  [
    [
      ["title","Combat Lightning"],
      ["meta",["Alexis Kouris",[2035,2,24,11,38],"CET"]],
      ["textbold","""Might be a good choice to wait until nightfall before starting the approach! The stealthy ticket!"""],
      ["image",["\A3\Ui_F_Curator\Data\Logos\arma3_curator_artwork.jpg","Combat Lightning"]],
      ["box",format ["%1","\A3\EditorPreviews_F\Data\CfgVehicles\O_APC_Tracked_02_AA_F.jpg"],"Anti-Air tank patrolling the perimeter!"],
      ["text","Radar surrounds the area! Good thing you got this intel to help you. The radar range has been marked on the map. As soon as you are detected, the anti-air tank and the mobile artillery will start looking for you!"],
      ["text","Take out both tanks first! Two HVT officers are to be eliminated next. The associated squad with them are of no consequence, however good to eliminate them also! If a night approach is prefered, lay down close to your tent and bedroll and take a nap! Have an ammo drop deliver mines, anti-tank rockets, sniper rifles...whatever you need! Get the whole job done before daylight!"],
      ["author",["Hq8EHMyUsC.paa","Alexis Kouris is a Make Arma Not War Soldier"]]
    ]
  ] call BIS_fnc_showAANArticle;
};
      _caller createDiaryRecord ["Diary", format ["Intel", "
        <execute expression='[] call %1'>Intel From Kouris</execute>
        "],SIR_fnc_Kouris_2];
      } else {
        _target setUnitRank "SERGEANT";
        [_target] joinSilent grpNull;
        _target setCaptive FALSE;
        _target enableAi "TARGET";
        titleText [format ['<t color=''#ffdd22'' size=''1.25''>%1</t><br/>***********',(_arguments select 1)], 'PLAIN DOWN', -1, true, true];        
    };
    _result = nil;
  };
},
[
selectRandom [
"Good, now I can let you in on some intel!<br/>Check your intel folder!",
"Good, glad to be with you!<br/>Check your intel folder!",
"Good, welcome to the fight!<br/>Check your intel folder!"],
"Alright, I will stay here and wait for a tank to come by!<br/>I got a couple of explosive charges if you want?"
],
99,
false,
true,
"",
"", //((_caller distance2d _target) < 2)
-1,
true,
"",
""];
};
/*
        SIR_fnc_Intel_2 = {
          [
            [
              ["title","Combat Lightning"],
              ["meta",["Jim Ed Renfro",[2035,2,24,11,38],"CET"]],
              ["textbold","""Might be a good choice to wait until nightfall before starting the approach! The stealthy ticket!"""],
              ["image",["\A3\Ui_F_Curator\Data\Logos\arma3_curator_artwork.jpg","Combat Lightning"]],
              ["box",["\A3\EditorPreviews_F\Data\CfgVehicles\O_APC_Tracked_02_AA_F.jpg","Anti-Air tank patrolling the perimeter!"]],
              ["text","Radar surrounds the area! Good thing you got this intel to help you. The radar range has been marked on the map. As soon as you are detected, the anti-air tank and the mobile artillery will start looking for you!"],
              ["text","Take out both tanks first! Two HVT officers are to be eliminated next. The associated squad with them are of no consequence!"],
              ["author",["Hq8EHMyUsC.paa","Jim Ed Renfro is a Make Love Not War Soldier"]]
            ]
          ] call BIS_fnc_showAANArticle;
        };
        */

