// allow U menu for easier team management
["Initialize", [true]] call BIS_fnc_dynamicGroups;


// set date and time
// [[2035,6,28,6,20]] remoteExec ["setDate"];


buschtrommel2_board_troops = false;    // starts troop boarding sequence
publicVariable "buschtrommel2_board_troops";
first_stomper_drop = true;    // prevents drama music from playing multiple times
publicVariable "first_stomper_drop";


// turn off anti-air radar when jammer on small radar is deactivated
["crowsEW_main_toggleJammer", {
    params ["_netId", "_enabled"];
    private _jammer = crowsew_main_jamMap get _netId;
    if (_jammer#0 == radar_small) then {
        private _onOrOff = [2,1] select _enabled;     // 1 means forced on; 2 means forced off
        radar_big setVehicleRadar _onOrOff;

        // notify players
        private _ActivatedOrNot = ["deactivated", "activated"] select _enabled;
        private _playerHint = format ["Anti air radar has been %1.", _ActivatedOrNot];
        [_playerHint] remoteExec ["hintC", 0];
    }; 
}] call CBA_fnc_addEventHandler;


// randomize weapon caches 
{
    clearWeaponCargoGlobal _x;
    clearMagazineCargoGlobal _x;
    _x addWeaponCargoGlobal ["arifle_AKM_F", floor random 10];
    _x addWeaponCargoGlobal ["arifle_AK12_GL_F", floor random 3];
    _x addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", floor random 10];
    _x addMagazineCargoGlobal ["30Rnd_762x39_Mag_F", floor random 20];
    _x addMagazineCargoGlobal ["30Rnd_762x39_AK12_Mag_F", floor random 20];
    _x addMagazineCargoGlobal ["30Rnd_762x39_Mag_Green_F", floor random 20];
    _x addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_F", floor random 20];
    _x addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_Green_F", floor random 20];
} forEach (allMissionObjects "UK3CB_AK47_Equipbox_Indfor");


// remove NVGs from AI
{ _x unlinkItem hmd _x; } forEach units blufor;



// make journalist on heli bench hold up the handheld camera
reporter disableAI "ANIM";
reporter switchMove "passenger_inside_8_Aim_Binoc";
