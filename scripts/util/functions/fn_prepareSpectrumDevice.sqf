/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_prepareSpectrumDevice.sqf
Parameters: unit/soldier to prepare for spectrum device use
Return: none

Example:
	_this call UTIL_fnc_prepareSpectrumDevice;  // in unit's Execute field

*///////////////////////////////////////////////

params ["_soldier"];

if (!local _soldier) then {
	private _clientID = clientOwner;

	private _ret_setOwner      = [      _soldier, _clientID] remoteExec ["setOwner", 2];
	private _ret_setGroupOwner = [group _soldier, _clientID] remoteExec ["setGroupOwner", 2];
	diag_log format ["fn_prepareSpectrumDevice.sqf: Change of soldier ownership returned '%1' and '%2'.", _ret_setOwner, _ret_setGroupOwner];
	systemChat "Locality change started";
};	

[_soldier] spawn {	// need to change to scheduled environment in order to use waitUntil
	params ["_soldier"];
	
	waitUntil {local _soldier};	 // wait for potential locality change to finish 
	systemChat "Locality change finished";

	_soldier removeWeapon handgunWeapon _soldier;	// remove any potentially equipped handgun
	_soldier addWeapon "hgun_esd_01_F";				// add the spectrum device
	_soldier addHandgunItem "muzzle_antenna_01_f";	// add antenna
	_soldier selectWeapon handgunWeapon _soldier;	// change used weapon to the spectrum device
	_soldier forceWalk true;						// walk slowly whilst using the spectrum device
};
