// /data/ files store data in string format.
// They don't contain other logic for now.
/datum/computer_file/data
	var/stored_data = "" 			// Stored data in string format.
	filetype = "DAT"
	var/block_size = 250
	var/do_not_edit = 0				// Whether the user will be reminded that the file probably shouldn't be edited.
	var/read_only = 0				// Protects files that should never be edited by the user due to special properties.

/datum/computer_file/data/clone()
	var/datum/computer_file/data/temp = ..()
	temp.stored_data = stored_data
	return temp

// Calculates file size from amount of characters in saved string
/datum/computer_file/data/proc/calculate_size()
	size = max(1, round(length(stored_data) / block_size, 1))

/datum/computer_file/data/proc/generate_file_data(var/mob/user)
	return pencode2html(stored_data)

/datum/computer_file/data/logfile
	filetype = "LOG"

/datum/computer_file/data/text
	filetype = "TXT"

/datum/computer_file/data/bodyscan
	filetype = "BSC"
	read_only = 1
	papertype = /obj/item/weapon/paper/bodyscan