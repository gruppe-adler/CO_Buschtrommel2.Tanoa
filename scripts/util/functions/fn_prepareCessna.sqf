/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_prepareCessna.sqf
Makes sure the Cessna and its packages are owned by the Zeus' client to prevent locality issues.

Parameters: cessna to prepare for package dropping
Return: none

Example:
	_cessna call UTIL_fnc_prepareCessna;

*///////////////////////////////////////////////

params ["_cessna"];

if (call BIS_fnc_admin < 2) exitWith { diag_log "fn_prepareCessna.sqf: Player is not logged in as admin. Ignoring preparation of Cessna."; };

if (!local _cessna) then {
	private _clientID = clientOwner;

	private _ret_setOwner      = [      _cessna, _clientID] remoteExec ["setOwner", 2];
	private _ret_setGroupOwner = [group _cessna, _clientID] remoteExec ["setGroupOwner", 2];
	diag_log format ["fn_prepareCessna.sqf: Change of cessna ownership returned '%1' and '%2'.", _ret_setOwner, _ret_setGroupOwner];
	systemChat "Locality change started";
};	

[_cessna] spawn {	// need to change to scheduled environment in order to use waitUntil
	params ["_cessna"];
	
	waitUntil {local _cessna};	 // wait for potential locality change to finish 
	systemChat "Locality change finished";

    _cessna setPhysicsCollisionFlag false;  // disable collision with hangars until it is clear of the airport

    // wait until the plane is at least 20m away from any hangar
    private _condition = { 
            params ["_cessna" ]; 
            isEngineOn _cessna && 
            { nearestObjects [_cessna, ["Land_Airport_01_hangar_F"], 20, true] isEqualTo [] }
        };
        
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
            [_package, true] remoteExec ["hideObjectGlobal", 2];   // packages should only be visible once dropped (so it looks like they were pushed out of the plane)
            private _freq = (_i * 100) + 33.7;
            [_package, _freq, 5000, [ format ["morse_package_number_%1",_i], 1.1], true] remoteExec ["crowsew_spectrum_fnc_addsoundsequenceserver", 2];   // add Morse code signal to package (call on server)
            _cessna setVariable [format ["package%1", _i], _package, true];     // save package as variable of the plane (used to drop them later)
        };

        // close hangar doors after plane moved out
        [cessna_hangar, 2, 0] call BIS_fnc_Door;
        [cessna_hangar, 3, 0] call BIS_fnc_Door; 
    };
    [_condition, _delayedCode, _cessna] call CBA_fnc_waitUntilAndExecute;
					// walk slowly whilst using the spectrum device
};
