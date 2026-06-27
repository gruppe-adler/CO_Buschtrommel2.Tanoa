/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_spawnFlare.sqf
Parameters: position to spawn flare
Return: none

Example:
	[getPos player vectorAdd [0, 0, 150]] call UTIL_fnc_spawnFlare;		// spawn flare 150m above player

*///////////////////////////////////////////////

params ["_position", ["_placementRadius", 50]];

private _flare = createVehicle ["F_40mm_Green_Illumination", _position, [], _placementRadius, "NONE"];
_flare setVelocity [wind select 0, wind select 1, 0];
