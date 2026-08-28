/*
*	 Infinity Loader :: When only the best will do
*
*	 Project : YAMM-Latest
*	 Author : AuroraDoesCode
*	 Game : Call of Duty: Infinite Warfare
*	 Description : Personal Menu Options
*	 Date : 27/08/2026 01:33:21
*
*/

CreatePersonalMenuOptions()
{
    switch(self getCurrentMenu())
    {
        case "Personal Modifications":
        self addMenu("Personal Modifications", "Personal Modifications");
            self addToggleOpt("Toggle God Mode", ::Godmode, self.godmode);
            self addToggleOpt("Toggle No Clip", ::no_clip, self.noclip);
            self addToggleOpt("Toggle Infinite Ammo", ::ToggleAmmo, self.UnlimAmmo);
            self addToggleOpt("Toggle Third Person", ::ThirdPerson, self.thirdPerson);
            self addOpt("Score Menu", ::newMenu, "Score Menu");
            self addOpt("Random Teleport", ::ActivateFAF, "anywhere_but_here", self);
            self addOpt("Give All Perks", ::AllPerks, self);
            self addSlider("Edit Movement Speed", 0,0,15,1,::EditSpeed);
            self addToggleOpt("Toggle Speed Change", ::SpeedToggle, self.speedToggle);
        break;
        case "Score Menu":
            self addMenu("Score Menu", "Score Menu");
            self addSlider("Add Score", self getplayerdata("cp","alienSession","currency"), 0, self.var_B48A, 1000, ::AddScore, undefined, undefined, self);
            self addSlider("Remove Score", self getplayerdata("cp","alienSession","currency"), 0, self.var_B48A, 1000, ::TakeScore, undefined, undefined, self);
            self addOpt("Max Out Score", ::MaxScore, self);
        break;
    }
}