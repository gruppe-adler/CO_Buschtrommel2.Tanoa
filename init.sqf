// this will execute on ALL machines, no need to handle MP sync for basic things


// apply grad-loadout
["BLU_T_F", "NATO_Apex_Pacific"] call GRAD_Loadout_fnc_FactionSetLoadout;
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


// set up rubber assault boats
["B_Boat_Transport_01_F", "init",{
    params ["_boat"];
    _boat setMass 400;  // make sling-loadable via Little Bird heli

    // add diving equipment
    clearItemCargoGlobal _boat;  // remove first aid kits
    _boat addItemCargoGlobal ["U_B_Wetsuit", 1];
    _boat addItemCargoGlobal ["V_RebreatherB", 1];
    _boat addItemCargoGlobal ["G_B_Diving", 1];
    _boat addBackpackCargoGlobal ["B_Assault_Diver", 1];
}, true, [], true] call CBA_fnc_addClassEventHandler;


// set up drone mini submarines (SDV)
["SDV_01_base_F", "init",{
    params ["_sdv"];
    
    diag_log "Setting up drone SDV";

    // need to wait for the group to be assigned to the SDV
    private _delayedCode = {
        params ["_sdv"];

        private _group = group _sdv;
        _group setBehaviourStrong "CARELESS";
        _group setSpeedMode "FULL";
        {
            _x hideObjectGlobal true;
            _x allowDamage false;
        } forEach crew _sdv;

        _sdv animateSource ["Doors",0,false];
        _sdv swimInDepth -3;
    };
    [_delayedCode, [_sdv], 5] call CBA_fnc_waitAndExecute;

}, true, [], true] call CBA_fnc_addClassEventHandler;


// spawn Cessna 172 with drop packages attached
["UK3CB_Cessna_172_Base", "init",{
    params ["_cessna"];

    diag_log "Cessna 172 spawned";

    _cessna setPhysicsCollisionFlag false;  // disable collision with hangars until it is clear of the airport

    // wait until the plane is at least 20m away from any hangar
    private _condition = { nearestObjects [_this, ["Land_Airport_01_hangar_F"], 20, true] isEqualTo [] };
    private _delayedCode = {
        params ["_cessna" ];
        _cessna setPhysicsCollisionFlag true;   // re-enable collision

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
    };
    [_condition, _delayedCode, _cessna] call CBA_fnc_waitUntilAndExecute;
}, true, [], true] call CBA_fnc_addClassEventHandler;
