/*
*    Infinity Loader :: The Best GSC IDE!
*
*    Project : YAMM-InfinityLoader
*    Author : TheUnknownCod3r
*    Game : Call of Duty: Infinite Warfare
*    Description : Map Specific Opts for IW
*    Date : 21/09/2025 18:00:18
*
*/

PlayAudioToClients(audioFile)
{
    foreach(player in level.players)
    {
        if(level.script == "cp_zmb")
        { 
            level thread [[level.force_song_func]](undefined,audioFile,undefined,undefined,undefined,undefined); 
        }
        else{
            level thread scripts\cp\zombies\zombie_jukebox::force_song((649,683,254),audioFile);
        }
    }
}

CompleteGnS()
{
    self lib_0D59::use_activate_gns_machine("activate_gns_machine");
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(6);//notifyactivationprogress
}



GetNeilPart(partNum)
{
    switch(partNum)
    {
        case 0 : self playlocalsound("neil_part_pickup"); scripts\cp\_interaction::remove_from_current_interaction_list(level.var_BEC5);level.var_BEC5.var_BEC5 delete();level.var_BEC7 = 1;level scripts\cp\_utility::set_quest_icon(7); break;
        case 1 : self playLocalSound("neil_part_pickup"); playfx(level._effect["souvenir_pickup"],level.var_BEAE.part.origin);scripts\cp\_interaction::remove_from_current_interaction_list(level.var_BEAE);level.var_BEAE.part delete();level.var_BEB0 = 1; level scripts\cp\_utility::set_quest_icon(8); break;
        case 2 : self playlocalsound("neil_part_pickup");playfx(level._effect["souvenir_pickup"],level.var_BEC1.part.origin);scripts\cp\_interaction::remove_from_current_interaction_list(level.var_BEC1);level.var_BEC1.part delete();level.var_BEC3 = 1;level scripts\cp\_utility::set_quest_icon(9); break;
    }
}


GetThoseSpeakers()
{
    if(isdefined(level.current_speaker))
    {
        level.current_speaker = undefined;
    }

    foreach(var_04 in level.players)
    {
        var_04 notify("speaker_defense_completed");
        level notify("speaker_defense_completed");
    }
    scripts\common\utility::flag_set("dj_request_defense_done");
    foreach(var_01 in level.players)
    {
        var_01 setclientomnvar("zm_special_item",5);
    }
    scripts\common\utility::flag_set("tone_generators_given");
}

beast_open_sesame() 
{ //credit syndishanx, I was lazy.
    scripts\common\utility::flag_set("neil_head_found");
    scripts\common\utility::flag_set("neil_head_placed");
    scripts\common\utility::flag_set("restorepower_step1");
    scripts\common\utility::flag_set("power_on");
    level notify("power_on");
    
    level scripts\cp\_utility::set_quest_icon(6);
    var_00 = scripts\common\utility::getstructarray("neil_head","script_noteworthy");
    foreach(var_02 in var_00) {
        if(isDefined(var_02.var_8C98)) {
            var_02.var_8C98 delete();
        }
    }
    
    foreach(door in level.allslidingdoors) {
        door.player_opened = 1;
        thread [[level.interactions[door.script_noteworthy].activation_func]](door,undefined);
    }
}

CombineArrays(param_00,param_01,param_02,param_03)
{
    var_04 = [];
    if(isdefined(param_00))
    {
        foreach(var_06 in param_00)
        {
            var_04[var_04.size] = var_06;
        }
    }

    if(isdefined(param_01))
    {
        foreach(var_06 in param_01)
        {
            var_04[var_04.size] = var_06;
        }
    }

    if(isdefined(param_02))
    {
        foreach(var_06 in param_02)
        {
            var_04[var_04.size] = var_06;
        }
    }

    if(isdefined(param_03))
    {
        foreach(var_06 in param_03)
        {
            var_04[var_04.size] = var_06;
        }
    }
}



