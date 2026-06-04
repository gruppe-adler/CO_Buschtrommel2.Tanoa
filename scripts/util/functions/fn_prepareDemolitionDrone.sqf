/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_prepareDemolitionDrone.sqf
Parameters: drone to prepare for demolition
Return: none

Example:
	_this call UTIL_fnc_prepareDemolitionDrone;  // in drone's Execute field

*///////////////////////////////////////////////

params ["_drone"];

("ModuleExplosive_DemoCharge_F" createVehicle position _drone) attachTo [_drone, [0, 0, 0.15]];
