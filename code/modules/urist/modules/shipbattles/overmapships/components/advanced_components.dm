//boarding
/datum/shipcomponents/teleporter
	name = "teleporter module"
	var/boarding_delay = 3 MINUTES //How long between boarding attempts?
	var/list/boarding_mobs = list(/mob/living/simple_animal/hostile/russian, /mob/living/simple_animal/hostile/russian/ranged) //What mobs do we spawn on boarding?
	var/boarding_number = 4 //We'll spawn this many every time we board.
	var/last_boarding = 0 //How long since we boarded last?
	var/boarding_turf = null//Where do we spawn our mobs?
	var/boarding_failure_chance = 0 //more shields = more chance of preventing teleportation.
	var/boarded_max = 3 //how many times do we board?
	var/boarded_amount = 0 //how many times have we boarded

/datum/shipcomponents/teleporter/DoActivate()
	if(mastership.boarding)
		return //they have better things to do than board the Nerva right now.

	if(last_boarding > world.time) //Are we too early?
		return

	if(boarded_amount >= boarded_max)
		return

	boarding_failure_chance = 0 //Zero this var out.

	for(var/obj/machinery/power/shield_generator/S in SSmachines.machinery) //Calculate our failure chance.
		if(S.z in GLOB.using_map.station_levels)
			if(S.running == SHIELD_RUNNING)
				boarding_failure_chance += 25 // four shield generators to TOTALLY block boarding.

	if(!boarding_turf) //Locate where we're boarding, give them a warning.
		var/obj/item/device/radio/beacon/active_beacon //what beacon are we locking onto?
		var/list/beacon_list = list()
		for(var/obj/item/device/radio/beacon/B in GLOB.listening_objects)
			if(B.z in GLOB.using_map.station_levels)
				beacon_list += B
		active_beacon = pick(beacon_list)
		boarding_turf = get_turf(active_beacon)
		var/area/boarding_area = get_area(active_beacon)
		GLOB.global_announcer.autosay("<b>Alert! Enemy teleporter locked on! Boarding imminient! Expected breach point: [boarding_area.name].</b>", "[GLOB.using_map.full_name] Automated Defence Computer", "Common")

	if(prob(boarding_failure_chance))
		for(var/obj/machinery/power/shield_generator/S in SSmachines.machinery) //Calculate our failure chance.
			if(S.z in GLOB.using_map.station_levels)
				S.current_energy -= S.max_energy * 0.15 //knock a little power off the shields, we're knocking at the damn door.
		GLOB.global_announcer.autosay("<b>Alert! Tachyon flux detected against shield membrane - shield instability likely.</b>", "[GLOB.using_map.full_name] Automated Defence Computer", "Engineering")
		return //Stop here, the boarding failed.

	//Let's handle boarding.
	var/list/things_in_range = orange(3, boarding_turf)
	var/list/turfs_in_range = list()
	for (var/turf/T in things_in_range)
		if(!istype(T, /turf/simulated/floor))
			continue
		turfs_in_range.Add(T)
	for(var/S = 1 to boarding_number)
		var/boarding_type = pick(boarding_mobs)
		var/spawnturf = pick(turfs_in_range)
		spawn(0.5 SECONDS)
			new boarding_type(spawnturf)
			playsound(spawnturf, 'sound/effects/teleport.ogg', 90, 1)
	if(prob(75))
		boarding_turf = null //pick somewhere new to board.

	boarded_amount++
	last_boarding = world.time + boarding_delay

//boarding modules
/datum/shipcomponents/teleporter/robotic
	name = "robotic boarding module"
	boarding_mobs = list(/mob/living/simple_animal/hostile/hivebot, /mob/living/simple_animal/hostile/hivebot/range, /mob/living/simple_animal/hostile/hivebot/strong, /mob/living/simple_animal/hostile/hivebot/tele)
	boarding_number = 8
	boarded_max = 5

/datum/shipcomponents/teleporter/alien
	name = "alien matter deconstructor/reconstructor"
	boarding_mobs = list(/mob/living/simple_animal/hostile/scom/lactera/light, /mob/living/simple_animal/hostile/scom/lactera/medium, /mob/living/simple_animal/hostile/scom/lactera/heavy)
	boarding_number= 5
	boarding_delay = 2.5 MINUTES
	boarded_max = 5

/datum/shipcomponents/teleporter/alien/small
	boarded_max = 3

/datum/shipcomponents/teleporter/pirate
	name = "pirate boarding teleporter"
	boarding_mobs = list(/mob/living/simple_animal/hostile/pirate, /mob/living/simple_animal/hostile/pirate/ranged)
	boarding_number = 5
	boarding_delay = 5 MINUTES
	boarded_max = 2

/datum/shipcomponents/teleporter/pirate/small
	name = "pirate boarding teleporter"
	boarding_mobs = list(/mob/living/simple_animal/hostile/pirate, /mob/living/simple_animal/hostile/pirate/ranged)
	boarding_number = 3
	boarding_delay = 4 MINUTES


//Shield Disruptors
/datum/shipcomponents/shield_disruptor
	name = "shield disruptor"
	var/disruption_amount = list(0.05, 0.35) // anywhere from 5% to 35%.
	var/disruption_delay = 2 MINUTES

/datum/shipcomponents/shield_disruptor/DoActivate()
	if(last_activation > world.time)
		return

	for(var/obj/machinery/power/shield_generator/S in SSmachines.machinery)
		if(S.z in GLOB.using_map.station_levels)
			if(S.running == SHIELD_RUNNING)
				S.current_energy -= S.max_energy * rand(disruption_amount[1], disruption_amount[2])
	GLOB.global_announcer.autosay("<b>Tachyonic energy surge detected, shields may fluxuate.</b>", "[GLOB.using_map.full_name] Automated Defence Computer", "Engineering")
	last_activation = world.time + disruption_delay

