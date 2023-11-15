// execVM "holster__weapon.sqf"; //

[] spawn {
    waitUntil {!isNull(findDisplay 46)};

    (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_displayCode","_keyCode","_isShift","_isCtrl","_isAlt"];
    _handled = false;
        if (_keyCode == 0x3A) // CAPS LOCK
        then {
            player action ["SWITCHWEAPON",player,player,-1];
            waitUntil {currentWeapon player == "" or {primaryWeapon player == "" && handgunWeapon player == ""}};
        };
        _handled = true;
    }];
};

