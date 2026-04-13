if !(hasInterface) exitWith {};

// create root of ingame documentation
player createDiarySubject ["buschtrommel_diarySubject","Buschtrommel"];


// create empty diary records
private _WorkaroundsRecord = player createDiaryRecord ["buschtrommel_diarySubject", ["",""]];
private _OmniJammerRecord = player createDiaryRecord ["buschtrommel_diarySubject", ["",""]];
private _EWRecord = player createDiaryRecord ["buschtrommel_diarySubject", ["",""]];


// create links to chapters
private _OmniJammerLink = createDiaryLink ["buschtrommel_diarySubject", _OmniJammerRecord, "Drone jammer"];
private _CBAkeybindingsLink = createDiaryLink ["cba_help_docs", cba_help_DiaryRecordKeys, 'CBA keybindings (section "Crows Electronic Warfare")'];


// create workaround functions (as a potential self-service for players)
private _DroneAIWorkaround = "<br/>
------------------------------------------------------------------------------------------------ <br/>
<font color='#ff00ff' size='14'>Drone AI bug</font> <br/>
Arma's drone AI is quite prone to breaking. <br/>
Then a <font color='#00ffff'>drone can't operate autonomously anymore</font>. <br/>
(e.g. happens when you do a <execute expression='[""ACE_Items"", ""ACE_UAVBattery""] call BIS_fnc_openFieldManual'>battery swap with ACE</execute>) <br/>
<br/>
Using the link below you should be able to restore them. <br/>
<executeClose expression='call diary_fnc_fixDroneAI'>Fix drone AI</executeClose><br/>
<br/>
Another way of fixing this manually for Darter drones is <br/>
to <font color='#00ffff'>disassemble them (into a backpack) and then reassembling</font> them. <br/>
<br/>";


// Electronic warfare docu
player setDiaryRecordText [["buschtrommel_diarySubject", _EWRecord], ["Electronic warfare", format [
"
<font color='#D18D1F' size='16'>Electronic warfare</font> <br/>
Electronic warfare (EW in short) is about <font color='#00ffff'>measuring radio signals</font> that the enemy emits 
and <font color='#00ffff'>interfering with those radio signals</font> (also called electronic attack). <br/>
<br/>
<font color='#D18D1F' size='14'>Measuring radio signals</font> <br/>
Imagine the first process as being able to 'hear' enemy radio transmissions like you are able to hear enemy fire. <br/>
It allows you to detect and locate enemies that you have no chance of seeing yet. <br/>
<br/>
When the enemy has competent EW operators themselves, radio discipline becomes just as important as trigger discipline with your gun. <br/>
Every time you use your radio, there could be an enemy picking up on that transmission. Just as if you fire your gun and an enemy hears it. <br/>
<br/>
Remote controlled assets like 
<execute expression='[""VehicleList"", ""UAVrotor""] call BIS_fnc_openFieldManual'>UAVs</execute>
 and 
<execute expression='[""VehicleList"", ""UGV""] call BIS_fnc_openFieldManual'>UGVs</execute> 
 have no way of showing this radio discipline. 
They <font color='#00ffff'>constantly broadcast their video feed signal</font> and thus are permanently detectable this way.<br/>
The screenshot below shows such video signals for 3x Stompers. <br/>
<img src='pics\ew_stomper_signals.jpg' width='370' height='185' title='UGV radio signals' /> 
The Stomper in the middle has the EW operator's antenna pointed directly at it. This is why it has the strongest signal in the spectrum device (leftmost peak). <br/>
<br/>
The screenshot below shows how your own radio signal would look like in the spectrum device if you were an EW operator. <br/>
<img src='pics\ew_detecting_own_emission.jpg' width='370' height='185' title='Own radio emission shown in spectrum device' />
If EW operators have a signal in their <font color='#499ED0'>selected frequency band</font>, they can decide to listen in to that signal by <font color='#00ffff'>clicking and holding the left mouse button</font>. <br/>
<br/>
<font color='#D18D1F' size='14'>Selecting radio signals</font> <br/>
The spectrum device uses your handgun slot. You can use it just as you would use your handgun. 
<font color='#00ffff'>%1 opens the spectrum analyzer display.</font> <br/> 
<img src='pics\ew_spectrum_analyzer.jpg' width='370' height='370' title='Spectrum analyzer display' /> 
- <font color='#00ffff'>Mouse-wheel up/down</font> will change the <font color='#499ED0'>selected frequency band</font> <br/>
- <font color='#00ffff'>Mid. Mouse Btn.</font> will <font color='#ff00ff'>zoom in</font> to the <font color='#499ED0'>selected frequency band</font> <br/>
- <font color='#00ffff'>Shift + Mid. Mouse Btn</font> will <font color='#ff00ff'>unzoom</font> <br/>
  (back to maximum range of mounted antenna) <br/>
<br/>
<font color='#D18D1F' size='14'>Antennas</font> <br/>
Antennas use the muzzle attachment slot of your 'handgun' (most commonly used for suppressors). <br/>
<br/>
EW operators are equipped with <font color='#00ffff'>2x types of antennas</font>. <br/>
<img src='\a3\Weapons_F_Enoch\Pistols\ESD_01\data\ui\gear_muzzle_antenna_01_ca.paa'  width='150' height='150' title='%2' /> <br/>
The <font color='#00ffff'>%2</font> has a <font color='#00ff00'>wide frequency range</font> in which it can detect signals and is able to support <font color='#00ff00'>listening in to voice communication signals</font>. But it <font color='#ff0000'>can not be used to disable drones</font>. <br/>
<img src='\a3\Weapons_F_Enoch\Pistols\ESD_01\data\ui\gear_muzzle_antenna_03_ca.paa'  width='150' height='150' title='%3' /> <br/>
The <font color='#00ffff'>%3</font>  has a <font color='#ff0000'>narrower frequency range</font> but <font color='#00ff00'>can both detect and disable/jam drones</font> (details below). <font color='#ff0000'>Listening in to signals is not possible</font> with this antenna though. <br/>
<br/>
<font color='#D18D1F' size='14'>Interfering with radio signals</font> <br/>
This is how you can jam drones: <br/>
1. put the %3 on your spectrum device <br/>
2. put the drone signal you wish to jam into the <font color='#499ED0'>selected frequency band</font> (using the mouse-wheel) <br/> 
3. press and hold <font color='#00ffff'>Left Mouse Btn.</font> <br/>
<br/>
Consequences for jammed drone: <br/>
1. Human pilots are disconnected instantly. <br/> 
2. <execute expression='[""VehicleList"", ""UAVrotor""] call BIS_fnc_openFieldManual'>Darter UAVs</execute> will <font color='#00ffff'>decent down to 30m and hover there for ~10s</font> after which they land. <br/> 
3. Once drone landed you don't need to continue jamming. <br/> 
<br/>
The %4 is another way of interfering with radio signals necessary to control <execute expression='[""VehicleList"", ""UAVrotor""] call BIS_fnc_openFieldManual'>UAVs</execute>. <br/>
<br/>
<font color='#D18D1F' size='14'>Bearing lines on map</font> <br/>
To help with locating enemy transmissions the spectrum device can log its current position, current frequency and direction the antenna is pointing towards on the map. <br/>
<img src='pics\directionfinder_results_on_map.jpg' width='370' height='370' title='Blufor will see blue lines, Opfor will see red lines' /> 
The keybindings for this feature can be found in <br/>
%5 <br/>
", actionKeysNames "optics", 
getText (configFile >> "CfgWeapons" >> "muzzle_antenna_01_f" >> "displayName"),   // monitoring antenna
getText (configFile >> "CfgWeapons" >> "muzzle_antenna_03_f" >> "displayName"),   // jamming antenna
_OmniJammerLink, _CBAkeybindingsLink]]];


