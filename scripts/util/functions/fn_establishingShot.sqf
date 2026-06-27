/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_establishingShot.sqf
Parameters: none
Return: none

Example:
	call UTIL_fnc_establishingShot;

*///////////////////////////////////////////////

if (isServer) then {
	[getPos target_pier vectorAdd [0, 0, 150], 0] call UTIL_fnc_spawnFlare;
	[getPos target_bunker_E vectorAdd [0, 0, 150], 0] call UTIL_fnc_spawnFlare;
	[getPos target_bunker_C_E vectorAdd [0, 0, 150], 0] call UTIL_fnc_spawnFlare;
	[getPos target_bunker_W vectorAdd [0, 0, 150], 0] call UTIL_fnc_spawnFlare;
};

if (!hasInterface) exitWith {};

setViewDistance (2000 max viewDistance);

BIS_fnc_establishingShot_fakeUAV = nil;		// workaround for BI bug
[
	target_bunker_C_E,  // cam target and rotational center
	"Insel ""Sosovu"" westlich von Tanoa", // intro text
	300,    // altitude of cam
	400,    // radius of cam rotation
	180,    // 180 means looking from South to North
	0,      // 0 counter clockwise rotation, 1 clockwise rotation
	[
		["\A3\ui_f\data\Map\Markers\Military\marker_CA.paa", [0, 1, 0, 1], target_pier, 1, 1, 0, "Pier", 0],
		["\A3\ui_f\data\Map\Markers\Military\marker_CA.paa", [0, 1, 0, 1], target_bunker_E, 1, 1, 0, "Bunker East", 0],
		["\A3\ui_f\data\Map\Markers\Military\marker_CA.paa", [0, 1, 0, 1], target_bunker_C_E, 1, 1, 0, "Bunker Center", 0],
		["\A3\ui_f\data\Map\Markers\Military\marker_CA.paa", [0, 1, 0, 1], target_bunker_W, 1, 1, 0, "Bunker West", 0] 
	],
	0, 
	true, 
	15		// duration of shot
] spawn BIS_fnc_establishingShot;
