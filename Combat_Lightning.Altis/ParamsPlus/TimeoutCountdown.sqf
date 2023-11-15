// TimeoutCountdown.sqf // [round triggerTimeoutCurrent trg0, "#FF5500"] execVM "TimeoutCountdown.sqf";
private ["_time","_colour","_timeout","_timeFormat"];
    params [
        ["_time", 30, [0]],
        ["_colour", "#FF5500", [""]]
    ];
    private _timeout = time + _time;
    RscFiringDrillTime_done = false;
    missionNamespace setVariable ["RscFiringDrillTime_done",true];
    //1 cutRsc ["RscFiringDrillTime", "PLAIN"];
    while { time < _timeout } do
    {
        private _remainingTime = _timeout - time;
        private _timeFormat = [_remainingTime, "MM:SS", true] call BIS_fnc_secondsToString;
        private _text = format ["<t align='left' color='%1'>                Laser target now!<br/>                Time to laze: <img image='%2' />%3:%4<t size='0.8'>.%5</t>",
            _colour,
            "A3\Modules_F_Beta\data\FiringDrills\timer_ca",
            _timeFormat select 0,
            _timeFormat select 1,
            _timeFormat select 2
        ];
        RscFiringDrillTime_current = [[], {hintSilent parseText _text}] remoteExec ["call", 0];
        sleep 0.01;
    };
    private _timeFormat = [0, "MM:SS", true] call BIS_fnc_secondsToString;
    RscFiringDrillTime_current = parseText format ["<t align='left' color='%1'>                Lasertarget time is up!<br/>                Laze time is: <img image='%2' />%3:%4<t size='0.8'>.%5</t>",
        _colour,
        "A3\Modules_F_Beta\data\FiringDrills\timer_ca",
        _timeFormat select 0,
        _timeFormat select 1,
        _timeFormat select 2]; [[], {RscFiringDrillTime_current}] remoteExec ["call", 0];
        
    RscFiringDrillTime_done = true;
    missionNamespace setVariable ["RscFiringDrillTime_done",nil];
    hintSilent "";


