/mob/living/carbon/human/proc/phase_shift()
	set name = "Phase Shift (100)"
	set desc = "Shift yourself out of alignment with realspace to travel quickly to different areas."
	set category = "Abilities.Shadekin"

	var/ability_cost = 100

	var/darkness = 1
	var/turf/T = get_turf(src)
	if(!T)
		to_chat(src,span_warning("You can't use that here!"))
		return FALSE
	if((get_area(src).flags & PHASE_SHIELDED))	// Mapping tools to control phasing
		to_chat(src,span_warning("This area is preventing you from phasing!"))
		return FALSE
	//RS Port #658 Start
	var/area/A = get_area(src)
	if(!client?.holder && A.flag_check(AREA_BLOCK_PHASE_SHIFT))
		to_chat(src, span_warning("You can't do that here!"))
		return FALSE
	//RS Port #658 End

	if(ability_flags & AB_PHASE_SHIFTING)
		return FALSE

	var/brightness = T.get_lumcount() //Brightness in 0.0 to 1.0
	darkness = 1-brightness //Invert

	var/watcher = 0
	// Nerf to phasing
	for(var/thing in orange(7, src))
		if(istype(thing, /mob/living/carbon/human))
			var/mob/living/carbon/human/watchers = thing
			if((watchers in oviewers(7,src)) && watchers.species != SPECIES_SHADEKIN)	// And they can see us... (And aren't themselves a shadekin)
				if(!(watchers.stat) && !isbelly(watchers.loc) && !istype(watchers.loc, /obj/item/holder))	// And they are alive and not being held by someone...
					watcher++	// They are watching us!
		else if(istype(thing, /mob/living/silicon/robot))
			var/mob/living/silicon/robot/watchers = thing
			if(watchers in oviewers(7,src))
				if(!watchers.stat && !isbelly(watchers.loc))
					watcher++	//The robot is watching us!
		else if(istype(thing, /obj/machinery/camera))
			var/obj/machinery/camera/watchers = thing
			if(watchers.can_use())
				if(src in watchers.can_see())
					watcher++	//The camera is watching us!


	ability_cost = CLAMP(ability_cost/(0.01+darkness*2),50, 80)//This allows for 1 watcher in full light
	if(watcher>0)
		ability_cost = ability_cost + ( 15 * watcher )
	if(!(ability_flags & AB_PHASE_SHIFTED))
		log_debug("[src] attempted to shift with [watcher] observers with a  cost of [ability_cost] in a darkness level of [darkness]")
	// inform about the observers affecting phasing
	if(darkness<=0.4 && watcher>=2)
		to_chat(src, span_warning("You have a few observers in a well-lit area! This may prevent phasing. (Working cameras count towards observers)"))
	else if(watcher>=3)
		to_chat(src, span_warning("You have a large number of observers! This may prevent phasing. (Working cameras count towards observers)"))


	var/datum/species/shadekin/SK = species
	if(!shadekin_ability_check())
		return FALSE
	// Prevent bugs when spamming phase button
	else if(SK.doing_phase)
		to_chat(src, span_warning("You are already trying to phase!"))
		return FALSE

	else if(shadekin_get_energy() < ability_cost && !(ability_flags & AB_PHASE_SHIFTED))
		to_chat(src, span_warning("Not enough energy for that ability!"))
		return FALSE

	if(!(ability_flags & AB_PHASE_SHIFTED))
		shadekin_adjust_energy(-ability_cost)
	playsound(src, 'sound/effects/stealthoff.ogg', 75, 1)

	if(!T.CanPass(src,T) || loc != T)
		to_chat(src,span_warning("You can't use that here!"))
		return FALSE


	SK.doing_phase = TRUE // Prevent bugs when spamming phase button
	//Shifting in
	if(ability_flags & AB_PHASE_SHIFTED)
		phase_in(T)
	//Shifting out
	else
		phase_out(T)
	SK.doing_phase = FALSE // Prevent bugs when spamming phase button



