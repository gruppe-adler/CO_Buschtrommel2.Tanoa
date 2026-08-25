params ["_player", "_didJIP"];
enableSaving [false, false];

enableSentences false;  // disable radio transmissions to be heard and seen on screen 


// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;



// ACE menu with Zeus utilities
private _zeusUtilAction = ["zeusUtils","Zeus Utils","\A3\Ui_F_Curator\Data\Logos\arma3_zeus_icon_ca.paa",{},{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _spawnFlareAction = ["spawnFlare","Spawn Flare","\a3\Modules_F_Curator\Data\portraitFlareGreen_ca.paa",{ [getPos player vectorAdd [0, 0, 150]] call UTIL_fnc_spawnFlare;  },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _toggleJammerAction = ["toggleJammer",  "Toggle Jammer","\A3\ui_f\data\map\mapcontrol\Transmitter_CA.paa", { 
        {
            [null, null, null, [netId _x]] call crowsew_main_fnc_actionjamtoggle;
        } forEach [jammer1, jammer2, jammer3, jammer4];
    },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _finaleAction = ["finale","Finale","\A3\ui_f\data\map\markers\military\end_CA.paa",{},{!buschtrommel2_board_troops && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _boardTroopsAction = ["boardTroops","Board Troops","\A3\ui_f\data\igui\cfg\simpleTasks\types\takeoff_ca.paa",{ call UTIL_fnc_boardTroops; },{!buschtrommel2_board_troops && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _afterDarkAction = ["afterDark",  "Skip time to after dark","\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa", { remoteExec ["UTIL_fnc_afterDark", 0]; },{dayTime < 18.5 && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _establishingShotAction = ["establishingShot",  "Show establishing shot","\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa", { remoteExec ["UTIL_fnc_establishingShot", 0]; },{dayTime > 18.5 && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
// add to Zeus' player's self interaction menu
[(typeOf player), 1, ["ACE_SelfActions"], _zeusUtilAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _toggleJammerAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _boardTroopsAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _afterDarkAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _establishingShotAction] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions","zeusUtils"], _spawnFlareAction] call ace_interact_menu_fnc_addActionToClass;
// add to Zeus actions menu
[["ACE_ZeusActions"], _toggleJammerAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions"], _finaleAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","finale"], _boardTroopsAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","finale"], _afterDarkAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","finale"], _establishingShotAction] call ace_interact_menu_fnc_addActionToZeus;
private _gunshipAction = ["gunship","Gunship","\A3\Air_F_Exp\VTOL_01\Data\UI\VTOL_01_armed_CA.paa",{},{buschtrommel2_board_troops && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressPierAction = ["suppressPier","Suppress Pier","\A3\ui_f\data\map\mapcontrol\Quay_CA.paa",{ target_pier call UTIL_fnc_suppressTarget; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerEastAction = ["suppressBunkerEast","Suppress Bunker East","\a3\ui_f\data\igui\cfg\simpletasks\letters\e_ca.paa",{ target_bunker_E call UTIL_fnc_suppressTarget; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerCenterEastAction = ["suppressBunkerCenterEast","Suppress Bunker Center East","\A3\ui_f\data\igui\cfg\simpleTasks\types\target_ca.paa",{ target_bunker_C_E call UTIL_fnc_suppressTarget; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _suppressBunkerWestAction = ["suppressBunkerWest","Suppress Bunker West","\a3\ui_f\data\igui\cfg\simpletasks\letters\w_ca.paa",{ target_bunker_W call UTIL_fnc_suppressTarget; },{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _gunshipAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressPierAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerEastAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerCenterEastAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","gunship"], _suppressBunkerWestAction] call ace_interact_menu_fnc_addActionToZeus;
private _packageCarryingAction = ["packageCarrying","Package carrying","\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa",{},{"Man" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
private _carryPackageAction = ["carryPackage","Carry Package","\A3\ui_f\data\igui\cfg\actions\take_ca.paa",{ [curatorSelected#0#0, true] call UTIL_fnc_carryPackage; },{"Man" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
private _dropPackageAction = ["dropPackage","Drop Package","\A3\ui_f\data\igui\cfg\actions\loadVehicle_ca.paa",{ [curatorSelected#0#0, false] call UTIL_fnc_carryPackage; },{"Man" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _packageCarryingAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","packageCarrying"], _carryPackageAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","packageCarrying"], _dropPackageAction] call ace_interact_menu_fnc_addActionToZeus;
private _prepareSpectrumDeviceAction = ["prepareSpectrumDevice","Prepare Spectrum Device","\a3\data_f_enoch\Logos\arma3_enoch_logo_small_ca.paa",{ curatorSelected#0#0 call UTIL_fnc_prepareSpectrumDevice; },{"Man" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _prepareSpectrumDeviceAction] call ace_interact_menu_fnc_addActionToZeus;
private _prepareDemolitionDroneAction = ["prepareDemolitinDrone","Prepare Demolition Drone","\A3\Drones_F\Air_F_Gamma\UAV_01\Data\UI\Map_UAV_01_CA.paa",{ { _x call UTIL_fnc_prepareDemolitionDrone; } forEach curatorSelected#0; },{"UAV_01_base_F" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _prepareDemolitionDroneAction] call ace_interact_menu_fnc_addActionToZeus;
private _prepareSniperDroneAction = ["prepareSniperDrone","Prepare Sniper Drone","\lxWS\air_f_lxWS\Data\UI\UAV_02_CA.paa",{ curatorSelected#0#0 call UTIL_fnc_prepareSniperDrone; },{"UAV_02_Base_lxWS" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _prepareSniperDroneAction] call ace_interact_menu_fnc_addActionToZeus;
private _loadAmmoBoxAction = ["loadAmmoBox","Load into Pickup","\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",{ curatorSelected#0#0 attachTo [ammobox_pickup, [0.2, 1.4, -0.05], "Supply", true]; },{"gm_ammobox_aluminium_01_empty" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _loadAmmoBoxAction] call ace_interact_menu_fnc_addActionToZeus;
private _loadWaterBoxAction = ["loadWaterBox","Load into Pickup","\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",{ curatorSelected#0#0 attachTo [water_pickup, [0.2, 1.4, 0.6], "Supply", true]; curatorSelected#0#0 setVectorDirAndUp [[1,0,0], [0,0,1]]; },{"Land_PaperBox_01_open_water_F" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _loadWaterBoxAction] call ace_interact_menu_fnc_addActionToZeus;
private _dropWaterAction = ["dropWater","Drop Water","\A3\ui_f\data\Map\MapControl\fountain_CA.paa",{  createVehicle ["Land_WaterBottle_01_pack_F", curatorSelected#0#0, [], 0, "NONE"]; },{"Land_PaperBox_01_open_water_F" call UTIL_fnc_curatorSelectedIsKindOf;}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _dropWaterAction] call ace_interact_menu_fnc_addActionToZeus;
private _deleteMarkerAction = ["deleteMarker","Delete Marker","\A3\ui_f\data\map\markers\military\warning_CA.paa",{},{(getMarkerType "marker_lost_stomper_east" + getMarkerType "marker_lost_stomper_west" + getMarkerType "marker_lost_stomper_ravi-ta") != "" && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _deleteStomperLostMarkerEastAction = ["deleteStomperLostMarkerEast","Stomper lost east","\a3\ui_f\data\igui\cfg\simpletasks\letters\e_ca.paa",{ deleteMarker "marker_lost_stomper_east"; },{getMarkerType "marker_lost_stomper_east" != "" && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _deleteStomperLostMarkerWestAction = ["deleteStomperLostMarkerWest","Stomper lost west","\a3\ui_f\data\igui\cfg\simpletasks\letters\w_ca.paa",{ deleteMarker "marker_lost_stomper_west"; },{getMarkerType "marker_lost_stomper_west" != "" && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _deleteStomperLostMarkerNorthAction = ["deleteStomperLostMarkerNorth","Stomper lost Ravi-Ta","\a3\ui_f\data\igui\cfg\simpletasks\letters\n_ca.paa",{ deleteMarker "marker_lost_stomper_ravi-ta"; },{getMarkerType "marker_lost_stomper_ravi-ta" != "" && !isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _deleteMarkerAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","deleteMarker"], _deleteStomperLostMarkerEastAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","deleteMarker"], _deleteStomperLostMarkerWestAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","deleteMarker"], _deleteStomperLostMarkerNorthAction] call ace_interact_menu_fnc_addActionToZeus;
private _teleportAction = ["teleport","Teleport into heli","\a3\ui_f\data\igui\cfg\simpletasks\types\heli_ca.paa",{},{!isNull (getAssignedCuratorLogic player)}] call ace_interact_menu_fnc_createAction;
private _teleportToPilot1Action = ["teleportToPilot1","of pilot 1","\a3\ui_f\data\gui\cfg\ranks\private_pr.paa",{ player moveInCargo vehicle pilot1; },{!isNull (getAssignedCuratorLogic player) && ((vehicle pilot1) isKindOf "Helicopter")}] call ace_interact_menu_fnc_createAction;
private _teleportToPilot2Action = ["teleportToPilot2","of pilot 2","\a3\ui_f\data\gui\cfg\ranks\corporal_pr.paa",{ player moveInCargo vehicle pilot2; },{!isNull (getAssignedCuratorLogic player) && ((vehicle pilot2) isKindOf "Helicopter")}] call ace_interact_menu_fnc_createAction;
private _teleportToPilot3Action = ["teleportToPilot3","of pilot 3","\a3\ui_f\data\gui\cfg\ranks\sergeant_pr.paa",{ player moveInCargo vehicle pilot3; },{!isNull (getAssignedCuratorLogic player) && ((vehicle pilot3) isKindOf "Helicopter")}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _teleportAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","teleport"], _teleportToPilot1Action] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","teleport"], _teleportToPilot2Action] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions","teleport"], _teleportToPilot3Action] call ace_interact_menu_fnc_addActionToZeus;
