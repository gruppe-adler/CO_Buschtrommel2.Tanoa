/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_afterDark.sqf
Parameters: none
Return: none

*///////////////////////////////////////////////

if (!hasInterface || dayTime > 18.5) exitWith {};

0 spawn {
	private _fadeOutDuration = 1.5;	
	["BlackScreen_jump2afterDark", true, _fadeOutDuration] call BIS_fnc_blackOut;
	sleep _fadeOutDuration;

	skipTime ((18.5 - dayTime + 24) % 24); // skip forward to a specific time, irrespective of the current mission time

	private _textOnScreen = [
		[
			["Aéroport de Tanoa", "align = 'center' shadow = '1' size = '0.7' font='PuristaSemibold'"],
			[" - after dark", "align = 'center' shadow = '1' size = '0.7' font='PuristaLight'", "#aaaaaa"],
			["", "<br/>"], // line break
			["Combat troops get ready to move out...", "align = 'center' shadow = '1' size = '0.7'"]
		],
		safeZoneX, safeZoneH / 2,
		true
	] spawn BIS_fnc_typeText2;

	waitUntil { scriptDone _textOnScreen };

	["BlackScreen_jump2afterDark", true, 3] call BIS_fnc_blackIn;
	
	
	// clean up planes (might disturb the immersion if they are still around after the time skip)
	{
		if (side _x != west) then { 
			deleteVehicleCrew _x;
			deleteVehicle _x;
		};
	} forEach [ambient_plane, drop_plane, airport_stomper];
}