/mob/living/carbon/human/proc/phase_in(var/turf/T)
	if(ability_flags & AB_PHASE_SHIFTED)
		var/datum/species/shadekin/SK = species

		// pre-change
		forceMove(T)
		var/original_canmove = canmove
		SetStunned(0)
		SetWeakened(0)
		if(buckled)
			buckled.unbuckle_mob()
		if(pulledby)
			pulledby.stop_pulling()
		stop_pulling()
		canmove = FALSE

		// change
		ability_flags &= ~AB_PHASE_SHIFTED
		ability_flags |= AB_PHASE_SHIFTING
		throwpass = FALSE
		name = get_visible_name()
		for(var/obj/belly/B as anything in vore_organs)
			B.escapable = initial(B.escapable)

		//cut_overlays()
		invisibility = initial(invisibility)
		see_invisible = initial(see_invisible)
		see_invisible_default = initial(see_invisible_default) // Allow seeing phased entities while phased.
		incorporeal_move = initial(incorporeal_move)
		density = initial(density)
		force_max_speed = initial(force_max_speed)
		// resetting pull ability after phasing back in
		can_pull_size = initial(can_pull_size)
		can_pull_mobs = initial(can_pull_mobs)
		hovering = initial(hovering)
		update_icon()

		//Cosmetics mostly
		var/obj/effect/temp_visual/shadekin/phase_in/phaseanim = new /obj/effect/temp_visual/shadekin/phase_in(src.loc)
		phaseanim.pixel_y = (src.size_multiplier - 1) * 16 // Pixel shift for the animation placement
		phaseanim.adjust_scale(src.size_multiplier, src.size_multiplier)
		phaseanim.dir = dir
		alpha = 0
		custom_emote(1,"phases in!")
		sleep(5) //The duration of the TP animation
		canmove = original_canmove
		alpha = initial(alpha)
		remove_modifiers_of_type(/datum/modifier/shadekin_phase_vision)
		remove_modifiers_of_type(/datum/modifier/shadekin_phase) // Shadekin probably shouldn't be hit while phasing

		//Potential phase-in vore
		if(can_be_drop_pred || can_be_drop_prey) //Toggleable in vore panel
			var/list/potentials = living_mobs(0)
			if(potentials.len)
				var/mob/living/target = pick(potentials)
				if(can_be_drop_pred && istype(target) && target.devourable && target.can_be_drop_prey && target.phase_vore && vore_selected && phase_vore)
					target.forceMove(vore_selected)
					to_chat(target, span_vwarning("\The [src] phases in around you, [vore_selected.vore_verb]ing you into their [vore_selected.name]!"))
					to_chat(src, span_vwarning("You phase around [target], [vore_selected.vore_verb]ing them into your [vore_selected.name]!"))
				else if(can_be_drop_prey && istype(target) && devourable && target.can_be_drop_pred && target.phase_vore && target.vore_selected && phase_vore)
					forceMove(target.vore_selected)
					to_chat(target, span_vwarning("\The [src] phases into you, [target.vore_selected.vore_verb]ing them into your [target.vore_selected.name]!"))
					to_chat(src, span_vwarning("You phase into [target], having them [target.vore_selected.vore_verb] you into their [target.vore_selected.name]!"))

		ability_flags &= ~AB_PHASE_SHIFTING

		//Affect nearby lights
		var/destroy_lights = 0

		// Add back light destruction
		if(SK.get_shadekin_eyecolor(src) == RED_EYES)
			destroy_lights = 80
		else if(SK.get_shadekin_eyecolor(src) == PURPLE_EYES)
			destroy_lights = 25

		// Add gentle phasing
		if(SK.phase_gentle) // gentle case: No light destruction. Flicker in 4 tile radius once.
			for(var/obj/machinery/light/L in machines)
				if(L.z != z || get_dist(src,L) > 4)
					continue
				L.flicker(1)
			src.Stun(1)
		else
			for(var/obj/machinery/light/L in machines)
				if(L.z != z || get_dist(src,L) > 10)
					continue

				if(prob(destroy_lights))
					spawn(rand(5,25))
						L.broken()
				else
					L.flicker(10)