GrabSetiComParts()
{
    self pick_up_djquest_part("dj_quest_part_1","zmb_frequency_device_radio");
    self pick_up_djquest_part("dj_quest_part_2","zmb_frequency_device_calculator");
    self pick_up_djquest_part("dj_quest_part_3","zmb_frequency_device_umbrella_ground");
}

GrabTheSeticom()
{
    scripts\common\utility::flag_set("dj_request_defense_done");    
    scripts\common\utility::flag_set("defend_sequence");
    foreach(player in level.players)
    {
        player setclientomnvar("zm_special_item",3);
    }
}

pick_up_djquest_part(tagName,quest_part)
{

    scripts\common\utility::flag_set("dj_fetch_quest_completed");
    iconId = 0;
    if(tagName == "dj_quest_part_3") iconId = 24;
    else if(tagName == "dj_quest_part_2") iconId = 23; 
    else if(tagName == "dj_quest_part_1") iconId = 22; 

    playfx(level._effect["souvenir_pickup"],tagName.part_model.origin);
    quest_part playlocalsound("part_pickup");
    thread scripts\cp\zombies\zombie_analytics::func_AF6F(level.wave_num,tagName.groupname,tagName.part_model.model);
    tagName.part_model delete();
    level scripts\cp\_utility::set_quest_icon(iconId);
}

GiveTickets(Amount)
{
    self scripts\cp\zombies\arcade_game_utility::func_8317(self, Amount);
    self iPrintLnAlt("Awarded ^1"+amount+" Tickets");
}   

//shaolin Stuff

mahjong_win_sequence(param_00)
{
    clear_outline_for_all_players(param_00);
    wait(0.5);
    var_01 = spawn("script_model",param_00.origin);
    var_01 setmodel("sb_quest_origin");
    var_01 setscriptablepartstate("vfx","fireworks_sparks");
    playsoundatpos(param_00.origin,"mahjong_success_fireworks");
    wait(3);
    var_01 delete();
    level notify("mahjong_won_sequence_complete");
}

clear_outline_for_all_players(player)
{
    foreach(client in level.players)
    {
        for(i = 1;i <= 14;i++)
        {
            player.mahjong_set[i].mahjong_tile hudoutlinedisableforclient(client);//engine call, safe as is
        }
    }
}

