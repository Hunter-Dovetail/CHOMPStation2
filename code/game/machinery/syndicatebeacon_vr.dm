//  Virgo modified syndie beacon, does not give objectives

/obj/machinery/syndicate_beacon/virgo/attack_hand(var/mob/user)
	user.set_machine(src)
	var/dat = "<font color=#005500><i>Scanning [pick("retina pattern", "voice print", "fingerprints", "dna sequence")]...<br>Identity confirmed,<br></i></font>"
	if(ishuman(user) || isAI(user))
		if(is_special_character(user))
			dat += "<font color=#07700><i>Operative record found. Greetings, Agent [user.name].</i></font><br>"
		else if(charges < 1)
			dat += "<TT>Connection severed.</TT><BR>"
		else
			var/honorific = "Mr."
			if(user.gender == FEMALE)
				honorific = "Ms."
			dat += "<font color=red><i>Identity not found in operative database. What can the Black Market do for you today, [honorific] [user.name]?</i></font><br>"
			if(!selfdestructing)
				dat += "<br><br><A href='byond://?src=\ref[src];betraitor=1;traitormob=\ref[user]'>\"[pick("Send me some supplies!", "Transfer supplies.")]\"</A><BR>"
	dat += temptext
	user << browse("<html>[dat]</html>", "window=syndbeacon")
	onclose(user, "syndbeacon")

/obj/machinery/syndicate_beacon/virgo/Topic(href, href_list)
	if(href_list["betraitor"])
		if(charges < 1)
			updateUsrDialog(usr)
			return
		var/mob/M = locate(href_list["traitormob"])
		if(M.mind.tcrystals > 0 || jobban_isbanned(M, JOB_SYNDICATE))
			temptext = "<i>We have no need for you at this time. Have a pleasant day.</i><br>"
			updateUsrDialog(usr)
			return
		charges -= 1
		if(ishuman(M))
			var/mob/living/carbon/human/N = M
			to_chat(N, span_infoplain(span_bold("Access granted, here are the supplies!")))
			traitors.spawn_uplink(N)
			N.mind.tcrystals = DEFAULT_TELECRYSTAL_AMOUNT
			N.mind.accept_tcrystals = 1
			message_admins("[N]/([N.ckey]) has received an uplink and telecrystals from the syndicate beacon.")

	updateUsrDialog(usr)
	return
