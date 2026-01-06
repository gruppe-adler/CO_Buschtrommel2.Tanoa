class NATO_Apex_Pacific {
    class AllUnits {
        uniform[] = {
            "U_B_T_Soldier_AR_F",
            "U_B_T_Soldier_SL_F",
            "U_B_T_Soldier_F"
        };
        vest = "V_Chestrig_rgr";
        backpack = "B_AssaultPack_tna_F";
        headgear[] = {
            "H_HelmetB_Light_tna_F",
            "H_HelmetB_Enh_tna_F",
            "H_HelmetB_tna_F"
        };
        primaryWeapon = "";
        primaryWeaponMagazine = "";
        primaryWeaponOptics = "";
        primaryWeaponMuzzle = "";
        primaryWeaponPointer = "";
        primaryWeaponUnderbarrel = "";
        primaryWeaponUnderbarrelMagazine = "";
        secondaryWeapon = "";
        secondaryWeaponMagazine = "";
        secondaryWeaponMuzzle = "";
        secondaryWeaponOptics = "";
        secondaryWeaponPointer = "";
        secondaryWeaponUnderbarrel = "";
        secondaryWeaponUnderbarrelMagazine = "";
        handgunWeapon = "hgun_esd_01_F";    // spectrum device
        handgunWeaponMuzzle = "muzzle_antenna_01_f";    // military antenna
        handgunWeaponMagazine = "";
        handgunWeaponOptics = "";
        handgunWeaponPointer = "";
        handgunWeaponUnderbarrel = "";
        handgunWeaponUnderbarrelMagazine = "";
        goggles = "";
        nvgoggles = ""; // "NVGoggles_tna_F";
        radio = "TFAR_anprc152";
        binoculars = "Binocular";
        map = "ItemMap";
        gps = "B_UavTerminal";
        compass = "ItemCompass";
        watch = "ItemWatch";
        addItemsToUniform[] = {
            GRAD_FACTIONS_MEDICITEMS_INF_LIST,
            LIST_1("muzzle_antenna_03_f"),      // jamming antenna
            LIST_2("ACE_CableTie"),
            LIST_1("ACE_MapTools"),
            LIST_1("crowsew_tfar_icom")                
          };
        addItemsToVest[] = {
            LIST_2("SmokeShell"),
            LIST_2("SmokeShellGreen")
        };
        addItemsToBackpack[] = {
            // LIST_1("ACE_EntrenchingTool"),
            LIST_1("ACE_UAVBattery")
        };

    };

    class Type {
        // rifleman (base class for infantry)
        class Soldier_F {
            vest[] = {
              "V_PlateCarrier1_tna_F",
              "V_PlateCarrier2_tna_F",
              "V_PlateCarrierSpec_tna_F"
            };
            primaryWeapon = "arifle_MX_khk_F";
            primaryWeaponMagazine = "30Rnd_65x39_caseless_khaki_mag";
            primaryWeaponOptics = "optic_Aco";
            addItemsToVest[] = {
                LIST_7("30Rnd_65x39_caseless_khaki_mag"),
                LIST_2("HandGrenade")
            };
        };

        // squad leader
        class Soldier_SL_F: Soldier_F {
            backpack = "TFAR_rt1523g_bwmod";
            binoculars = "Rangefinder";
            addItemsToBackpack[] = {
                LIST_3("30Rnd_65x39_caseless_khaki_mag_Tracer")
            };
        };
        
        // medic
        class Medic_F: Soldier_F {
            backpack = "B_AssaultPack_tna_BTMedic_F";
            GRAD_FACTIONS_MEDICITEMS_SQ
        };
        
        // grenadier
        class Soldier_GL_F: Soldier_F {
            primaryWeapon = "arifle_MX_GL_khk_F";   // MX with underbarrel grenade launcher
            primaryWeaponUnderbarrelMagazine = "1Rnd_HE_Grenade_shell";
            vest = "UK3CB_LDF_B_V_GREN_Vest_KKZ10_GEO";
            addItemsToBackpack[] = {
                LIST_15("1Rnd_HE_Grenade_shell")
            };
        };
        
        // engineer (incl. electronic warfare)
        class Engineer_F: Soldier_F {
            addItemsToBackpack[] = {
                LIST_1("ToolKit"),
                LIST_1("ACE_EntrenchingTool"),
                LIST_1("ACE_wirecutter"),
                LIST_3("DemoCharge_Remote_Mag")
            };
        };
        
        // explosive specialist
        class Soldier_Exp_F: Soldier_F {
            // backpack = "UK3CB_CSAT_G_O_B_ASS";    // force large backpack for this role
            addItemsToBackpack[] = {
                LIST_1("ACE_DefusalKit"),
                LIST_1("ACE_VMM3"),
                LIST_3("APERSMine_Range_Mag"),
                LIST_3("APERSBoundingMine_Range_Mag"),
                LIST_3("DemoCharge_Remote_Mag")
            };
        };
        
        // anti air
        class Soldier_AA_F: Soldier_F {
            secondaryWeapon = "launch_B_Titan_tna_F";
            secondaryWeaponMagazine = "Titan_AA";
            binoculars = "";    // not needed, because Titan launcher
            // backpack = "UK3CB_CSAT_G_O_B_ASS";    // force large backpack for this role
            addItemsToBackpack[] = {
                LIST_1("Titan_AA")
            };
        };
        // anti air assistant
        class Soldier_AAA_F: Soldier_F {
            // backpack = "UK3CB_CSAT_G_O_B_ASS";    // force large backpack for this role
            addItemsToBackpack[] = {
                LIST_3("Titan_AA")
            };
        };
        
        // anti tank
        class Soldier_AT_F: Soldier_F {
            secondaryWeapon = "launch_B_Titan_short_tna_F";
            secondaryWeaponMagazine = "Titan_AT";
            binoculars = "";    // not needed, because Titan launcher
            // backpack = "UK3CB_CSAT_G_O_B_ASS";    // force large backpack for this role
            addItemsToBackpack[] = {
                LIST_3("Titan_AT")
            };
        };
        
        // marksman
        class soldier_M_F: Soldier_F {
            primaryWeapon = "srifle_LRR_tna_LRPS_F";
            primaryWeaponMagazine = "7Rnd_408_Mag";
            primaryWeaponOptics = "optic_LRPS_tna_F";
            addItemsToVest[] = {
                LIST_1("ACE_RangeCard")                
            };
        };
        
        /*** following are classes not derived from the rifleman ***/
        
        // Heli pilot
        class Helipilot_F {
            uniform = "U_B_HeliPilotCoveralls";
            vest = "V_TacVest_blk";
            backpack = "TFAR_rt1523g_bwmod";
            headgear = "H_PilotHelmetHeli_B";
            primaryWeapon = "SMG_01_Holo_F";
            primaryWeaponMagazine = "30Rnd_45ACP_Mag_SMG_01";
            primaryWeaponOptics = "optic_Holosight_smg";
            addItemsToVest[] = {
                LIST_3("30Rnd_45ACP_Mag_SMG_01"),
                LIST_1("SmokeShellBlue"),
                LIST_1("SmokeShellOrange")
            };
        };

        // automatic rifle 
        class Soldier_AR_F {
            vest[] = {
              "V_PlateCarrier1_tna_F",
              "V_PlateCarrier2_tna_F"
            };
            primaryWeapon = "arifle_MX_SW_khk_F";
            primaryWeaponMagazine = "100Rnd_65x39_caseless_khaki_mag";
            primaryWeaponUnderbarrel = "bipod_01_F_khk";
            addItemsToVest[] = {
                LIST_5("100Rnd_65x39_caseless_khaki_mag")
            };
        };
        
        // artillery gunner (base class for non-hunter-killer)
        class Support_Mort_F {
            primaryWeapon = "arifle_MXC_khk_Holo_Pointer_F";
            primaryWeaponMagazine = "30Rnd_65x39_caseless_khaki_mag";
            primaryWeaponOptics = "optic_Holosight_khk_F";
            goggles = "G_Tactical_Clear";
            addItemsToVest[] = {
                LIST_5("30Rnd_65x39_caseless_khaki_mag"),
                LIST_1("ACE_artilleryTable"),
                LIST_1("ACE_PlottingBoard"),
                LIST_1("ACE_EntrenchingTool"),
                LIST_1("ACE_Fortify")                
            };
        };       
        
        // artillery leader
        class Soldier_TL_F: Support_Mort_F {
            backpack = "TFAR_rt1523g_bwmod";
        };        
        
        // sensor operator (UAV and directionfinder)
        class Soldier_UAV_F: Support_Mort_F {
            headgear = "H_MilCap_tna_F";
            gps = "B_UavTerminal";
            addItemsToVest[] = {
                LIST_5("30Rnd_65x39_caseless_khaki_mag"),
                LIST_3("ACE_UAVBattery")
            };
            backpack = "TFAR_rt1523g_bwmod";
        };        
        
        // commander
        class Officer_F: Soldier_UAV_F {
            primaryWeapon = "";
            vest = "";
            goggles = "";
            uniform = "U_B_T_Soldier_SL_F";
            backpack = "TFAR_rt1523g_bwmod";
            headgear = "grad_extras_beret_red";
            handgunWeaponMuzzle = "muzzle_antenna_01_f";
            addItemsToUniform[] = {
                LIST_1("muzzle_antenna_03_f")
            };
            addItemsToBackpack[] = {
                LIST_1("ACE_wirecutter")
            };
        };        
    };
};
