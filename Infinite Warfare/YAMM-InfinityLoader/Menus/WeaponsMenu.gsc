/*
*	 Infinity Loader :: When only the best will do
*
*	 Project : YAMM-Latest
*	 Author : AuroraDoesCode
*	 Game : Call of Duty: Infinite Warfare
*	 Description : Container for Weapon Options
*	 Date : 28/08/2026 11:08:07
*
*/

CreateWeaponsMenuOptions()
{
    switch (self getCurrentMenu())
    {
        case "Weapon Manipulation":
            self addMenu("Weapon Manipulation", "Weapon Manipulation");
                self addOpt("Weapon Selection", ::newMenu, "Weapon Selection");
                self addOpt("Pillaged Loot", ::newMenu, "Pillaged Loot");
                self addOpt("Powerup Loot", ::newMenu, "Powerup Loot");
                self addOpt("Fill Fate And Fortune", ::FillFAF);
            break;
        case "Pillaged Loot":
            self addMenu("Pillaged Loot", "Pillaged Loot");
                for(i=0;i<level.pickupLootName.size;i++)
                    self addOpt("Give "+level.pickupLootName[i], ::givePillagedLoot, level.pickupLoot[i]);
            break;
        case "Weapon Selection":
            self addMenu("Weapon Selection", "Weapon Selection");
                for(e=0;e<level.WeaponCategories.size;e++)
                self addOpt(level.WeaponCategories[e], ::newMenu, level.WeaponCategories[e] );
            break;
        case "Assault Rifles":
            self addMenu(level.WeaponCategories[0], "Assault Rifles");
                for(i=0;i<level.ARNames.size;i++){
                    self addOpt(level.ARNames[i], ::GiveWeaponToPlayer, level.Assault[i], self);
                }
            break;        
        case "Sub Machine Guns":
            self addMenu(level.WeaponCategories[1], "Sub Machine Guns");
                for(i=0;i<level.SMGNames.size;i++){
                    self addOpt(level.SMGNames[i], ::GiveWeaponToPlayer, level.SMG[i], self);
                }
            break;
        case "Shotguns":
            self addMenu(level.WeaponCategories[4], "Shotguns");
                for(i=0;i<level.ShotgunNames.size;i++){
                    self addOpt(level.ShotgunNames[i], ::GiveWeaponToPlayer, level.Shotguns[i], self);
                }
            break;
        case "Light Machine Guns":
            self addMenu(level.WeaponCategories[2], "Light Machine Guns");
                for(i=0;i<level.LMGNames.size;i++){
                    self addOpt(level.LMGNames[i], ::GiveWeaponToPlayer, level.LMG[i], self);
                }
            break;
        case "Sniper Rifles":
            self addMenu(level.WeaponCategories[3], "Sniper Rifles");
                for(i=0;i<level.SniperNames.size;i++){
                    self addOpt( level.SniperNames[i], ::GiveWeaponToPlayer, level.Snipers[i], self ); 
                }
            break;
        case "Launchers":
            self addMenu(level.WeaponCategories[6], "Launchers");
                for(i=0;i<level.LauncherNames.size;i++){
                    self addOpt( level.LauncherNames[i], ::GiveWeaponToPlayer, level.Launchers[i], self ); 
                }
            break;
        case "Pistols":
            self addMenu(level.WeaponCategories[5], "Pistols");
                for(i=0;i<level.PistolNames.size;i++){
                    self addOpt( level.PistolNames[i], ::GiveWeaponToPlayer, level.Pistols[i], self );
                    }
            break;
        case "Classic Weapons":
            self addMenu(level.WeaponCategories[7], "Classic Weapons");
                for(i=0;i<level.ClassicNames.size;i++){
                    self addOpt(level.ClassicNames[i], ::GiveWeaponToPlayer, level.Classics[i], self);
                }
            break;
        case "Melee Weapons":
            self addMenu(level.WeaponCategories[8], "Melee Weapons");
            for(i=0;i<level.MeleeNames.size;i++){
                self addOpt(level.MeleeNames[i], ::GiveWeaponToPlayer, level.Melee[i], self);
            }
            break;
        case "Specialist Weapons":
            self addMenu(level.WeaponCategories[9], "Specialist Weapons");
                for(i=0;i<level.SpecialNames.size;i++){
                    self addOpt(level.SpecialNames[i], ::GiveWeaponToPlayer, level.Specials[i], self);
                }
            break;
        case "Map Specific Weapons":
            self addMenu(level.WeaponCategories[10], "Map Specific Weapons");
                if(level.mapName == "cp_zmb"){
                    for(i=0;i<level.SpacelandNames.size;i++){
                        self addOpt(level.SpacelandNames[i], ::GiveWeaponToPlayer, level.SpacelandWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_rave"){
                    for(i=0;i<level.RaveNames.size;i++){
                        self addOpt(level.RaveNames[i], ::GiveWeaponToPlayer, level.RaveWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_disco"){
                    for(i=0;i<level.ShaolinNames.size;i++){
                        self addOpt(level.ShaolinNames[i], ::GiveWeaponToPlayer, level.ShaolinWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_town"){
                    for(i=0;i<level.AttackNames.size;i++){
                        self addOpt(level.AttackNames[i], ::GiveWeaponToPlayer, level.AttackWeaps[i], self);
                    }
                }
                else if(level.mapName == "cp_final")
                {
                    for(i=0;i<level.BeastNames.size;i++){
                        self addOpt(level.BeastNames[i], ::GiveWeaponToPlayer, level.BeastWeaps[i], self);
                    }
                }
            break;
        case "Other Weapons":
            self addMenu(level.WeaponCategories[11], "Other Weapons");
                for(i=0;i<level.OtherNames.size;i++){
                    self addOpt(level.OtherNames[i], ::GiveWeaponToPlayer, level.otherWeaps[i], self);
                }
            break;
        case "Powerup Loot":
            self addMenu("Powerup Loot", "Powerup Loot");
                for(p=0;p<level.pickupPowers.size;p++)//transponder doesnt like inf ammo
                    self addOpt(level.pickupPowerNames[p], ::givepillagedloot, level.pickupPowers[p]);
        break;
    }
}