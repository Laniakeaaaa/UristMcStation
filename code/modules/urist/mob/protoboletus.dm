/datum/species/moldman

	name =                   SPECIES_MOLDMAN
	name_plural =            "Protoboletus"
	show_ssd =               "slumbers peacefully"

	blurb = "Recent expeditions to the secluded sectors of the Boötes Void, lead to the discovery  \
	of a new type of fungi, known as the Protoboletus. Spores of these fungis will often grow in dark \
	dank areas of stations, ships and planets and will slowly convert areas into biomass to feed it's expansion. \
	They are known to be intrinsically territorial once fully developed."
	

	icobase =                'icons/uristmob/species/protoboletus/body.dmi'
	deform =                 '/icons/uristmob/species/protoboletus/deform.dmi'
	damage_overlays =        'icons/mob/human_races/species/human/damage_overlay.dmi'
	blood_mask =             'icons/mob/human_races/species/human/blood_mask.dmi'
	eye_icon_location =      'icons/mob/human_races/species/blueforged/eyes.dmi'
	eye_icon =               "moldman"
	blood_color =            "#cbcba9"
	flesh_color =            "#3b343d"
	hud_type =               /datum/hud_data/moldman
	has_floating_eyes =      TRUE
	min_age =                 1
	max_age =                800
	slowdown =               0
	rarity_value =            3
	gluttonous =              0
	siemens_coefficient =     0
	body_temperature =        null
	breath_type =             "carbon_dioxide"
	poison_type =             "chloride"
	exhale_type =             "oxygen"
	genders =                 list(NEUTER)
	language =                LANGUAGE_FUNGALMIND
	default_language =        LANGUAGE_FUNGALMIND
	additional_langs =         list(LANGUAGE_ROOTLOCAL, LANGUAGE_ROOTGLOBAL)    // Can communicate to Dionae.
	num_alternate_languages = 2
	appearance_flags =        0
	species_flags =           SPECIES_FLAG_IS_PLANT | SPECIES_FLAG_NO_SCAN | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NO_TANGLE  // Have fungi-based physiology, lacks DNA and is immune to most conventional poisons. Unable to wear shoes, so they are able to walk on glass, and have tangleble vines.
	spawn_flags =             SPECIES_IS_RESTRICTED | SPECIES_NO_FBP_CONSTRUCTION | SPECIES_NO_FBP_CHARGEN | SPECIES_NO_LACE
    darksight_range = 3
	darksight_tint = DARKTINT_MODERATE
    total_health = 100
	brute_mod = 0.9
	burn_mod =  1.30 // Very weak to Fire/High Temperatures.
	tox_mod = 0.80 // Toxins not as effective.
    strength = STR_HIGH
    virus_immune = 1

	heat_discomfort_strings = list(
		"Your gills shudder uncomfortably from the heat.",
		"Spores whisp and willow from the heat surrounding you.",
		"Your form shudders uncomfortably from the heat."
		)
	cold_discomfort_strings = list(
		"Your form begins to harden in the cold.",
		"You feel yourself start to slow from the cold conditions",
		"You can feel small ice crystals forming in your gills."
		)
	)


/datum/hud_data/moldman
	gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = 1),
		"o_clothing" =   list("loc" = ui_oclothing, "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = 1),
		"mask" =         list("loc" = ui_mask,      "name" = "Mask",         "slot" = slot_wear_mask, "state" = "mask",   "toggle" = 1),
		"gloves" =       list("loc" = ui_gloves,    "name" = "Gloves",       "slot" = slot_gloves,    "state" = "gloves", "toggle" = 1),
		"eyes" =         list("loc" = ui_glasses,   "name" = "Glasses",      "slot" = slot_glasses,   "state" = "glasses","toggle" = 1),
		"l_ear" =        list("loc" = ui_l_ear,     "name" = "Left Ear",     "slot" = slot_l_ear,     "state" = "ears",   "toggle" = 1),
		"r_ear" =        list("loc" = ui_r_ear,     "name" = "Right Ear",    "slot" = slot_r_ear,     "state" = "ears",   "toggle" = 1),
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = 1),
		"shoes" =        list("loc" = ui_shoes,     "name" = "Shoes",        "slot" = slot_shoes,     "state" = "shoes",  "toggle" = 1),
		"suit storage" = list("loc" = ui_sstore1,   "name" = "Suit Storage", "slot" = slot_s_store,   "state" = "suitstore"),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id"),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)


// Naming System for Protoboletus
GLOBAL_LIST_INIT(moldman_names, list())

// Protoboletus take names in combination of the final latin words of a fungi, in combination to what star system they came from shortened down.
GLOBAL_LIST_INIT(moldman_form, list(
	"calvescens",			"cepistipes",			"fuscipes", 			"gallica", 	"gemina", 				"mellea", 			"nabsnona", 	"ostoyae", 			\
	"sinapina",			"tabescens",			"tuberosa", 		"foliicolus", 	"manipularis", 				"hanedae", 			"pallescens", 		"yunnanensis",  			\
	"viridilucens",				"asterina",			"cahaya", 		"citricolor", 		"chlorophos",			"coralliformis", 			"daisyogunensis", 		"bornhardt", 		\
	"asterina",			"cahaya",				"deeptha",		"fera", 		"galopus"	, 		"haematopus", 			"illuminans", 		"lazulina", 			\
	"luxperpetua", 			"maculata", 			"nocticaelum", 		"polygramma", 		"pseudo", 				"sinar", 			"zephirus", 		"gardneri", 		\
	"nambi", 			"noctilucens", 			"nidlformis", 		"irritans", 	"roridus", 		"hypoxylon", 			"luxfilamentus", 		"margarita"
))

GLOBAL_LIST_INIT(moldman_cluster, list(
	"boote",			"aquar",			"canu",		"ceti",		"corvi",			"pegas",			"tauri",		"ursae",			\
	"cygna",			"erid",			"aurig",	"lyrae",	"andor",			"ori",			"gemi",			"delph",			\
	"serper"
))

// Procs.
/datum/species/moldman/get_random_name(var/gender)
	return "[rand(10000,99999)] [GLOB.moldman_names.len ? pick(GLOB.moldman_names) : create_moldman_name()]"

/datum/species/moldman/get_random_name(var/gender)
	return "[rand(1,99)] [create_moldman_name()]"

/proc/create_moldman_name()
	var/moldmanname = "[capitalize(pick(GLOB.moldman_cluster))] [capitalize(pick(GLOB.moldman_forms))]"
	GLOB.gyne_names += gynename
	return moldmanname