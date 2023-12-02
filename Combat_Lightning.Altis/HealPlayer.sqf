// player addAction ["<t color='#00FFFF'>Heal Player</t>","HealPlayer.sqf",[],-99,false,false,"","((_target == _this) and (getDammage _target) > 0.3)"]; //
// =======================================================================================
//							INSTRUCTIONS
// =======================================================================================
// SCRIPT: [] execVM "HealPlayer.sqf"
// =======================================================================================
// SCRIPT INTENT: Selected units will form a 360 around the player and heal player
// =======================================================================================

// =======================================================================================
// =======================================  SETUP  ======================================= 
// =======================================================================================

// =======================================================================================
// DECLARE VARIABLES
// =======================================================================================

private ["_Player", "_Location", "_Group", "_Units", "_ValidArray", "_ValidArrayCount", "_Interval"];
private ["_CenterX", "_CenterY", "_Perimeter"];
private ["_Angle", "_PosX", "_PosY", "_Position", "_Member"];

// =======================================================================================
// DEFINE VARIABLES 
// =======================================================================================

_Player 	= _this select 0;
_Location	= getPos _Player;
_Group 		= group _Player;
1 fadeSpeech 1;
if (!(isNil { missionNamespace getVariable "numberTimes"})) then
	{
		_numberCnt = missionNamespace getVariable "numberTimes";
		_numberCnt = _numberCnt + 1;
		missionNamespace setVariable ["numberTimes", _numberCnt, true];
	} else {		
		_numberCnt = 1;
		missionNamespace setVariable ["numberTimes", _numberCnt, true];
	};	
// =======================================================================================
// ======================================  SCRIPT  ======================================= 
// =======================================================================================

	_randAck = selectRandom ["A3\Dubbing_Radio_F\data\ENG\Male01ENG\RadioProtocolENG\Normal\130_Com_Reply\OnTheWay_1.ogg","A3\Dubbing_Radio_F\data\ENG\Male01ENG\RadioProtocolENG\Normal\130_Com_Reply\OnTheWay_2.ogg","A3\Dubbing_Radio_F\data\ENG\Male01ENG\RadioProtocolENG\Normal\130_Com_Reply\OnTheWay_3.ogg"];

	_randNag = selectRandom ["A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\200_CombatShouts\CheeringE_4.ogg","A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\200_CombatShouts\CheeringE_1.ogg"];

	_randPain = selectRandom ["A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\200_CombatShouts\ScreamingE_1.ogg","A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\200_CombatShouts\ScreamingE_2.ogg","A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\200_CombatShouts\ScreamingE_3.ogg","A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\200_CombatShouts\ScreamingE_4.ogg"];

	_throwingSmoke = "A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\200_CombatShouts\ThrowingSmokeE_1.ogg";

	_callMedic = "A3\Dubbing_Radio_F\data\ENG\Male02ENG\RadioProtocolENG\Combat\010_Vehicles\veh_infantry_medic_s.ogg";

	uiSleep 1;

	_numberCnt = missionNamespace getVariable "numberTimes";

	if ((_numberCnt < 2) and (lifeState _Player == "incapacitated")) then 
	{
		//hintSilent composeText ["Call made to nearest medic", lineBreak, "Stand By..."];
		["Call made to nearest medic", "Stand By..."] spawn BIS_fnc_showSubtitle;

		[playerSide, "HQ"] commandChat "Call for medic!";

		playSound3D [_callMedic, _Player];

		[_randPain, _Player] spawn {uisleep (10 + (random 10));playSound3D [_this select 0, _this select 1];};

		_numberCnt = _numberCnt + 1;

		missionNamespace setVariable ["numberTimes", _numberCnt, true];
	};
	if ((_numberCnt >= 2) and (lifeState _Player == "incapacitated")) then 
	{
		[playerSide, "HQ"] commandChat "Call for medic!";

		playSound3D [_callMedic, _Player];

		[_randNag, _Player] spawn {uisleep (6 + (random 10));playSound3D [_this select 0, _this select 1];};

		_numberCnt = _numberCnt + 1;

		missionNamespace setVariable ["numberTimes", _numberCnt, true];
	};

	uiSleep 2;

