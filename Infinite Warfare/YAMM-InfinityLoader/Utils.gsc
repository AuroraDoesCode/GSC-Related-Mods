/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : TheUnknownCod3r
*    Game : Call of Duty: Infinite Warfare
*    Description : Custom Utils for YetAnotherModMenu
*    Date : 19/09/2025 03:01:41
*
*/
GetTehMap()
{
    if(level.script == "cp_zmb") {return "Zombies in Spaceland";}
    if(level.script == "cp_rave") {return "Rave in the Redwoods";}
    if(level.script == "cp_disco") {return "Shaolin Shuffle";}
    if(level.script == "cp_town") {return "Radioactive Thing";}
    if(level.script == "cp_final") {return "Beast from Beyond";}
}

test()
{
    
    self iPrintLnAlt("Testing");
}

PrintMenuControls()
{
    self endon("disconnect");
    self endon("game_ended");
    info = [];
    info[0]="YetAnotherModMenu IW Edition";
    info[1] = "Press [{+speed_throw}] & [{+melee}] To Open";
    info[2] = "Press [{+speed_throw}] & [{+attack}] to Scroll";
    info[3] = "Press [{+activate}] to Select, [{+melee}] to Go Back";
    info[4] = "For Rank Sliders, Use [{+smoke}] and [{+frag}] To Scroll";
    for(;;)
    {
        for(i=0;i<5;i++)
        {
            self iPrintLnAlt(info[i]);
            wait 5;
        }
        wait .2;
    }
}

iPrintLnAlt(String, String2 = "")
{
    if (!isDefined(self.printMsgs))
        self.printMsgs = [];

    // If already 5 messages, remove the oldest
    if (self.printMsgs.size >= 5)
    {
    oldest = self.printMsgs[self.printMsgs.size - 1];
    if (isDefined(oldest))
        oldest destroy();

        // Rebuild without the oldest message
    newArr = [];
    for (i = 0; i < self.printMsgs.size - 1; i++)
        newArr[i] = self.printMsgs[i];

    self.printMsgs = newArr;
    }

    if(String2 != "")     newMsg       = self createText("objective", 1, "LEFT", "BOTTOM", -420, -185, 3, 0, String+" "+String2, (1, 1, 1));
    else newMsg  = self createText("objective", 1, "LEFT", "BOTTOM", -420, -185, 3, 0, String, (1, 1, 1));
    newMsg.alpha = 1;
    newArr       = [];
    newArr[0] = newMsg;
    for (i = 0; i < self.printMsgs.size; i++)
        newArr[i + 1] = self.printMsgs[i];

    self.printMsgs = newArr;

    // Push each message up when new ones come in
    for (i = 0; i < self.printMsgs.size; i++)
    {
        self.printMsgs[i].y = -125 - (i * 20);
    }

    // fade in 4s
    newMsg thread hudfade(0, 4);

    // Fade and remove
    newMsg thread removeAfterFade(self);
}

removeAfterFade(player)
{
    wait 4;
    if (isDefined(self))
    {
        self destroy();
        player.printMsgs = iPrintRemove(player.printMsgs, self);
    }
}

iPrintRemove(arr, elem)
{
    newArr = [];
    for (i = 0; i < arr.size; i++)
        if (arr[i] != elem)
            newArr[newArr.size] = arr[i];
    return newArr;
}


setTextWrapper(text) overrides setText
{
    //you can do overflow checking in here
    self setSafeText(text);
}