//    QA.sqf    //
private ["_unit"];
_unit = _this;
_actions = actionIDs _unit;
_array = [];

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
        ["Want me to join your group?", "Confirm", true, true],
        ["Can I join your group?", "Confirm", true, true],
        ["Looking for a good recruit?", "Confirm", true, true],
        ["Watcha lookin at ??? Confirm!!!", "Confirm", true, true]];      
        _result call BIS_fnc_guiMessage;
      if (true) then {
        _target setUnitRank "CORPORAL";
        [_target] joinSilent (group _caller);
        titleText [format ['<t color=''#ffdd22'' size=''1.5''>%1</t><br/>***********',(_arguments select 0)], 'PLAIN DOWN', -1, true, true];
        "radar_10" setMarkerAlphaLocal .4;
        SIR_fnc_Intel_2 = {
          [
            [
              ["title","Combat Lightning"],
              ["meta",["Jim Ed Renfro",[2035,2,24,11,38],"CET"]],
              ["textbold","Might be a good choice to wait until nightfall!"],
              ["image",["\A3\Ui_F_Curator\Data\Logos\arma3_curator_artwork.jpg","Combat Lightning"]],
              ["box",["\A3\EditorPreviews_F\Data\CfgVehicles\O_APC_Tracked_02_AA_F.jpg","Anti-Air tank patrolling the perimeter!"]],
              ["text","Radar surrounds the area! Good thing you got this intel to help you. The radar range has been marked on the map. As soon as you are detected, the anti-air tank and the mobile artillery will start looking for you!"],
              ["text","Take out both tanks first! Two HVT officers are to be eliminated next. The associated squad with them are of no consequence!"],
              ["author",["Hq8EHMyUsC.paa","Jim Ed Renfro is a Make Love Not War Soldier"]]
            ]
          ] call BIS_fnc_showAANArticle;
        };
        _caller createDiaryRecord ["Diary", ["Intel", "
        <execute expression='[] call SIR_fnc_Intel_2'>Intel From Kouris</execute>
        "]];
      } else {
        titleText [format ['<t color=''#ffdd22'' size=''1.5''>%1</t><br/>***********',(_arguments select 1)], 'PLAIN DOWN', -1, true, true];
    };
  };
},
[
selectRandom [
"Good, in that case,<br/>I can let the team in on some intel!<br/>Check your intel folder!",
"Good, in that case,<br/>tanks first then hvt officers!<br/>Check your intel folder!",
"Good, in that case,<br/>I suggest you wait until nightfall!<br/>Check your intel folder!"],
"Shucks, in that case,<br/>I will stay here and wait for a good old tank to come by!<br/>I got a couple of explosive charges if you want?"
],
99,
false,
true,
"",
"", //(_caller distance2d (getPos _target) < 2)
-1,
true,
"",
""];
};

