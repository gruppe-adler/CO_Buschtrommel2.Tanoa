/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_carryPackage.sqf
Parameters: unit/soldier to carry or drop package
Return: none

Example:
	[_this, true] call UTIL_fnc_carryPackage;  	// in unit's Execute field to pick up the package
	[_this, false] call UTIL_fnc_carryPackage;  // in unit's Execute field to drop the package

*///////////////////////////////////////////////

params ["_soldier", "_carry"];

private _package = (getPos _soldier) nearestObject "Land_Sleeping_bag_folded_F";

if (_carry) then {
	_package attachTo [_soldier, [0, -0.2, 0], "Pelvis"];
} else {
	detach _package;
};
