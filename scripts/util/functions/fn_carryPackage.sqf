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

private _package = (nearestObjects [_soldier, ["Land_Sleeping_bag_folded_F", "Land_WaterBottle_01_pack_F"], 10, true])#0;

if (_carry) then {
	_package attachTo [_soldier, [0, -0.2, 0], "Pelvis"];

	// rotate water bottle pack 90°
	if (_package isKindOf "Land_WaterBottle_01_pack_F") then {
		_package setVectorDirAndUp [[1,0,0], [0,0,1]];
	};
} else {
	detach _package;
};