/mob/living/carbon/human/proc/phase_out(var/turf/T)
	if(!(ability_flags & AB_PHASE_SHIFTED))
		// pre-change
		forceMove(T)
		var/original_canmove = canmove
		SetStunned(0)
		SetWeakened(0)
		if(buckled)
			buckled.unbuckle_mob()
		if(pulledby)
			pulledby.stop_pulling()
		stop_pulling()
		canmove = FALSE

		var/list/allowed_implants = list(
			/obj/item/implant/sizecontrol,
			/obj/item/implant/compliance,
		)
		for(var/obj/item/organ/external/organ in organs)
			for(var/obj/item/O in organ.implants)
				if(is_type_in_list(O, allowed_implants))
					continue
				if(O == nif)
					nif.unimplant(src)
				O.forceMove(drop_location())
				organ.implants -= O
		if(!has_embedded_objects())
			clear_alert("embeddedobject")

		// change
		ability_flags |= AB_PHASE_SHIFTED
		ability_flags |= AB_PHASE_SHIFTING
		throwpass = TRUE
		custom_emote(1,"phases out!")
		name = get_visible_name()

		// Unequipping slots when phasing in, and preventing pulling stuff while phased.
		if(l_hand)
			unEquip(l_hand)
		if(r_hand)
			unEquip(r_hand)
		if(back)
			unEquip(back)

		can_pull_size = 0
		can_pull_mobs = MOB_PULL_NONE
		hovering = TRUE

		for(var/obj/belly/B as anything in vore_organs)
			B.escapable = FALSE

		var/obj/effect/temp_visual/shadekin/phase_out/phaseanim = new /obj/effect/temp_visual/shadekin/phase_out(src.loc)
		phaseanim.pixel_y = (src.size_multiplier - 1) * 16 // Pixel shift for the animation placement
		phaseanim.adjust_scale(src.size_multiplier, src.size_multiplier)
		phaseanim.dir = dir
		alpha = 0
		add_modifier(/datum/modifier/shadekin_phase_vision)
		add_modifier(/datum/modifier/shadekin_phase) //Shadekin probably shouldn't be hit while phasing
		sleep(5)
		invisibility = INVISIBILITY_SHADEKIN
		see_invisible = INVISIBILITY_SHADEKIN
		see_invisible_default = INVISIBILITY_SHADEKIN // Allow seeing phased entities while phased.
		//cut_overlays()
		update_icon()
		alpha = 127

		canmove = original_canmove
		incorporeal_move = TRUE
		density = FALSE
		force_max_speed = TRUE
		ability_flags &= ~AB_PHASE_SHIFTING

//toggle proc for toggling gentle/normal phasing
/mob/living/carbon/human/proc/phase_strength_toggle()
	set name = "Toggle Phase Strength"
	set desc = "Toggle strength of phase. Gentle but slower, or faster but destructive to lights."
	set category = "Abilities.Shadekin"

	var/datum/species/shadekin/SK = species
	if(!istype(SK))
		to_chat(src, span_warning("Only a shadekin can use that!"))
		return FALSE

	if(SK.phase_gentle)
		to_chat(src, span_notice("Phasing toggled to Normal. You may damage lights."))
		SK.phase_gentle = 0
	else
		to_chat(src, span_notice("Phasing toggled to Gentle. You won't damage lights, but concentrating on that incurs a short stun."))
		SK.phase_gentle = 1

/datum/power/shadekin/dark_tunneling
	name = "Dark Tunneling (100) (Once)"
	desc = "Make a passage to the dark."
	verbpath = /mob/living/carbon/human/proc/dark_tunneling
	ability_icon_state = "minion0"

