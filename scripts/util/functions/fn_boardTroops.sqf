/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_boardTroops.sqf
Parameters: none
Return: none

*///////////////////////////////////////////////


// global variable to set off the end scene
buschtrommel2_board_troops = true;  
publicVariable "buschtrommel2_board_troops";


// make gunship and associated objects local to Zeus' machine for smoother handling
private _clientID = clientOwner;
{
	if (!local _x) then {
		private _ret_setOwner      = [      _x, _clientID] remoteExec ["setOwner", 2];
		private _ret_setGroupOwner = [group _x, _clientID] remoteExec ["setGroupOwner", 2];
		diag_log format ["fn_boardTroops.sqf: Change of ownership for %1 returned '%2' and '%3'.", _x, _ret_setOwner, _ret_setGroupOwner];
	};
} forEach [blackfish_1, blackfish_2, gunship, target_pier, target_bunker_E, target_bunker_C_E, target_bunker_W];
