/obj/item/storage/briefcase/target_toy
	starts_with = list(
	/obj/item/paper/target,
	/obj/item/gun/projectile/revolver/toy/big_iron,
	/obj/item/grenade/confetti = 2
	)

/obj/item/paper/target
	name = "target notice"

/obj/item/paper/target/New()
<<<<<<< Updated upstream
	info = "Your target is " + span_bold("[random_name(pick(MALE,FEMALE))]") + ". Make sure they don't get out of there alive."
=======
	info = {"Your target is <b>[random_name(pick(MALE,FEMALE))]</b>. Make sure they don't get out of there alive."}
>>>>>>> Stashed changes
