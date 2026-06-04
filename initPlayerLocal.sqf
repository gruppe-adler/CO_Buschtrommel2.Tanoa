params ["_player", "_didJIP"];
enableSaving [false, false];

enableSentences false;  // disable radio transmissions to be heard and seen on screen 


// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;



// ACE menu with Zeus utilities
buschtrommel2_board_troops = false;    // starts troop boarding sequence
private _zeusUtilAction = ["zeusUtils","Zeus Utils","\A3\Ui_F_Curator\Data\Logos\arma3_zeus_icon_ca.paa",{},{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _spawnFlareAction = ["spawnFlare","Spawn Flare","\a3\Modules_F_Curator\Data\portraitFlareGreen_ca.paa",{ [getPos player vectorAdd [0, 0, 150]] call UTIL_fnc_spawnFlare;  },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _toggleJammerAction = ["toggleJammer",  "Toggle Jammer","\A3\ui_f\data\map\mapcontrol\Transmitter_CA.paa", { 
        {
            [null, null, null, [netId _x]] call crowsew_main_fnc_actionjamtoggle;
        } forEach [jammer1, jammer2, jammer3, jammer4];
    },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _finaleAction = ["finale","Finale","\A3\ui_f\data\map\markers\military\end_CA.paa",{},{!buschtrommel2_board_troops && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _boardTroopsAction = ["boardTroops","Board Troops","\A3\ui_f\data\igui\cfg\simpleTasks\types\takeoff_ca.paa",{ buschtrommel2_board_troops = true;  },{!buschtrommel2_board_troops && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _afterDarkAction = ["afterDark",  "Skip time to after dark","\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa", { call UTIL_fnc_afterDark; },{dayTime < 18.5 && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
// add to Zeus' player's self interaction menu
[(typeOf player), 1, ["ACE_SelfActions"], _zeusUtilAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _boardTroopsAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _afterDarkAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _spawnFlareAction] call ace_interact_menu_fnc_addActionToClass;
// add to Zeus actions menu
[["ACE_ZeusActions"], _toggleJammerAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions"], _finaleAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","finale"], _boardTroopsAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","finale"], _afterDarkAction] call ace_interact_menu_fnc_addActionToZeus;
private _gunshipAction = ["gunship","Gunship","\A3\Air_F_Exp\VTOL_01\Data\UI\VTOL_01_armed_CA.paa",{},{buschtrommel2_board_troops && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressPierAction = ["suppressPier","Suppress Pier","\A3\ui_f\data\map\mapcontrol\Quay_CA.paa",{ [group gunship, target_pier, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerEastAction = ["suppressBunkerEast","Suppress Bunker East","\a3\ui_f\data\igui\cfg\simpletasks\letters\e_ca.paa",{ [group gunship, target_bunker_E, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerCenterEastAction = ["suppressBunkerCenterEast","Suppress Bunker Center East","\A3\ui_f\data\igui\cfg\simpleTasks\types\target_ca.paa",{ [group gunship, target_bunker_C_E, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerWestAction = ["suppressBunkerWest","Suppress Bunker West","\a3\ui_f\data\igui\cfg\simpletasks\letters\w_ca.paa",{ [group gunship, target_bunker_W, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _gunshipAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressPierAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerEastAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerCenterEastAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerWestAction] call ace_interact_menu_fnc_addActionToZeus;
private _packageCarryingAction = ["packageCarrying","Package carrying","\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa",{},{curatorSelected#0#0 isKindOf "Man"}] call ace_interact_menu_fnc_createAction;
private _carryPackageAction = ["carryPackage","Carry Package","\A3\ui_f\data\igui\cfg\actions\take_ca.paa",{ [curatorSelected#0#0, true] call UTIL_fnc_carryPackage; },{curatorSelected#0#0 isKindOf "Man"}] call ace_interact_menu_fnc_createAction;
private _dropPackageAction = ["dropPackage","Drop Package","\A3\ui_f\data\igui\cfg\actions\loadVehicle_ca.paa",{ [curatorSelected#0#0, false] call UTIL_fnc_carryPackage; },{curatorSelected#0#0 isKindOf "Man"}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _packageCarryingAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","packageCarrying"], _carryPackageAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","packageCarrying"], _dropPackageAction] call ace_interact_menu_fnc_addActionToZeus;
private _prepareSpectrumDeviceAction = ["prepareSpectrumDevice","Prepare Spectrum Device","\a3\data_f_enoch\Logos\arma3_enoch_logo_small_ca.paa",{ curatorSelected#0#0 call UTIL_fnc_prepareSpectrumDevice; },{curatorSelected#0#0 isKindOf "Man"}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _prepareSpectrumDeviceAction] call ace_interact_menu_fnc_addActionToZeus;
private _prepareDemolitionDroneAction = ["prepareDemolitinDrone","Prepare Demolition Drone","\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\Map_UAV_01_CA.paa",{ curatorSelected#0#0 call UTIL_fnc_prepareDemolitionDrone; },{curatorSelected#0#0 isKindOf "UAV_01_base_F"}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _prepareDemolitionDroneAction] call ace_interact_menu_fnc_addActionToZeus;
private _prepareSniperDroneAction = ["prepareSniperDrone","Prepare Sniper Drone","\lxWS\air_f_lxWS\Data\UI\UAV_02_CA.paa",{ curatorSelected#0#0 call UTIL_fnc_prepareSniperDrone; },{curatorSelected#0#0 isKindOf "UAV_02_Base_lxWS"}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _prepareSniperDroneAction] call ace_interact_menu_fnc_addActionToZeus;


/*
// cinematic establishing shot
waitUntil { !isNull findDisplay 46 && date#3 < 7};   // need to wait until mission display is loaded and clients have synced their time to the server (before 7am)
[
    small_SAM,  // cam target and rotational center
    "Zerstörer ""Seeadler"" nördlich von Tanoa", // intro text
    40,     // altitude of cam
    110,    // radius of cam rotation
    100,
    1,      // clockwise rotation
    [], 
    0, 
    true, 
    10
] spawn BIS_fnc_establishingShot;
*/