ShaolinEESteps(step)
{
	switch(step)
	{
		case 1: 
            token = getent("peepshow_token","targetname");
            level.peepshow_token_found = 1;
            enterStall = scripts\common\utility::getstruct("enter_stall","script_noteworthy");
            enterStall.script_noteworthy = "enter_stall_allowed";
            self thread scripts\cp\_vo::try_to_play_vo("pap_quest_collect_coin","disco_comment_vo","low",10,0,2,0,40);
            token delete();
            level scripts\cp\_utility::set_quest_icon(10);
        break;
		case 2:
        level.peepshow_reel_found = 1;
         scripts\cp\_interaction::add_to_current_interaction_list(level.booth_projector_struct);
          level.interactions["add_reel"].disable_guided_interactions = undefined;
           level scripts\cp\_utility::set_quest_icon(12);
            scripts\cp\_interaction::remove_from_current_interaction_list("pickup_reel");
        break;
		case 3:
         level.peepshow_flyer_found = 1;
          self thread scripts\cp\_vo::try_to_play_vo("pap_quest_collect_ticket","disco_comment_vo","low",10,0,2,0,40);
           level scripts\cp\_utility::set_quest_icon(11);
           level.peepshow_entrances = scripts\engine\utility::getstructarray("enter_peepshow","script_noteworthy");
           foreach(var_03 in level.peepshow_entrances)
           {
             var_03.script_noteworthy = "enter_peepshow_allowed";
             }
        break;
		case 4: 
        scripts\common\utility::flag_set("skq_p2t1_1");
        level scripts\cp\_utility::set_quest_icon(14);
         scripts\common\utility::flag_set("skq_p2t1_2");
          level notify("cage_win");
        break;
		case 5: 
        var_05 = scripts\common\utility::getstruct("locker_rortator_mpq","targetname");
         var_01 = getent("subway_locker_door","targetname");
          if(isdefined(var_05))
          {
            var_06 = scripts\common\utility::spawn_tag_origin(var_05.origin,var_05.angles);
            var_01 linkto(var_06);
            playsoundatpos(var_06.origin,"disco_locker_open");
            var_06 rotateyaw(120,2,1,0.5);
            wait(2);
            var_06 delete();
            }
            else
            {
                var_01 delete();
            }
            scripts\common\utility::flag_set("skq_p2t1_3");
            level notify("active_word_done");
            var_01 = getent("graffiti_quest_clip","targetname");
            var_02 = getent("graffiti_quest_fail_clip","targetname");
            var_03 = getent("graffiti_quest_clip_alt","targetname");
            thread rk_symbol_handler("rk_symbol_punk_streets","skq_p2t1_4");
            scripts\cp\_utility::deactivatebrushmodel(var_01,1);
            scripts\cp\_utility::deactivatebrushmodel(var_02,1);
            scripts\cp\_utility::deactivatebrushmodel(var_03,1);
        break;
		case 6:
            var_02 = scripts\common\utility::getstructarray("phonebooth","script_noteworthy");
            level.phone_puzzle_phone = var_02[var_02.size - 1];
            thread payphone_ringing(level.phone_puzzle_phone);
            scripts\common\utility::flag_set("skq_p2t2_1");
            scripts\common\utility::flag_set("skq_p2t2_2");
            scripts\common\utility::flag_set("skq_p2t2_3");
        break;
		case 7:
            var_02 = getentarray("mpq_poster_model","targetname");
            foreach(var_04 in var_02)
            {
                var_04 notify("correct_poster_got");
            }
            self.var_C211 delete();
            self delete();
            level scripts\cp\_utility::set_quest_icon(16);
            scripts\common\utility::flag_set("correct_poster_got");
            level.phone_puzzle_phone = undefined;
            scripts\common\utility::flag_set("skq_p2t2_4");
            scripts\common\utility::flag_set("skq_p2t2_5");
            foreach(var_11 in level.rooftopcypherglyphs)
            {
                if(isdefined(var_11))
                {
                    var_11 delete();
                }
            }
            level.rooftopcypherglyphs = undefined;
            thread rk_symbol_handler("rk_symbol_punk_rooftops","skq_p2t2_6");
        break;
	}
	self iPrintLnAlt("Completed Step "+step);
}

rk_symbol_handler(param_00,param_01)
{
	level endon("game_ended");
	var_02 = scripts\common\utility::getstruct(param_00,"targetname");
	var_03 = scripts\common\utility::spawn_tag_origin(var_02.origin,var_02.angles);
	var_03 makeusable();
	var_03 setusefov(45);
	var_03 setuserange(96);
	var_04 = scripts\common\utility::func_5D14(var_02.origin,30,-100);
	var_04 = var_04 + (0,0,1);
	var_05 = spawnfx(level._effect["test_glyph_mpq"],var_04,anglestoforward(var_02.angles),anglestoup(var_02.angles));
	triggerfx(var_05);
	foreach(player in level.players)
	{
		player playsoundtoplayer("quest_stage_completed_gong_lr",player);
	}

	var_03 setusefov(180);
	var_03 waittill("trigger");
	var_03 delete();
	var_05 delete();
	scripts\common\utility::flag_set(param_01);
}

payphone_ringing(param_00)
{
	level endon("game_ended");
	var_01 = spawn("script_model",param_00.origin + (0,0,50));
	var_01 setmodel("tag_origin");
	var_01 playloopsound("payphone_npc_ring");
	param_00 waittill("phone_answered",var_02);
	level.player_answered_phone = var_02;
	var_01 delete();
}