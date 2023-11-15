//  "ParamsPlus\StartVehicle.sqf"  //
{ _x enableAi "MOVE" } forEach units group player;

group player select 0 assignAsTurret [(vehicle player), [0] ];
group player select 1 assignAsTurret [(vehicle player), [-1] ];
group player select 2 assignAsTurret [(vehicle player), [1] ];
group player select 3 assignAsTurret [(vehicle player), [2] ];
group player select 4 assignAsTurret [(vehicle player), [3] ];
group player select 5 assignAsTurret [(vehicle player), [4] ];
group player select 6 assignAsTurret [(vehicle player), [5] ];
group player select 7 assignAsTurret [(vehicle player), [6] ];

group player select 0 moveInTurret [(vehicle player), [0] ];
group player select 1 moveInTurret [(vehicle player), [-1] ];
group player select 2 moveInTurret [(vehicle player), [1] ];
group player select 3 moveInTurret [(vehicle player), [2] ];
group player select 4 moveInTurret [(vehicle player), [3] ];
group player select 5 moveInTurret [(vehicle player), [4] ];
group player select 6 moveInTurret [(vehicle player), [5] ];
group player select 7 moveInTurret [(vehicle player), [6] ];