/mob/living/carbon/human/proc/dark_tunneling()
	set name = "Dark Tunneling (100) (Once)"
	set desc = "Make a passage to the dark."
	set category = "Abilities.Shadekin"

	var/template_id = "dark_portal"
	var/datum/map_template/shelter/template

	var/ability_cost = 100

	if(!shadekin_ability_check())
		return FALSE
	else if(ability_flags & AB_PHASE_SHIFTED)
		to_chat(src, span_warning("You can't use that while phase shifted!"))
		return FALSE
	else if(ability_flags & AB_DARK_TUNNEL)
		to_chat(src, span_warning("You have already made a tunnel to the Dark!"))
		return FALSE

	if(!template)
		template = SSmapping.shelter_templates[template_id]
		if(!template)
			throw EXCEPTION("Shelter template ([template_id]) not found!")
			return FALSE

	var/turf/deploy_location = get_turf(src)
	var/status = template.check_deploy(deploy_location)

	switch(status)
		//Not allowed due to /area technical reasons
		if(SHELTER_DEPLOY_BAD_AREA)
			to_chat(src, span_warning("A tunnel to the Dark will not function in this area."))

		//Anchored objects or no space
		if(SHELTER_DEPLOY_BAD_TURFS, SHELTER_DEPLOY_ANCHORED_OBJECTS)
			var/width = template.width
			var/height = template.height
			to_chat(src, span_warning("There is not enough open area for a tunnel to the Dark to form! You need to clear a [width]x[height] area!"))

	if(status != SHELTER_DEPLOY_ALLOWED)
		return FALSE

	var/turf/T = deploy_location
	var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
	smoke.attach(T)
	smoke.set_up(10, 0, T)
	smoke.start()

	src.visible_message(span_notice("[src] begins pulling dark energies around themselves."))
	if(do_after(src, 600)) //60 seconds
		playsound(src, 'sound/effects/phasein.ogg', 100, 1)
		src.visible_message(span_notice("[src] finishes pulling dark energies around themselves, creating a portal."))

		log_and_message_admins("[key_name_admin(src)] created a tunnel to the dark at [get_area(T)]!")
		template.annihilate_plants(deploy_location)
		template.load(deploy_location, centered = TRUE)
		template.update_lighting(deploy_location)
		ability_flags |= AB_DARK_TUNNEL
		shadekin_adjust_energy(-(ability_cost - 10)) //Leaving enough energy to actually activate the portal
		return TRUE
	else
		return FALSE

/datum/power/shadekin/dark_respite
	name = "Dark Respite (Only in Dark)"
	desc = "Focus yourself on healing any injuries sustained."
	verbpath = /mob/living/carbon/human/proc/dark_respite
	ability_icon_state = "ling_anatomic_panacea"

/mob/living/carbon/human/proc/dark_respite()
	set name = "Dark Respite (Only in Dark)"
	set desc = "Focus yourself on healing any injuries sustained."
	set category = "Abilities.Shadekin"

	var/datum/species/shadekin/SK = species
	if(!istype(SK))
		to_chat(src, span_warning("Only a shadekin can use that!"))
		return FALSE
	else if(!istype(get_area(src), /area/shadekin))
		to_chat(src, span_warning("Can only trigger Dark Respite in the Dark!"))
		return FALSE
	else if(stat)
		to_chat(src, span_warning("Can't use that ability in your state!"))
		return FALSE
	else if(ability_flags & AB_DARK_RESPITE)
		to_chat(src, span_warning("You can't use that so soon after an emergency warp!"))
		return FALSE
	else if(has_modifier_of_type(/datum/modifier/dark_respite) && !SK.manual_respite)
		to_chat(src, span_warning("You cannot manually end a Dark Respite triggered by an emergency warp!"))
	else if(ability_flags & AB_PHASE_SHIFTED)
		to_chat(src, span_warning("You can't use that while phase shifted!"))
		return FALSE

	if(has_modifier_of_type(/datum/modifier/dark_respite))
		to_chat(src, span_notice("You stop focusing the Dark on healing yourself."))
		SK.manual_respite = FALSE
		remove_a_modifier_of_type(/datum/modifier/dark_respite)
		return TRUE
	to_chat(src, span_notice("You start focusing the Dark on healing yourself. (Leave the dark or trigger the ability again to end this.)"))
	SK.manual_respite = TRUE
	add_modifier(/datum/modifier/dark_respite)
	return TRUE

/datum/map_template/shelter/dark_portal
	name = "Dark Portal"
	shelter_id = "dark_portal"
	description = "A portal to a section of the Dark"
	mappath = "modular_chomp/maps/submaps/shelters/dark_portal.dmm"

/datum/map_template/shelter/dark_portal/New()
	. = ..()
	blacklisted_turfs = typecacheof(list(/turf/unsimulated))
	blacklisted_areas = typecacheof(list(/area/centcom, /area/shadekin))

