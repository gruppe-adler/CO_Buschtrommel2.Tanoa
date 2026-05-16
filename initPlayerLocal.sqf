params ["_player", "_didJIP"];
enableSaving [false, false];

enableSentences false;  // disable radio transmissions to be heard and seen on screen 


// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;



// ACE menu with Zeus utilities
buschtrommel2_board_troops = false;    // starts troop boarding sequence
private _zeusUtilAction = ["zeusUtils","Zeus Utils","",{},{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _toggleJammerAction = ["toggleJammer",  "Toggle Jammer","", { 
        {
            [null, null, null, [netId _x]] call crowsew_main_fnc_actionjamtoggle;
        } forEach [jammer1, jammer2, jammer3, jammer4];
    },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _boardTroopsAction = ["boardTroops","Board Troops","",{ buschtrommel2_board_troops = true;  },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _afterDarkAction = ["afterDark",  "Skip time to after dark","", { call UTIL_fnc_afterDark; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
// add to Zeus' player's self interaction menu
[(typeOf player), 1, ["ACE_SelfActions"], _zeusUtilAction] call ace_interact_menu_fnc_addActionToClass;
// [(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _toggleJammerAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _boardTroopsAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _afterDarkAction] call ace_interact_menu_fnc_addActionToClass;
// add to Zeus actions menu
[["ACE_ZeusActions"], _toggleJammerAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions"], _boardTroopsAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions"], _afterDarkAction] call ace_interact_menu_fnc_addActionToZeus;
private _gunshipAction = ["gunship","Gunship","",{},{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressPierAction = ["suppressPier","Suppress Pier","",{ [group gunship, target_pier, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerEastAction = ["suppressBunkerEast","Suppress Bunker East","",{ [group gunship, target_bunker_E, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerCenterEastAction = ["suppressBunkerCenterEast","Suppress Bunker Center East","",{ [group gunship, target_bunker_C_E, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerWestAction = ["suppressBunkerWest","Suppress Bunker West","",{ [group gunship, target_bunker_W, 20] call zen_ai_fnc_suppressiveFire; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _gunshipAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressPierAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerEastAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerCenterEastAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerWestAction] call ace_interact_menu_fnc_addActionToZeus;


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