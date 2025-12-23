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
