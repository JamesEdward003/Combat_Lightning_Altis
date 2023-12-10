// execVM "holster__weapon.sqf"; //

[] spawn {
    waitUntil {!isNull(findDisplay 46)};

    (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_displayCode","_keyCode","_isShift","_isCtrl","_isAlt"];
    _handled = false;
        if (_keyCode == 0x3A) // CAPS LOCK
        then {
            player action ["SWITCHWEAPON",player,player,-1];
            waitUntil {currentWeapon player == "" or {primaryWeapon player == "" && secondaryWeapon player == "" && handgunWeapon player == ""}};
            player setCaptive true;
            systemChat "Enemy will NOT attack you!";
            [] spawn {
                waitUntil {currentWeapon player != "" or {primaryWeapon player != "" && secondaryWeapon player != "" && handgunWeapon player != ""}};
                player setCaptive true;
                systemChat "Enemy WILL attack you!";
            };
        };
        _handled = true;
    }];
};

