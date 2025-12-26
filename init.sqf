// this will execute on ALL machines, no need to handle MP sync for basic things


// apply grad-loadout
["OPF_T_F", "CSAT_Apex_Pacific"] call GRAD_Loadout_fnc_FactionSetLoadout;


// disable thermal optics of drones because those don't support the FilmGrain effect of the jammers
{
    [_x, "init",{
        params ["_vehicle"];
        _vehicle disableTIEquipment true;   // disable thermal imaging
        _vehicle setVariable ["A3TI_Disable", true];    // disable mod "A3 Thermal Improvement"
        // _vehicle disableNVGEquipment true;  // disable night vision imaging
        // _vehicle removeMagazinesTurret ["Laserbatteries", [0]];   // disable laser designator
    }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach ([crowsEW_spectrum_defaultClassForJammingSignal, ","] call BIS_fnc_splitString);
    

// make XM312A auto turrets sling loadable via 'attachTo' to a sling-loadable item (e.g. of class "Land_WoodenBox_F")
["Helicopter", "init",{
    params ["_heli"];
    _heli addEventHandler ["RopeAttach", {
        params ["_lifter", "_rope", "_cargo"];
        diag_log format ["Attaching cargo %1 to helicopter %2", _cargo, _lifter];
        private _turret = (nearestObjects [_cargo, ["StaticWeapon"], 3])#0;
        _turret attachTo [_cargo, [0.3,0.1,1.2], "SlingLoadCargo1", true];
        _turret setDir -90;
    }];
}, true, [], true] call CBA_fnc_addClassEventHandler;
