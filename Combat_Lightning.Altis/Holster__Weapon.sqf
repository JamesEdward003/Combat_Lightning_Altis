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
            [player, ["camouflageCoef",0]] remoteExec ["setUnitTrait", groupOwner (group player)];
            [player, ["audibleCoef",0]] remoteExec ["setUnitTrait", groupOwner (group player)];
            systemChat format ["%1: CamouflageCoef is 0, AudibleCoef is 0", name player];
            [] spawn {
            waitUntil {currentWeapon player != "" or {primaryWeapon player != "" && secondaryWeapon player != "" && handgunWeapon player != ""}};
            [player, ["camouflageCoef",0.2]] remoteExec ["setUnitTrait", groupOwner (group player)];
            [player, ["audibleCoef",0.2]] remoteExec ["setUnitTrait", groupOwner (group player)];
            systemChat format ["%1: CamouflageCoef is .2, AudibleCoef is .2", name player];
            };
        };
        _handled = true;
    }];
};

