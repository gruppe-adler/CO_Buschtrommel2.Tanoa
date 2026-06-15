/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_refuel.sqf
Parameters: vehicle object to refuel
Return: none

*///////////////////////////////////////////////

params ["_vehicle"];

private _lowerLimit = 0.65;
if (fuel _vehicle < _lowerLimit) then {
    [_vehicle, _lowerLimit] remoteExec ["setFuel", _vehicle];   // refuel (call where vehicle is local)
};

// log refueling on server
private _ServerLogEntry = format ["fn_refuel.sqf: Fuel of %1 '%2' is at %3", typeOf _vehicle, _vehicle, fuel _vehicle];
[_ServerLogEntry] remoteExec ["diag_log", 2];
