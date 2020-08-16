// Urist Specific Viruses:

// Synthetic Viruses -

// Synthetic Viruses must be investigated by a roboticist, using a maintenance scanner on a Synthetic Subject. 


// Satsana Runtime

/datum/disease2/disease/satsanaruntime // Causes leg lock-ups in IPCs, Random Lockdowns for Cyborgs.
	infectionchance = 0 // Synthetic Viruses cannot infect others.
	speed = 5
	spreadtype = "Synthetic"

/datum/disease2/disease/satsanaruntime/New()
	..()
	var/datum/disease2/effect/lockup/E1 = new() // Short Lockdowns/Leg Locking
	E1.stage = 1
	effects += E1
	var/datum/disease2/effect/lockupsevere/E2 = new()   // Severe Lockdowns/Leg Locking.
	E2.stage = 2
	effects += E2


// Carapace Trojan // Causes severe vocal garbles/muteness if not fixed.
/datum/disease2/disease/carapacetrojan
    infectionchance = 0
    speed = 7
    spreadtype = "Synthetic"

/datum/disease2/disease/carapacetrojan/New()
    	..()
	var/datum/disease2/effect/garble/E1 = new() // Voice Garble
	E1.stage = 1
	effects += E1
	var/datum/disease2/effect/severegarble/E2 = new()   // Severe Voice Garble
	E2.stage = 2
	effects += E2
	var/datum/disease2/effect/speechdisabled/E3 = new() // Voice Muting until fixed.
	E1.stage = 3
	effects += E3

// NaN-OU virus // Causes battery cell draining.
/datum/disease2/disease/nanou
    infectionchance = 0
    speed = 5
    spreadtype = "Synthetic"

/datum/disease2/disease/nanou/New()
    	..()
	var/datum/disease2/effect/smalldrain/E1 = new() // Cell drains 1.25% faster
	E1.stage = 1
	effects += E1
	var/datum/disease2/effect/mediumdrain/E2 = new()   // Cell drains 1.5% faster.
	E2.stage = 2
	effects += E2

// 9d api  Causes advertisements and speech garbling
/datum/disease2/disease/9dapi
    infectionchance = 0
    speed = 5
    spreadtype = "Synthetic"

/datum/disease2/disease/9dapi/New()
    	..()
	var/datum/disease2/effect/advertslow/E1 = new() // Randomly read out spam advertisements.
	E1.stage = 1
	effects += E1
	var/datum/disease2/effect/advertsmed/E2 = new()   // More commonly read out about spam advertisements.
	E2.stage = 2
	effects += E2
	var/datum/disease2/effect/garblemed/E3 = new() // Garbled speech, plus random advertisements.
	E1.stage = 3
	effects += E3