// Drone jammer docu
private _JammerEffectiveRadius = demo_jammer getVariable "EffectiveRadius";
private _JammerFalloffRadius = demo_jammer getVariable "FalloffRadius";
player setDiaryRecordText [["buschtrommel_diarySubject", _OmniJammerRecord], ["Drone jammer", format [
"<font color='#D18D1F' size='16'>Drone jammer (area denial)</font> <br/>
The <font color='#00ffff'>area denial anti drone jammer</font> is a box that can be turned on and off. <br/>
<img src='pics\omni_jammer_box.jpg' width='370' height='370' title='Drone jammer box' /> 
(activate and de-activate via Vanilla mouse-scroll menu) <br/>
<br/>
When activated it <font color='#00ffff'>distorts the video feed</font> for the drone pilots in a <font color='#00ffff'>radius of %1m</font> around/above the jammer. <br/>
<img src='pics\distorted_video_feed.jpg' width='370' height='370' title='Distorted video signal' /> 
This makes aerial reconnaissance difficult or impossible (dependent on how close the drone is to the jammer). <br/>
<br/>
The drone will suffer a <font color='#ff00ff'>softkill at a distance of &lt;%2m</font> to the jammer. <br/>
- pilots get disconnected <br/>
- drone is forced to stop moving and slowly land <br/>
<br/>
Note: <br/>
- jammer <font color='#00ffff'>effects both enemy and friendly drones</font> <br/>
- radiuses are 3D (meaning drone altitude also counts)<br/>
- UGVs are also effected by the jammer <br/>
<br/>
Transportation: <br/>
- <font color='#00ffff'>ACE carrying and vic loading are supported</font> <br/>
- box deactivates when being loaded <br/>
- takes 1x ACE cargo space  <br/>
<br/>
Bugs: <br/>
- unloading takes 3-6s before box appears <br/>
- box is indestructible (but will die along with a vic when loaded) <br/>
- not subject to gravity (when deployed off ground it stays in the air)<br/>
", (_JammerEffectiveRadius + _JammerFalloffRadius), _JammerEffectiveRadius]]];


// Workarounds section (for quick and easy access)
player setDiaryRecordText [["buschtrommel_diarySubject", _WorkaroundsRecord], ["Workarounds", _DroneAIWorkaround]];


// select top-most entry at game start
// player selectDiarySubject "buschtrommel_diarySubject:Record-1";
