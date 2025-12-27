/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_dropPackage.sqf
Parameters: trigger object
Return: none

*///////////////////////////////////////////////

params ["_trigger"];

private _text = triggerText _trigger;
diag_log _text;

private _triggerNameTokens = _text splitString " ";	// ["Drop","package","1"]
private _packageVarName = _triggerNameTokens select [1, 2] joinString "";;

private _cessna = (list _trigger) select { _x isKindOf "UK3CB_Cessna_172_Base" } select 0;
private _package = _cessna getVariable [_packageVarName, objNull];
if (isNull _package) exitWith { diag_log format ["Package variable %1 not found on %2", _packageVarName, _cessna]; };

{ _x addCuratorEditableObjects [[_package], false];} forEach allCurators;
_package hideObjectGlobal false;
detach _package;
_package setVelocity (velocity _cessna);
