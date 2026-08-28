/*
*	 Infinity Loader :: When only the best will do
*
*	 Project : YAMM-Latest
*	 Author : AuroraDoesCode
*	 Game : Call of Duty: Infinite Warfare
*	 Description : Options Holder for Menu Customisations
*	 Date : 28/08/2026 11:10:32
*
*/

CreateMenuCustomisationOptions()
{
    switch (self getCurrentMenu())
    {
        case "Menu Customisation":
            self addMenu("Menu Customisation", "Menu Customisation");
                self addOpt("Menu Colours", ::newMenu, "MenuColour");
                self addOpt("Change Theme To Physics N Flex", ::ChangeTheme, 1);
                self addOpt("Change Theme To Synergy V3", ::ChangeTheme, 0);
                self addOpt("Reposition Menu", ::MoveMenu);//probably don't need this now, but you know
            break;
        case "MenuColour":
            self addMenu("MenuColour", "Menu Colours");
                self addOpt("Background", ::newMenu, "BackgroundColour");
                self addOpt("Banner", ::newMenu, "BannerColour");
                self addOpt("Scroller", ::newMenu, "ScrollerColour");
            break;
        case "BackgroundColour":
            self addMenu("BackgroundColour", "Menu Background");
            for(e=0;e<3;e++){
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Background", true);
                }
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Background");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["BackgroundGradRainbow"]), "Background");
            break;
            
        case "BannerColour":
            self addMenu("BannerColour", "Menu Banner");
            for(e=0;e<3;e++){
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Banner", true);
                    }
                self addOptSlider("Colour Presets", GetColoursSlider(),::MenuPreSetCol, undefined, true, "Banner");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, bool(self.menuSetting["HUDEdit"]) ? IsString(self.menuSetting["BannerNoneRainbow"]) : IsString(self.menuSetting["BannerGradRainbow"]), "Banner");
            break;
            
        case "ScrollerColour":
            self addMenu("ScrollerColour", "Menu Scroller");
            for(e=0;e<3;e++){
                    self addSlider(level.RGB[e] + " Slider", 0, 0, 255, 10, ::MenuPreSetCol, undefined, true, "Scroller", true);
                    }
                self addOptSlider("Colour Presets", GetColoursSlider(), ::MenuPreSetCol, undefined, true, "Scroller");
                self addToggleOpt("Rainbow Fade", ::MenuToggleRainbow, IsString(self.menuSetting["ScrollerGradRainbow"]), "Scroller");
            break;
    }
}