/obj/effect/abstract/dark_maw
	var/mob/living/owner = null
	var/obj/belly/target = null
	icon = 'modular_chomp/icons/obj/Shadekin_powers_2.dmi'
	icon_state = "dark_maw_waiting"

/obj/effect/abstract/dark_maw/New(loc, var/mob/living/user, var/trigger_now = 0)
	. = ..()
	if(istype(user))
		owner = user
		target = owner.vore_selected

	if(!isturf(loc))
		return INITIALIZE_HINT_QDEL
	var/turf/T = loc
	if(T.get_lumcount() >= 0.5)
		visible_message(span_notice("A set of shadowy lines flickers away in the light."))
		icon_state = "dark_maw_used"
		qdel(src)
		return

	var/mob/living/target_user = null
	for(var/mob/living/L in T)
		if(L != owner && !L.incorporeal_move)
			target_user = L
			break
	if(istype(target_user))
		triggered_by(target_user, 1)
		// to trigger rebuild
	else if(trigger_now)
		icon_state = "dark_maw_used"
		flick("dark_maw_tr", src)
		visible_message(span_warning("A set of crystals suddenly springs from the ground and shadowy tendrils wrap around nothing before vanishing."))
		spawn(30)
			qdel(src)
	else
		var/mob/living/carbon/human/carbon_owner = owner
		var/mob/living/simple_mob/shadekin/sm_owner = owner
		if(istype(carbon_owner))
			var/datum/species/shadekin/SK = carbon_owner.species
			if(istype(SK))
				SK.active_dark_maws += src
		else if(istype(sm_owner))
			sm_owner.active_dark_maws += src
		flick("dark_maw", src)
		START_PROCESSING(SSobj, src)

/obj/effect/abstract/dark_maw/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(istype(owner))
		var/mob/living/carbon/human/carbon_owner = owner
		var/mob/living/simple_mob/shadekin/sm_owner = owner
		if(istype(carbon_owner))
			var/datum/species/shadekin/SK = carbon_owner.species
			if(istype(SK))
				SK.active_dark_maws -= src
		else if(istype(sm_owner))
			sm_owner.active_dark_maws -= src
	return ..()

/obj/effect/abstract/dark_maw/Crossed(O)
	. = ..()
	if(!isliving(O))
		return
	if(icon_state != "dark_maw_waiting")
		return
	var/mob/living/L = O
	if(!L.incorporeal_move && (!owner || L != owner))
		triggered_by(L)

/obj/effect/abstract/dark_maw/process()
	var/turf/T = get_turf(src)
	if(!istype(T) || T.get_lumcount() >= 0.5)
		dispel()

/obj/effect/abstract/dark_maw/proc/dispel()
	if(icon_state == "dark_maw_waiting")
		visible_message(span_notice("A set of shadowy lines flickers away in the light."))
	else
		visible_message(span_notice("The crystals and shadowy tendrils dissipate with the light shone on it."))
	icon_state = "dark_maw_used"
	qdel(src)

/obj/effect/abstract/dark_maw/proc/triggered_by(var/mob/living/L, var/triggered_instantly = 0)
	STOP_PROCESSING(SSobj, src)
	icon_state = "dark_maw_used"
	flick("dark_maw_tr", src)
	L.AdjustStunned(4)
	visible_message(span_warning("A set of crystals spring out of the ground and shadowy tendrils start wrapping around [L]."))
	if(owner && !triggered_instantly)
		to_chat(owner, span_warning("A dark maw you deployed has triggered!"))
	spawn(10)
		var/will_vore = 1

		if(!owner || !(target in owner) || !L.devourable || !L.can_be_drop_prey || !owner.can_be_drop_pred || !L.phase_vore)
			will_vore = 0

		if(!src || src.gc_destroyed)
			//We got deleted probably, do nothing more
			return

		if(L.loc != get_turf(src))
			visible_message(span_notice("The shadowy tendrils fail to catch anything and dissipate."))
			qdel(src)
		else if(will_vore)
			visible_message(span_warning("The shadowy tendrils grab around [L] and drag them into the floor, leaving nothing behind."))
			L.forceMove(target)
			qdel(src)
		else
			var/obj/effect/energy_net/dark/net = new /obj/effect/energy_net/dark(get_turf(src))
			if(net.buckle_mob(L))
				visible_message(span_warning("The shadowy tendrils wrap around [L] and traps them in a net of dark energy."))
			else
				visible_message(span_notice("The shadowy tendrils wrap around [L] and then dissipate, leaving them in place."))
			qdel(src)

