/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_prepareSpectrumDevice.sqf
Parameters: unit/soldier to prepare for spectrum device use
Return: none

Example:
	_this call UTIL_fnc_prepareSpectrumDevice;  // in unit's Execute field

*///////////////////////////////////////////////

params ["_soldier"];

_soldier removeWeapon handgunWeapon _soldier;	// remove any potentially equipped handgun
_soldier addWeapon "hgun_esd_01_F";				// add the spectrum device
_soldier addHandgunItem "muzzle_antenna_01_f";	// add antenna
_soldier selectWeapon handgunWeapon _soldier;	// change used weapon to the spectrum device
_soldier forceWalk true;						// walk slowly whilst using the spectrum device
