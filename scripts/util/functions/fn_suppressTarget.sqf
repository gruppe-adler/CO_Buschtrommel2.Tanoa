/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_suppressTarget.sqf
Parameters: target to suppress
Return: none

Example:
	_this call UTIL_fnc_suppressTarget;  // in unit's Execute field

*///////////////////////////////////////////////

params ["_target"];

// forget previous revealed targets because otherwise gunship does not closely follow the order to suppress
{
	(group gunship) forgetTarget _x;
} forEach [target_pier, target_bunker_E, target_bunker_C_E, target_bunker_W];

// suppress the target
[group gunship, _target, 20] call zen_ai_fnc_suppressiveFire;
