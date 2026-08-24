SetupPersonalMenu()
{
    switch(self getCurrentMenu())
    {
        case "Personal Modifications >":
        self addMenu("Personal Modifications >", "Personal Modifications >");
            self addToggleOpt("Toggle God Mode", ::Godmode, self.godmode);
            self addToggleOpt("Toggle Infinite Ammo", ::ToggleAmmo, self.UnlimAmmo);
            self addToggleOpt("Toggle Third Person", ::ThirdPersonToggle, self.ThirdPersonToggle);
            self addToggleOpt("Toggle All Perks", ::AllPerkToggle, self.HasAllPerks);
        #ifdef ZM
            self addToggleOpt("Toggle No Target", ::noTarget, self.ignoreme);
            self addOpt("Score Menu", ::newMenu, "Score Menu");
        #endif
        #ifdef MP 
            self addToggleOpt("Toggle Advanced UAV", ::toggleUAV, self.AdvancedUAV);
        #endif
        break;
        #ifdef ZM
        case "Score Menu":
            self addMenu("Score Menu", "Score Menu");
                self addOpt("Max Out Score", ::EditScore, 4194303, "Give", self);
                self addOpt("Take All Score", ::EditScore, 4194303, "Take", self);
                self addSlider("Add Score", self.score, 0, 4200000, 1000, ::EditScore, undefined, undefined, "Give", self);
                self addSlider("Take Score", self.score, 0, 4200000, 1000, ::EditScore, undefined, undefined, "Take", self);
            break;
        #endif
    }
}