// =======================================================================================
// ESTABLISH THE PLAYER'S X AND Y POSITIONS AND A PERIMETER DISTANCE
// =======================================================================================

	_CenterX	= _Location select 0;
	_CenterY	= _Location select 1;
	_Perimeter	= 3; // is 6 meters in diameter

// =======================================================================================
// GRAB ONLY VALID UNITS BY CHECKING IF THEY ARE ON FOOT AND ARE NOT PLAYERS
// ======================================================================================= 

_MedicArray = [];
switch (playerSide) do 
	{
	case west: {_MedicArray = ["B_medic_F","B_recon_medic_F","B_CTRG_soldier_M_medic_F","B_G_medic_F","B_T_Medic_F","B_T_Recon_Medic_F","B_CTRG_Soldier_Medic_tna_F","B_Patrol_Medic_F","B_W_Medic_F"];};
	case east: {_MedicArray = ["O_medic_F","O_recon_medic_F","O_G_medic_F","O_soldierU_medic_F","O_T_Medic_F","O_T_Recon_Medic_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_Medic_ghex_F","O_A_medic_F","O_R_medic_F","O_R_recon_medic_F"];};
	case resistance: {_MedicArray = ["I_medic_F","I_E_Medic_F","I_E_Medic_EMP_F","I_G_medic_F"];};
	case civilian: {_MedicArray = ["C_Paramedic_01_base_F","C_Man_Paramedic_01_F","C_Man_UAV_06_medical_F","C_man_p_beggar_F_asia"];};
	};
	_ValidArray	= [];
    {if ((isNull objectParent _x) and (typeOf _x in _MedicArray)) then {_ValidArray append [_x]}} forEach units _Group;

// =======================================================================================
// EVERY VALID SQUAD UNIT AND SUBSEQUENT ONE WILL MOVE TO THE PLAYER AND PERFORM A HEAL ACTION
// =======================================================================================

