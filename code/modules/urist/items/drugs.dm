// Code Ported from World Station - Credit to Jenelle.

obj/item/weapon/reagent_containers/powder
	name = "powder"
	desc = "A powdered form of... something."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "powder"
	item_state = "powder"
	possible_transfer_amounts = null
	w_class = ITEMSIZE_TINY
	volume = 5
	var/list/filled_reagents

/obj/item/weapon/reagent_containers/powder/yayo/New()
	..()
	name = "powdered yayo"
	desc = "A powdered form of a popular stimulant drug."
	reagents.add_reagent("yayo", 5)

//Crushing
/obj/item/weapon/reagent_containers/pill/yayo/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(is_sharp(W))
		new /obj/item/weapon/reagent_containers/powder/yayo(src.loc)
		user.visible_message("<span class='warning'>[user] gently cuts up [src] with [W]!</span>")
		playsound(src.loc, 'sound/weapons/flipblade.ogg', 50, 1)
		qdel(src)
		return

	if(istype(W, /obj/item/weapon/card/id))
		new /obj/item/weapon/reagent_containers/powder/yayo(src.loc)
		user.visible_message("<span class='warning'>[user] clumsily chops up [src] with [W]!</span>")
		qdel(src)
		return

		return ..()

//Snorting
/obj/item/weapon/reagent_containers/powder/yayo/attackby(var/obj/item/weapon/W, var/mob/living/user) // TODO: Add some sort of way to stop Dionae/Robots from getting blazed.

	if(!istype(W, /obj/item/weapon/glass_extra/straw) && !istype(W, /obj/item/weapon/rollingpaper))
		return ..()

	user.visible_message("<span class='warning'>[user] snorts the [src] with the [W]!</span>")

	if(reagents)
		reagents.trans_to_mob(user, amount_per_transfer_from_this, CHEM_BLOOD)

	qdel(src)