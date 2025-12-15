params ["_player", "_didJIP"];
enableSaving [false, false];

enableSentences false;  // disable radio transmissions to be heard and seen on screen 


// allow U menu for easier team management
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;



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