/datum/shipcomponents/shield_disruptor/overcharge //For when someone's shields are SERIOUSLY persistent.
	name = "overcharge disruptor"
	disruption_delay = 5 MINUTES
	var/first_activate //we don't want this to activate immediately when it's in combat.

/datum/shipcomponents/shield_disruptor/overcharge/DoActivate()
	if(last_activation > world.time)
		return

	if(!first_activate) //they have five minutes to win, or suffer terribly.
		GLOB.global_announcer.autosay("<b>Massive electromagnetic energy buildup detected in hostile [mastership.ship_category]! T - Five minutes until buildup is complete.</b>", "[GLOB.using_map.full_name] Automated Defence Computer", "Common")
		first_activate = 1
		last_activation = world.time + disruption_delay
		return
	//Warn them.
	GLOB.global_announcer.autosay("<b>Massive electromagnetic power surge detected! Brace for electromagnetic disruption, T-30 seconds.</b>", "[GLOB.using_map.full_name] Automated Defence Computer", "Common")

	spawn(30 SECONDS)
		for(var/obj/machinery/power/shield_generator/S in SSmachines.machinery)
			if(S.z in GLOB.using_map.station_levels)
				for(var/obj/effect/shield/SE in S.field_segments)
					var/EMP_turf = get_turf(SE)
					empulse(EMP_turf, 3.5, 7, 0)

	last_activation = world.time + disruption_delay

/datum/shipcomponents/shield_disruptor/heavy
	name = "heavy shield disruptor"
	disruption_amount= list(0.25, 0.55)
	disruption_delay = 1.5 MINUTES

//Repair Modules

/datum/shipcomponents/repair_module
	name = "repair module"
	var/repair_amount = 50 //how much HP we restore per activation.
	var/can_fix_broken = FALSE // can we repair broken modules?
	var/hull_repair_prob = 20 //chance of fixing some hull
	var/module_repair_prob = 40 //chace of fixing a bit of a module
	var/module_restore_prob = 10 //chance of totally repairing a module, if can_fix_broken is TRUE.
	var/repair_delay = 1 MINUTES //delay on repairing

/datum/shipcomponents/repair_module/DoActivate()
	var/did_repair //if it did a repair, activate cooldown, otherwise it gets another try on the next life() tick
	if(last_activation > world.time)
		return
	//hull repair stuffs
	if(prob(hull_repair_prob))
		if(mastership.health < mastership.maxHealth)
			var/mastership_after_repair = mastership.health + repair_amount
			if(mastership_after_repair > mastership.maxHealth) //don't want to exceed the health value
				var/new_rep_amount = Clamp(repair_amount, 0, mastership.maxHealth)
				mastership.health += new_rep_amount
				did_repair = TRUE
			else //if we good, just add a lump sum of health
				mastership.health += repair_amount
				did_repair = TRUE
	//module repair stuffs
	else if(prob(module_repair_prob))
		for(var/datum/shipcomponents/M in mastership.components)
			if(did_repair)
				break
			if(M.broken)
				continue
			var/mod_start_health = M.GetInitial(health)
			if(M.health < mod_start_health)
				var/module_after_repair = M.health + repair_amount
				if(module_after_repair > mod_start_health)
					var/new_mod_rep_amt = Clamp(repair_amount, 0, mod_start_health)
					M.health = new_mod_rep_amt
					did_repair = TRUE
				else
					M.health += repair_amount
					did_repair = TRUE

	//module restoration
	else if(can_fix_broken)
		if(prob(module_restore_prob))
			for(var/datum/shipcomponents/M in mastership.components)
				if(!M.broken)
					continue
				if(did_repair)
					break
				M.health = Clamp(repair_amount, 0, M.GetInitial(health)) //incase we're repairing more than a module has in terms of health
				M.broken = FALSE
				M.name = M.GetInitial(name)
				did_repair = TRUE

	if(did_repair) //hit the cooldown
		last_activation = world.time + repair_delay

/datum/shipcomponents/repair_module/module_repair
	name = "system integrity binder"
	repair_amount = 75
	hull_repair_prob = 0
	module_repair_prob = 50
	module_restore_prob = 0

/datum/shipcomponents/repair_module/module_restore
	name = "emergency module rebooter"
	can_fix_broken = TRUE
	hull_repair_prob = 0
	module_repair_prob = 0
	module_restore_prob = 50

/datum/shipcomponents/repair_module/heavy
	name = "heavy repair module"
	repair_amount = 100
	can_fix_broken = TRUE

/datum/shipcomponents/repair_module/hull_repair
	name = "hull integrity binder"
	repair_amount = 100
	hull_repair_prob = 80
	module_repair_prob = 0
	module_restore_prob = 0
	repair_delay = 30 SECONDS

//Cloaking Modules

/datum/shipcomponents/cloaking_module
	name = "cloaking module"
	var/evasion_increase = 10 //increase master ship evasion by this much
	var/active = FALSE

/datum/shipcomponents/cloaking_module/DoActivate()
	if(active)
		return

	else
		for(var/datum/shipcomponents/engines/E in mastership.components)
			if((E.evasion_chance + evasion_increase) > 90)
				var/new_evasion_chance = Clamp(evasion_increase, 0, 90)
				E.evasion_chance += new_evasion_chance
				active = TRUE
			else
				E.evasion_chance += evasion_increase
				active = TRUE

/datum/shipcomponents/cloaking_module/BlowUp()
	for(var/datum/shipcomponents/engines/E in mastership.components)
		E.evasion_chance -= evasion_increase
	active = FALSE
	..()