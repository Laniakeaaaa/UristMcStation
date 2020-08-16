/**********
* Medical *
**********/
/datum/uplink_item/item/medical
	category = /datum/uplink_category/medical

/datum/uplink_item/item/medical/sinpockets
	name = "Box of Sin-Pockets"
	item_cost = 8
	path = /obj/item/weapon/storage/box/sinpockets

/datum/uplink_item/item/medical/stabilisation
	name = "Stabilisation First Aid Kit"
	desc = "Contains variety of emergency medical pouches."
	item_cost = 16
	path = /obj/item/weapon/storage/firstaid/stab

/datum/uplink_item/item/medical/stasis
	name = "Stasis Bag"
	desc = "Reusable bag designed to slow down life functions of occupant, especially useful if short on time or in a hostile enviroment."
	item_cost = 24
	path = /obj/item/bodybag/cryobag

/datum/uplink_item/item/medical/defib
	name = "Combat Defibrillator"
	desc = "A belt-equipped defibrillator that can be rapidly deployed. Does not have the restrictions or safeties of conventional defibrillators and can revive through space suits."
	item_cost = 24
	path = /obj/item/weapon/defibrillator/compact/combat/loaded

/datum/uplink_item/item/medical/surgery
	name = "Surgery kit"
	item_cost = 40
	path = /obj/item/weapon/storage/firstaid/surgery

/datum/uplink_item/item/medical/combat
	name = "Combat medical kit"
	item_cost = 48
	path = /obj/item/weapon/storage/firstaid/combat
