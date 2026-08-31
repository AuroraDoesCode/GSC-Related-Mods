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
	foreach(player in level.players) player playlocalsound("ghosts_quest_step_notify");
    self lib_0D59::use_activate_gns_machine("activate_gns_machine");
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

CombineArrays(array1,array2,array3,array4)
{
    FinalArray = [];
    if(isdefined(array1))
    {
        foreach(item in array1)
        {
            FinalArray[FinalArray.size] = item;
        }
    }

    if(isdefined(array2))
    {
        foreach(item in array2)
        {
            FinalArray[FinalArray.size] = item;
        }
    }

    if(isdefined(array3))
    {
        foreach(item in array3)
        {
            FinalArray[FinalArray.size] = item;
        }
    }

    if(isdefined(array4))
    {
        foreach(item in array4)
        {
            FinalArray[FinalArray.size] = item;
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
		//peepshow token
		case 1: 
            token = getent("peepshow_token","targetname");
            level.peepshow_token_found = 1;
            enterStall = scripts\common\utility::getstruct("enter_stall","script_noteworthy");
            enterStall.script_noteworthy = "enter_stall_allowed";
            self thread scripts\cp\_vo::try_to_play_vo("pap_quest_collect_coin","disco_comment_vo","low",10,0,2,0,40);
            token delete();
            level scripts\cp\_utility::set_quest_icon(10);
        break;
		//film reel
		case 2:
        level.peepshow_reel_found = 1;
         scripts\cp\_interaction::add_to_current_interaction_list(level.booth_projector_struct);
          level.interactions["add_reel"].disable_guided_interactions = undefined;
           level scripts\cp\_utility::set_quest_icon(12);
            scripts\cp\_interaction::remove_from_current_interaction_list("pickup_reel");
        break;
		//flyer
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
		//beat the cages
		case 4: 
        scripts\common\utility::flag_set("skq_p2t1_1");
        level scripts\cp\_utility::set_quest_icon(14);
         scripts\common\utility::flag_set("skq_p2t1_2");
          level notify("cage_win");
        break;
		//locker and graffiti
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
		//trigger phone booth
		case 6:
            var_02 = scripts\common\utility::getstructarray("phonebooth","script_noteworthy");
            level.phone_puzzle_phone = var_02[var_02.size - 1];
            thread payphone_ringing(level.phone_puzzle_phone);
            scripts\common\utility::flag_set("skq_p2t2_1");
            scripts\common\utility::flag_set("skq_p2t2_2");
            scripts\common\utility::flag_set("skq_p2t2_3");
        break;
		//grab poster
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

rk_symbol_handler(arg1,flag)
{
	level endon("game_ended");
	var_02 = scripts\common\utility::getstruct(arg1,"targetname");
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
	scripts\common\utility::flag_set(flag);
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

/*
Attack of The Radioactive Thing
*/

//Utilities
set_quest_omnvar_by_targetname(player)//required for Attack EE Step
{
	partId = 0;
	switch(player.var_336)
	{
		case "mpq_zom_head_part":
			partId = 1;
			break;

		case "mpq_zom_torso_part":
			partId = 6;
			break;

		case "mpq_zom_l_arm_part":
			partId = 2;
			break;

		case "mpq_zom_r_arm_part":
			partId = 3;
			break;

		case "mpq_zom_l_leg_part":
			partId = 4;
			break;

		case "mpq_zom_r_leg_part":
			var_01 = 5;
			break;

		case "mpq_punch_card":
			partId = 10;
			break;

		case "car_mirror_ground":
		case "mirror":
			partId = 7;
			break;

		case "elvira_mirror":
			partId = 8;
			break;

		case "bathroom_mirror_piece":
			var_01 = 9;
			break;
	}

	if(var_01 > 0)
	{
		scripts\cp\_utility::set_quest_icon(var_01);
	}
}

take_bomb_part(player,param_01)
{
	var_02 = getent(player.target,"targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	switch(var_02.model)
	{
		case "cp_town_teleporter_device_projector":
	
			scripts\cp\_utility::set_quest_icon(16);
			break;

		case "cp_town_teleporter_device_pipes":
			scripts\cp\_utility::set_quest_icon(17);
			break;

		default:
			scripts\cp\_utility::set_quest_icon(18);
			break;
	}

	playfx(level._effect["generic_pickup"],var_02.origin);
	param_01 playlocalsound("zmb_item_pickup");
	level.teleporter_pieces_found++;
	var_02 delete();
}

spawn_garage_key(player)//Required for Attack EE
{
	level.key_fx = spawnfx(level._effect["locker_key"],self.origin + (0,0,32));
	wait(0.2);
	triggerfx(level.key_fx);
}

//ee steps
AttackEESteps(step)
{
	switch(step)
	{
		//grab body parts
		case 1:
			foreach(bodypart in level.mpq_zom_body_parts)
			{
				set_quest_omnvar_by_targetname(bodypart);
				self scripts\cp\_utility::set_quest_icon(bodypart);//set quest icon flags
				bodypart hide();
				wait(0.1);
			}

			level.leg_knocked_down = 1;
			var_03 = getent("mpq_zom_l_leg_part_ground","targetname");
			if(isdefined(var_03))
			{
				var_03 hide();
			}
			for(i=1;i<7;i++) self scripts\cp\_utility::set_quest_icon(i);//set quest icon flags
			level.mpq_zom_parts_picked_up["head"] = 1;
			level.mpq_zom_parts_picked_up["torso"] = 1;
			level.mpq_zom_parts_picked_up["left_arm"] = 1;
			level.mpq_zom_parts_picked_up["right_arm"] = 1;
			level.mpq_zom_parts_picked_up["left_leg"] = 1;
			level.mpq_zom_parts_picked_up["right_leg"] = 1;
			level.mpq_zom_parts_index = level.mpq_zom_parts_picked_up.size;
			break;
		//grab punch card
		case 2:
			punchCard = getent("mpq_punch_card","targetname");
			punchCard hide();
			set_quest_omnvar_by_targetname("mpq_punch_card");
			self scripts\cp\_utility::set_quest_icon("mpq_punch_card");//set quest icon flags
			level.punch_card_acquired = 1;
			break;
		//mirrors and additionals
		case 3:
			var_00 = getent("elvira_mirror","targetname");
			var_00 hide();
			level.mirrors_picked_up["elvira_mirror"] = 1;
			set_quest_omnvar_by_targetname(var_00);
			self scripts\cp\_utility::set_quest_icon(var_00);//set quest icon flags
			var_00 = getent("car_mirror","targetname");
			var_00 hide();
			var_00 = getent("car_mirror_ground","targetname");
			var_00 hide();
			level.mirrors_picked_up["car_mirror_ground"] = 1;
			set_quest_omnvar_by_targetname(var_00);
			self scripts\cp\_utility::set_quest_icon(var_00);//set quest icon flags
			var_00 = getent("bathroom_mirror_piece","targetname");
			var_00 hide();
			level.mirrors_picked_up["bathroom_mirror_piece"] = 1;
			set_quest_omnvar_by_targetname(var_00);
			self scripts\cp\_utility::set_quest_icon(var_00);//set quest icon flags
			var_01 = scripts\common\utility::getstructarray("mirror_placement","script_noteworthy");
			foreach(var_03 in var_01)
			{
				var_04 = scripts\common\utility::getstruct(var_03.target,"targetname");
				var_00 = spawn("script_model",var_04.origin);
				var_00.angles = var_04.angles;
				var_00 setmodel(var_04.script_noteworthy);
			}

			level.mirrors_placed["car_mirror"] = 1;
			level.mirrors_placed["bathroom_mirror"] = 1;
			level.mirrors_placed["elvira_mirror"] = 1;
			for(i=8;i<11;i++) self scripts\cp\_utility::set_quest_icon(i);//set quest icon flags
			break;
		//Create the Zombie
		case 4:
			foreach(var_01 in level.mpq_zom_parts)
			{
				var_01 hide();
			}

			level.knife_throw_target_body show();
			level.body_made = 1;
			level.terminal_unlocked = 1;
			self scripts\cp\_utility::set_quest_icon(12);//set quest icon flags
			break;
		//reverse Polarity for Ray Gun
		case 5: 
			level.polarity_reversed = 1;
			self scripts\cp\_utility::set_quest_icon(13);//set quest icon flags
		break;
		//Kill zombie and Spawn Key
		case 6: 
			level.knife_throw_target_body hide();
			spawn_garage_key(self.origin);
			level.key_spawned = 1;
			level scripts\cp\_utility::set_completed_quest_mark(1);//set quest icon flags
            level.garage_key_found=1;
			self scripts\cp\_utility::set_quest_icon(14);//set quest icon flags
			self scripts\cp\_utility::set_quest_icon(15);//set quest icon flags
		break;
		//grab Bomb parts & finish Chemistry
		case 7: 
        	thread take_bomb_part("bomb_teleport_part", undefined); 
			scripts\common\utility::flag_set("chemistry_step1");
			scripts\common\utility::flag_set("chemistry_step2");
			scripts\common\utility::flag_set("chemistry_step3");
			scripts\common\utility::flag_set("chemistry_step4");
		break;
		//Bomb launch codes
		case 8: 
			scripts\common\utility::flag_set("launchcode_step1");
			scripts\common\utility::flag_set("launchcode_step2");
			self scripts\cp\_utility::set_quest_icon(20);//set quest icon flags
		break;
		//place bomb parts
		case 9: 
			scripts\common\utility::flag_set("launchcode_step3");
			level.teleporter_pieces_placed = 3;
			level.teleporter_pieces_found = 3;
			scripts\cp\_utility::set_quest_icon(16);//set quest icon flags
			scripts\cp\_utility::set_quest_icon(17);//set quest icon flags
			scripts\cp\_utility::set_quest_icon(18);//set quest icon flags
			scripts\cp\_utility::set_quest_icon(19);//set quest icon flags
			scripts\common\utility::flag_set("launchcode_step3");
		break;
		//charge bomb for boss teleport
		case 10:
			var_01 = scripts\common\utility::getstruct("place_bomb_parts","script_noteworthy");
			var_02 = getent(var_01.target,"targetname");
			playfxontag(level._effect["vfx_bomb_portal_charged"],var_02,"tag_bomb");
			scripts\cp\_interaction::add_to_current_interaction_list(Var_02);
			scripts\common\utility::flag_set("teleporter_charged");
			scripts\common\utility::flag_set("teleporter_charged");
		break;
		//Final Teleport Setup
    	case 11:
			var_00 = scripts\common\utility::getstruct("place_bomb_parts","script_noteworthy");
			var_01 = getent(var_00.target,"targetname");
			playfx(level._effect["vfx_bomb_portal_out"],var_01.origin);
			var_01 delete();
			scripts\common\utility::flag_set("launchcode_step4");
    	break;
		//Kill Radioactive thing
    	case 12: 
    		level.bomb_detonation_attempts=1;
			level notify("nuclear_bomb_armed");
    		end_detonate_bomb();
			foreach(player in level.players)
			{
      			player setplayerdata("cp","haveSoulKeys","soul_key_4",1);
    			player setplayerdata("cp","haveItems","item_4",1);
				player iPrintLnAlt("You Just Completed The Attack Easter Egg!");
				player iPrintLnAlt("You have been Awarded The Soul Key AND Talisman!");
			}
    	break;
	}
	self iPrintLnAlt("Completed EE Step " +step);
}

AttackOpenSesame()
{
	var_00 = scripts\common\utility::getstructarray("missing_handle","script_noteworthy");
	scripts\cp\_interaction::remove_from_current_interaction_list(var_00);
	scripts\common\utility::flag_set("found_missing_handle");
	self playlocalsound("part_pickup");
	var_00.model delete();
	self givetrapparticon("lever");
	scripts\common\utility::flag_set("placed_missing_handle");
	wait(1);
	level notify("found_power");
	level notify("activate_power");
	wait 1;
	self thread usebrokengenerator();
}

usebrokengenerator()
{
		handle = "missing_handle";
		scripts\cp\_interaction::remove_from_current_interaction_list(handle);
		handle.fixed = 1;
		self playlocalsound("part_pickup");
		var_02 = scripts\common\utility::getstruct(handle.target,"targetname");
		var_03 = spawn("script_model",var_02.origin);
		if(isdefined(var_02.angles))
		{
			var_03.angles = var_02.angles;
		}

		var_03 setmodel("icbm_electricpanel_switch_02");
		var_03.script_noteworthy = var_02.script_noteworthy;
		var_03.script_parameters = var_02.script_parameters;
		handle.handle = var_03;
		handle.handle.script_noteworthy = "-pitch";
		scripts\common\utility::flag_set("placed_missing_handle");
		level notify("found_power");
		wait(1);
		var_05 = getent("box","script_noteworthy");
		var_05 setmodel("icbm_electricpanel9_on");
		taketrapparticon("lever");
		setomnvar("zm_ui_color_eye_ent",level.color_eye);

		foreach(generator in level.var_773B)//foreach(generator in level.generators)
        {
            thread lib_0D51::func_7757(generator, self);//func_7757 = generic_generator(generator, self);//self for the flare gesture
            wait(0.1);
        }

		scripts\engine\utility::flag_set("power_on");
		level notify("found_power");
		setomnvar("zm_ui_color_eye_ent",level.color_eye);
		if(isdefined(level.fast_travel_spots))
		{
			foreach(portal in level.fast_travel_spots)
			{
				 portal.activated = 1;//isPortalActive
                 portal.var_13068 = 1;//used portal to PAP
                 if(isDefined(portal.var_C626)) 
                    portal.var_C626 = 0;
			}
		}

		var_07 = getentarray("door_buy","targetname");
		foreach(var_09 in var_07)
		{
			var_09 notify("trigger","open_sesame");
			wait(0.1);
		}

		var_0B = getentarray("chi_door","targetname");
		foreach(var_09 in var_0B)
		{
			var_09.var_289 notify("damage",undefined,"open_sesame");
			wait(0.1);
		}

		level.moon_donations = 3;
		level.kepler_donations = 3;
		level.triton_donations = 3;
		if(isDefined(level.team_killdoors))
        {
        foreach(teamDoor in level.team_killdoors)
        {
            teamDoor thread lib_0D4C::open_team_killdoor(level.players[0]);
        }
        }

		doorInteracts = scripts\common\utility::getstructarray("interaction","targetname");
    foreach(interact in doorInteracts)
    {
        doorTrigger = scripts\common\utility::getstructarray(interact.script_noteworthy,"script_noteworthy");
        foreach(trigger in doorTrigger)
        {
            if(isDefined(trigger.target) && isDefined(interact.trigger))
            {
                if(trigger.target == interact.target && trigger != interact)
                {
                    if(scripts\common\utility::func_2286(doorInteracts,trigger))
                    {
                        doorInteracts = scripts\common\utility::func_22A9(doorInteracts,trigger);
                    }
                }
            }
        }
        if(scripts\cp\_interaction::func_9A18(interact))
        {
            if(!isDefined(interact.script_noteworthy))
            {
                continue;
            }
            if(interact.script_noteworthy == "team_door_switch")
            {
                scripts\cp\zombies\interaction_openareas::func_1302F(interact,level.players[0]);
            }
        }
    }
}

spawn_film_reel_hints()
{
	filmreel = spawn("script_model",self.origin);
	wait(0.1);
	filmreel setmodel("cp_town_film_reel_case");
}
taketrapparticon(trapname)
{
	trapId = 0;
	switch(trapname)
	{
		case "electric":
			trapId = 6;
			break;

		case "propane":
			trapId = 8;
			break;

		case "freeze":
			trapId = 7;
			break;

		case "pool":
			trapId = 5;
			break;

		case "lever":
			trapId = 9;
			break;

		default:
			break;
	}

	if(trapId > 0)
	{
		foreach(player in level.players)
		{
			player setclientomnvarbit("zm_charms_active",trapId,0);
		}
	}
}

//Function Number: 50
givetrapparticon(trapname)
{
	trapId = 0;
	switch(trapname)
	{
		case "electric":
			trapId = 6;
			break;

		case "propane":
			trapId = 8;
			break;

		case "freeze":
			trapId = 7;
			break;

		case "pool":
			trapId = 5;
			break;

		case "lever":
			trapId = 9;
			break;

		default:
			break;
	}

	foreach(player in level.players)
	{
		player setclientomnvarbit("zm_charms_active",trapId,1);
	}
}


end_detonate_bomb()
{
	level thread crab_boss_death_sequence();
	level notify("end_detonate_bomb");
}

//Function Number: 14
crab_boss_death_sequence()
{
	scripts\common\utility::func_6E2A("boss_fight_active");
	scripts\common\utility::flag_set("boss_fight_finished");
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		level.crab_boss.nocorpse = 1;
		level.crab_boss suicide();
		level thread scripts\cp\zombies\direct_boss_fight::success_sequence(5,4);
		return;
	}

	if(isdefined(level.crab_boss))
	{
		level thread crab_boss_death_anim_sequence(level.crab_boss);
	}

	scripts\cp\maps\cp_town\cp_town_crab_boss_fight::move_lost_and_found("tent");
	level.force_respawn_location = undefined;
	level.disable_loot_fly_to_player = 0;
	level.loot_time_out = undefined;
	level.var_13BD6 = undefined;
	level notify("crab_boss_fight_complete");
	level thread clear_existing_enemies();
	level thread delay_resume_wave_progression();
	level.defeated_crogboss=1;
    foreach(var_01 in level.players)
	{
		var_01 scripts\cp\_merits::func_D9AD("mt_dlc3_boss_killed");
		var_01 setplayerdata("cp","haveSoulKeys","any_soul_key",1);
		var_01 setplayerdata("cp","haveSoulKeys","soul_key_4",1);
		var_01 lib_0D2A::func_12D7C("SOUL_LESS",1);
		if(!var_01 scripts\cp\_utility::isteleportenabled())
		{
			var_01 scripts\cp\_utility::allow_player_teleport(1);
		}

		if(var_01.var_134FD == "p5_")
		{
			var_01 lib_0D2A::func_12D7C("UNPLEASANT_DREAMS",1);
		}
	}

	level scripts\cp\_utility::set_completed_quest_mark(4);
}

crab_boss_death_anim_sequence(param_00)
{
	level endon("game_ended");
	if(isalive(param_00))
	{
		param_00 scripts\aitypes\crab_boss\behaviors::dodeath(1);
		param_00.nocorpse = 1;
		param_00 suicide();
	}

	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
	level.crab_boss = undefined;
}

delay_resume_wave_progression()
{
	level endon("game_ended");
	wait(71.15);
	resume_spawn_wave();
}

//Function Number: 18
resume_spawn_wave()
{
	level.dont_resume_wave_after_solo_afterlife = undefined;
	level.var_13FA3 = 0;
	scripts\common\utility::func_6E2A("pause_wave_progression");
}

clear_existing_enemies()
{
	foreach(var_01 in level.spawned_enemies)
	{
		var_01.var_54CB = 1;
		var_01.nocorpse = 1;
		var_01 suicide();
	}

	scripts\common\utility::func_136F7();
}
StartBossFight()
{
	self thread cleardoorsanddebris();
	self thread TurnOnPower();
	level notify("start_direct_boss_fight");
	scripts\common\utility::flag_set("boss_fight_active");
	if(isdefined(level.setup_direct_boss_fight_func))
	{
		level thread [[ level.setup_direct_boss_fight_func ]]();
	}
	wait 1;
	if(isdefined(level.start_direct_boss_fight_func))
	{
		level thread [[ level.start_direct_boss_fight_func ]]();
	}
}

PickupElvirasBook()//bookItem, self
{
	scripts\cp\_interaction::remove_from_current_interaction_list(level.elvira_spellbook);
	scripts\common\utility::flag_set("spellbook_found");
	var_02 = getent(level.elvira_spellbook.target,"targetname");
	self playlocalsound("part_pickup");
	playfx(level._effect["generic_pickup"],var_02.origin);
	var_02 delete();
	scripts\cp\_utility::set_quest_icon(19);
}
placeElvirasBook()
{
	scripts\common\utility::flag_set("spellbook_placed");
	self playlocalsound("zmb_coin_sounvenir_place");
	playfx(level._effect["vfx_cp_town_book_place"],level.elvira_spellbook.origin + (0,0,10),anglestoforward(level.elvira_spellbook.angles),anglestoup(level.elvira_spellbook.angles));
	wait(0.45);
	level.elvira_spellbook show();
	playfx(level._effect["vfx_cp_town_book_idle"],level.elvira_spellbook.origin + (0,0,10),anglestoforward(level.elvira_spellbook.angles),anglestoup(level.elvira_spellbook.angles));
}
TakePages()
{
	page1 = getent("spellbook_page1", "targetname");
	page2 = getent("spellbook_page2", "targetname");
	self takespellbookpage(page1, self);
	self takespellbookpage(page2, self);
}
takespellbookpage(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	scripts\common\utility::flag_set("spellbook_page1_found");
	var_02 = getent(param_00.target,"targetname");
	param_01 playlocalsound("part_pickup");
	playfx(level._effect["generic_pickup"],var_02.origin);
	var_02 delete();
	scripts\cp\_utility::set_quest_icon(21);
	scripts\cp\_utility::set_quest_icon(22);
}
FillVial()
{

	scripts\cp\_utility::set_quest_icon(23);
	scripts\cp\_utility::set_quest_icon(24);
	scripts\common\utility::func_6E2A("vial_filled");
	setomnvar("zom_general_fill_percent_2",0);
	scripts\common\utility::flag_set("vial_filled");
}
summonElvira()
{
	level.elvira_ai = undefined;
	if(!isdefined(level.elvira_spawn_struct))
	{
		elviraModel = spawnstruct();
		elviraModel.origin = self.origin;
		elviraModel.angles = (0,180,0);
	}
	else
	{
		elviraModel = level.elvira_spawn_struct;
	}

	for(;;)
	{
		level.elvira_ai = scripts\cp\zombies\zombies_spawning::func_33B1("elvira",elviraModel.origin,elviraModel.angles,"allies",undefined,"iw7_erad_zm");
		if(!isdefined(level.elvira_ai))
		{
			wait(0.2);
			continue;
		}
		else
		{
			break;
		}
	}
		level.elvira_ai.var_1491.var_E5DE = 5;
		level.elvira_ai.health = 100000;
		level.elvira_ai.maxhealth = 100000;
		level.elvira_ai setcandamage(0);
		level.elvira_ai.allowpain = 0;
		level.elvira_ai.ignoreme = 1;
		level.elvira_ai.var_3842 = 1;
		level.elvira_ai.var_FFEF = 1;
		playfx(level._effect["elvira_stand_smoke"],level.elvira_ai.origin);
		playsoundatpos(level.elvira_ai.origin,"town_elvira_appear");
		level scripts\cp\_utility::set_completed_quest_mark(2);
}

summonTheHoff()//needs fixed, he spawns but sits in air
{
	level.var_A6E1 = 1;
	level.the_hoff = undefined;
	while(!isdefined(level.the_hoff)) {
		level.the_hoff = scripts\cp\zombies\zombies_spawning::func_33B1("the_hoff",self.origin,self.angles,"allies",undefined,"iw7_erad_zm");
		if(!isdefined(level.the_hoff)) {
			wait(0.2);
			continue;
		}
	}
	level.the_hoff.var_1491.var_E5DE = 5;
	level.the_hoff.health = 100000;
	level.the_hoff.maxhealth = 100000;
	level.the_hoff setcandamage(0);
	level.the_hoff method_83B7();
	level.the_hoff.allowpain = 0;
	level.the_hoff.ignoreme = 1;
	level.the_hoff.var_3842 = 1;
	level.the_hoff.var_FFEF = 1;
	level.the_hoff.var_180 = 0;
	level.the_hoff.var_EF64 = 0;
}