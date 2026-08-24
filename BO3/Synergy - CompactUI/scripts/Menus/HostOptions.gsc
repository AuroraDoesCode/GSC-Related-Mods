SetupHostMenu()
{
    switch(self getCurrentMenu())
    {
        case "Host Options >":
        self addMenu("Host Options >", "Personal Modifications >");

        #ifdef ZM

        #endif
        #ifdef MP 

        #endif
        break;
    }
}