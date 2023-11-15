hintSilent parseText format["<t size='1.25' color='#FF5500'>Acquiring bon recruitable units : Acquired in...</t>"];
//hintSilent "Acquiring bon recruitable units : Acquired in...";
sleep 3;
hintSilent "5";
sleep 1;
hintSilent "4";
sleep 1;
hintSilent "3";
sleep 1;
hintSilent "2";
sleep 1;
hintSilent "1";
sleep 1;
hintSilent "";
hintSilent parseText format["<t size='1.25' color='#FF5500'>Bon recruitable units listed.</t>"];
//hintSilent "Bon recruitable units listed.";
sleep 6;
hintSilent "";
/*
[10, "#FF5500"] execVM "ParamsPlus\TimeoutCountdown.sqf";

uisleep 1;

waitUntil {isNil "RscFiringDrillTime_done"};


if (hasInterface) then {
	CurrentGroup = group player;
	IsGroupLeader = false;
	if (leader CurrentGroup  == leader player) then
	{
		IsGroupLeader = true;
	};
	player addEventHandler ["Respawn",
	{
		if (IsGroupLeader) then //Reset Group Leader
		{
		CurrentGroup = group player;
		{[_x] joinSilent player} forEach (units CurrentGroup);
		CurrentGroup selectLeader player;
		};
	}];
};
*/
