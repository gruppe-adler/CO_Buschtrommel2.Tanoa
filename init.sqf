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


// set up drone mini submarines (SDV)
["SDV_01_base_F", "init",{
    params ["_sdv"];
    
    diag_log "Setting up drone SDV";
    _sdv animateSource ["Doors",0,true];

    private _waypointEH = {
        params ["_sdv"];
        (group _sdv) addEventHandler ["WaypointComplete", {
            params ["_group", "_waypointIndex"];
            
            diag_log format ["SDV group %1 completed waypoint", _group];

            _group setBehaviourStrong "CARELESS";
            _group setSpeedMode "FULL";

            private _sdv = assignedVehicles _group select 0;
            _sdv swimInDepth -1;

            {
                _x hideObjectGlobal true;
                _x allowDamage false;
            } forEach crew _sdv;
        }];
    };
    [_waypointEH, [_sdv]] call CBA_fnc_execNextFrame;   // need to wait for the group to be assigned to the SDV

}, true, [], true] call CBA_fnc_addClassEventHandler;


// spawn Cessna 172 with drop packages attached
["UK3CB_Cessna_172_Base", "init",{
    params ["_cessna"];

    diag_log "Cessna 172 spawned";

    // spawn 4 drop packages
    private _package_x_coords = [objNull, -5, -4, 4, 5];    // index 0 is invaild
    for "_i" from 1 to 4 do 
    {
        private _package = "Land_Sleeping_bag_folded_F" createVehicle position _cessna;
        _package attachTo [_cessna, [_package_x_coords#_i, 2, 0.2]];    // attach to the underside of the wings
        diag_log format ["Attaching package %1 to %2", _package, _cessna];
        _package hideObjectGlobal true;     // packages should only be visible once dropped (so it looks like they were pushed out of the plane)
        private _freq = (_i * 100) + 33.7;
        [_package, _freq, 5000, [ format ["morse_package_number_%1",_i], 1.1], true] call crowsew_spectrum_fnc_addsoundsequenceserver;  // add Morse code signal to package
        _cessna setVariable [format ["package%1", _i], _package, true];     // save package as variable of the plane (used to drop them later)
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;