/obj/effect/energy_net/dark
	name = "dark net"
	desc = "It's a net made of dark energy."
	icon = 'modular_chomp/icons/obj/Shadekin_powers_2.dmi'
	icon_state = "dark_net"

	escape_time = 30 SECONDS

/obj/effect/energy_net/dark/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(istype(user,/mob/living/simple_mob/shadekin))
		visible_message(span_danger("[user] dissipates \the [src] with a touch!"))
		unbuckle_mob(buckled_mob)
		return
	else if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		var/datum/species/shadekin/SK = H.species
		if(istype(SK))
			visible_message(span_danger("[user] dissipates \the [src] with a touch!"))
			unbuckle_mob(buckled_mob)
			return
	. = ..()

/obj/effect/energy_net/dark/process()
	. = ..()
	var/turf/T = get_turf(src)
	if(!istype(T) || T.get_lumcount() >= 0.6)
		visible_message(span_notice("The tangle of dark tendrils fades away in the light."))
		qdel(src)

/datum/power/shadekin/dark_maw
	name = "Dark Maw (20)"
	desc = "Create a trap to capture others, or steal people from phase"
	verbpath = /mob/living/carbon/human/proc/dark_maw
	ability_icon_state = "dark_maw_ic"

/mob/living/carbon/human/proc/dark_maw()
	set name = "Dark Maw (20)"
	set desc = "Create a trap to capture others, or steal people from phase"
	set category = "Abilities.Shadekin"

	var/ability_cost = 20

	if(!shadekin_ability_check())
		return FALSE
	else if(shadekin_get_energy() < ability_cost)
		to_chat(src, span_warning("Not enough energy for that ability!"))
		return FALSE
	var/turf/T = get_turf(src)
	if(!istype(T))
		to_chat(src, span_warning("You don't seem to be able to set a trap here!"))
		return FALSE
	else if(T.get_lumcount() >= 0.5)
		to_chat(src, span_warning("There is too much light here for your trap to last!"))
		return FALSE

	if(do_after(src, 10))
		if(ability_flags & AB_PHASE_SHIFTED)
			new /obj/effect/abstract/dark_maw(loc, src, 1)
		else
			new /obj/effect/abstract/dark_maw(loc, src)
		shadekin_adjust_energy(-ability_cost)

		return TRUE
	else
		return FALSE

/mob/living/carbon/human/proc/clear_dark_maws()
	set name = "Dispel dark maws"
	set desc = "Dispel any active dark maws in place"
	set category = "Abilities.Shadekin"

	var/datum/species/shadekin/SK = species
	if(!istype(SK))
		to_chat(src, span_warning("Only a shadekin can use that!"))
		return FALSE

	for(var/obj/effect/abstract/dark_maw/dm in SK.active_dark_maws)
		dm.dispel()

/mob/living/carbon/human/proc/nutrition_conversion_toggle()
	set name = "Toggle Energy <-> Nutrition conversions"
	set desc = "Toggle dark energy and nutrition being converted into each other when full"
	set category = "Abilities.Shadekin"

	var/datum/species/shadekin/SK = species
	if(!istype(SK))
		to_chat(src, span_warning("Only a shadekin can use that!"))
		return FALSE

	if(SK.nutrition_energy_conversion)
		to_chat(src, span_notice("Nutrition and dark energy conversions disabled."))
		SK.nutrition_energy_conversion = 0
	else
		to_chat(src, span_notice("Nutrition and dark energy conversions enabled."))
		SK.nutrition_energy_conversion = 1

/datum/modifier/shadekin_phase
	name = "Shadekin Phasing"
	evasion = 100