//	hintSilent format ["%1",_ValidArray];			

	if (count _ValidArray > 0) then {

	_Interval = 360/(count _ValidArray);

	for "_i" from 0 to count _ValidArray - 1 do
	{
		_Angle		= 0 + (_Interval*_i);
		_PosX 		= _CenterX + _Perimeter * cos(_Angle);
		_PosY 		= _CenterY + _Perimeter * sin(_Angle);
		_Position	= [_PosX,_PosY];

	  	if (!(_Player call BIS_fnc_reviveEnabled)) then {
	    	_Player setVariable ["BIS_revive_incapacitated",true,true];
	  	};

		_Member 	= (_ValidArray select _i);
		_Member		lookAt _Position;
		_Member		moveTo _Position;
		playSound3D [_randAck, _Member];
		_Member		setBehaviour "AWARE";
		_Member		setUnitCombatMode "YELLOW";

		_numberCnt = missionNamespace getVariable "numberTimes";

		if (_numberCnt < 2) then 
		{
			_Member		setSpeedMode "NORMAL";
			_Member 	setUnitPos "MIDDLE";
		} else {
			_Member		setSpeedMode "FULL";
			_Member 	setUnitPos "UP";
			_Member		setUnitCombatMode "GREEN";
		};	
		
		waituntil {(moveToCompleted _Member or _Member distance _Player <= 2) and (lifeState _Player == "incapacitated" or damage _Player > 0)};
		//_Member     disableAi "AUTOCOMBAT";
		_Member		lookAt _Player;
		_Member		setSpeedMode "NORMAL";
		_Member 	setUnitPos "MIDDLE";
		_Member 	action ["HealSoldier", _Player];
		_Member 	playMove "AinvPknlMstpSlayWrflDnon_medicOther";
		["#rev",1,_Player] call BIS_fnc_reviveOnState;
		uiSleep 6;

		if (!("Medikit" in items _Member)) then {_Player removeItem "FirstAidKit";} else {_Member removeItem "FirstAidKit";};

		[_Player] call BIS_fnc_reviveEhHandleHeal;
		_Player 	setVariable ["BIS_revive_incapacitated", false,true];
		_Player 	setDamage 0;
		_Player 	setUnconscious false;
		_Player 	allowDamage false;

		waituntil {!(lifeState _Player == "incapacitated") or getDammage _Player == 0};
		
		_Player playMove "AmovPpneMstpSnonWnonDnon";

    	//titleText["10 seconds to find cover", "PLAIN DOWN"];
		_Player spawn {
			["CROSSROAD", "10 seconds to find cover"] spawn BIS_fnc_showSubtitle;
			uiSleep 10;
			_this allowDamage true;
			_this setCaptive false; 
		};
		missionNamespace setVariable ["numberTimes", nil];	
		//_Player 	playMove "AinjPpneMstpSnonWnonDnon_rolltofront";
		//_Player 	playMove "AmovPknlMstpSnonWnonDnon";
		
		_Member 	doFollow _Player;
		_Member		setSpeedMode "NORMAL";
		_Member		setUnitCombatMode "YELLOW";
		_Member 	setUnitPos "AUTO";
 
	};
// =======================================================================================
// EVERY VALID AREA UNIT AND SUBSEQUENT ONE WILL MOVE TO THE PLAYER AND PERFORM A HEAL ACTION
// =======================================================================================

} else {
	
	_ValidMedicArray = [];
	_validMedicArray = _Player nearEntities [_MedicArray, 100];

//	hintSilent format ["%1",_ValidMedicArray];

	if (count _ValidMedicArray == 0) exitWith {["CROSSROAD", "No medics in 100m range!"] spawn BIS_fnc_showSubtitle;};

	if (count _validMedicArray > 0) then {

		_Interval = 360/(count _validMedicArray);
		
		for "_i" from 0 to count _ValidMedicArray - 1 do
		{
			_Angle		= 0 + (_Interval*_i);
			_PosX 		= _CenterX + _Perimeter * cos(_Angle);
			_PosY 		= _CenterY + _Perimeter * sin(_Angle);
			_Position	= [_PosX,_PosY];
				
			_Member 	= (_ValidMedicArray select _i);
			_Member		lookAt _Position;
			_Member		moveTo _Position;
			playSound3D [_randAck, _Member];
			_Member		setBehaviour "AWARE";
			_Member		setUnitCombatMode "YELLOW";

			if (_numberCnt < 2) then 
			{
				_Member		setSpeedMode "NORMAL";
				_Member 	setUnitPos "MIDDLE";
			} else {
				_Member		setSpeedMode "FULL";
				_Member 	setUnitPos "UP";
				_Member		setUnitCombatMode "GREEN";
			};

			waituntil {(moveToCompleted _Member or _Member distance _Player <= 2) and (lifeState _Player == "incapacitated" or damage _Player > 0)};
			//_Member     disableAi "AUTOCOMBAT";
			_Member		lookAt _Player;
			_Member		setSpeedMode "NORMAL";
			_Member 	setUnitPos "MIDDLE";
			_Member 	action ["HealSoldier", _Player];
			_Member 	playMove "AinvPknlMstpSlayWrflDnon_medicOther";
			["#rev",1,_Player] call BIS_fnc_reviveOnState;
			uiSleep 6;

			if (!("Medikit" in items _Member)) then {_Player removeItem "FirstAidKit";} else {_Member removeItem "FirstAidKit";};

			[_Player] call BIS_fnc_reviveEhHandleHeal;
			_Player 	setVariable ["BIS_revive_incapacitated", false,true];
			_Player 	setDamage 0;
			_Player 	setUnconscious false;
			_Player 	allowDamage false;
			
			waituntil {!(lifeState _Player == "incapacitated") or getDammage _Player == 0};
			
			_Player playMove "AmovPpneMstpSnonWnonDnon";
			//_Player 	playMove "AinjPpneMstpSnonWnonDnon_rolltofront";
			//_Player 	playMove "AmovPknlMstpSnonWnonDnon";

	    	//titleText["10 seconds to find cover", "PLAIN DOWN"];
			_Player spawn {
    			["CROSSROAD", "10 seconds to find cover"] spawn BIS_fnc_showSubtitle;
    			uiSleep 10;
  				_this allowDamage true;
  				_this setCaptive false; 
  			};
	  		missionNamespace setVariable ["numberTimes", nil];
			
			_Member 	doFollow _Player;
			_Member		setSpeedMode "NORMAL";
			_Member		setUnitCombatMode "YELLOW";
			_Member 	setUnitPos "AUTO";

		};	
	};
};
