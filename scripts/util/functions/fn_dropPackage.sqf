/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_dropPackage.sqf
Parameters: trigger object
Return: none

*///////////////////////////////////////////////

private _intelTexts = [
"Text mit Index 0 ist leer",

"<font color='#D18D1F' size='14'>Tagesbefehl</font> <br/>
Text mit Index 1",

"<font color='#D18D1F' size='14'>Tagesbefehl</font> <br/>
<br/>
<font color='#D18D1F' size='12'>Lage</font>  <br/>
Feind patrouilliert weiterhin mit seinen Überwasserdrohnen; Versorgung mit schweren Gütern über Wasser weiterhin zu riskant; Ausweichen diesbzgl. auf Milchkuh <br/>
<br/>
<font color='#D18D1F' size='12'>Auftrag unverändert</font> <br/>
- Überleben <br/>
- Aufklären der Umgebung aus sicherer Stellung <br/>
- Umgebende Zivilbevölkerung weiterhin mit medizinischer Versorgung wohlgestimmt halten. Vorzugsbehandlung für Junge Männer und Frauen die sich unserer Sachen anschließen, sowie deren Verwandschaft <br/>
- Kräfte ansammeln und ausbilden <br/>
<br/>
<font color='#D18D1F' size='12'>Lieferschein</font> <br/>
Medikamente und Blutkonserven wie angefordert, letztere zu verbrauchen binnen der nächsten Stunden <br/>
<br/>
<font color='#ff0000'>Vernichten Sie dieses Schreiben nachdem sie es gelesen haben!</font> <br/>",

"<font color='#D18D1F' size='14'>Tagesbefehl</font> <br/>
Text mit Index 3",

"<font color='#D18D1F' size='14'>Tagesbefehl</font> <br/>
Text mit Index 4"
];

params ["_trigger"];

private _text = triggerText _trigger;
diag_log _text;

private _triggerNameTokens = _text splitString " ";	// ["Drop","package","1"]
private _packageVarName = _triggerNameTokens select [1, 2] joinString "";	// "package1", "package2", etc.

private _cessna = (list _trigger) select { _x isKindOf "UK3CB_Cessna_172_Base" } select 0;
private _package = _cessna getVariable [_packageVarName, objNull];
if (isNull _package) exitWith { diag_log format ["Package variable %1 not found on %2", _packageVarName, _cessna]; };

{ _x addCuratorEditableObjects [[_package], false];} forEach allCurators;
_package hideObjectGlobal false;	// make package visible when dropped
detach _package;
_package setVelocity (velocity _cessna);

[_package, true] call ace_dragging_fnc_setCarryable;	// make package carryable with ACE (because package tends to get stuck in trees)

private _textIndex = (_triggerNameTokens#2  call BIS_fnc_parseNumber);
[_package, 0, false, 0, "Untersuche...", [], 2, _text, _intelTexts#_textIndex] call zen_modules_fnc_addIntelAction;
