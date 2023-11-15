// execVM "mortarBag.sqf"; //
if ( "SpawnMortarBag" call BIS_fnc_getParamValue isEqualTo 1 ) exitWith {};
private ["_caller","_position","_target","_is3D","_id"];
params ["_caller","_position","_target","_is3D","_id"];
_caller = _this select 0;
_position = _this select 1;
_caller = player;

KK_playerAddMortarBag = {
    removeBackpack player;
    KK_mortarBag = toString [
        (toArray faction player) select 0
    ] + "_Mortar_01_weapon_F";
    player addBackpack KK_mortarBag;
    player addAction [
        format [
            localize "STR_ACTION_ASSEMBLE",
            localize "str_a3_cfgvehicles_mortar_01_base0"
        ],
        {
            player action ["Assemble", unitBackpack player];
            removeBackpack player;
            player removeAction (_this select 2);
            KK_mortar = toString [
               (toArray faction player) select 0] + "_Mortar_01_F";        
            KK_mortar createVehicle (player modelToWorld [0,1,0]);
        },
        [],
        0,
        false,
        true,
        "User1",
        "
            !isNull unitBackpack player && 
            {backpack player == KK_mortarBag} && 
            {player == vehicle player}
         "
    ];
    KK_mortarAssembled_EH = player addEventHandler ["WeaponAssembled", {
        if ((_this select 1) isKindOf "StaticMortar") then {
            player removeEventHandler ["WeaponAssembled", KK_mortarAssembled_EH];
            enableEngineArtillery false;
            (_this select 1) addEventHandler ["GetOut", {
                if (alive player) then {
                    player setDir (direction (_this select 0));
                    player setPos ((_this select 0) modelToWorld [0,-2,-0.7]);
                    player playActionNow "PutDown";
                    (_this select 0) spawn {
                        sleep 0.5;
                        deleteVehicle _this;
                        call KK_playerAddMortarBag;
                    }
                } else {
                    (_this select 0) setDamage 1;
                }
            }];
            (_this select 1) spawn {
                sleep 0.9;
                if (isNull _this || {!alive _this}) exitWith {};
                if (player distance _this > 3.5) exitWith {
                    deleteVehicle _this;
                    call KK_playerAddMortarBag;
                };
                if (lineIntersects [
                    getPosASL player, getPosASL _this, player, _this
                ]) exitWith {
                    deleteVehicle _this;
                    call KK_playerAddMortarBag;
                };
                player moveInGunner _this;
                if (gunner _this != player) exitWith {
                    deleteVehicle _this;
                    call KK_playerAddMortarBag;
                };
            }
        }
    }]
};

call KK_playerAddMortarBag;