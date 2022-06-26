extends Node

signal update_stats
signal update_traits

var stats: Array = [
	"sincerity", "affection", "similarity", "synergy", "respect"
	]
var traits: Array = [
	"BUFF_LEGS", "HISTORIAN", "CAFFEINATED", "EXHAUSTED",
	"ENABLER", "PIGLOVER", "CRIMINAL", "SMARTASS", "SAVIOUR", "MULTITASKER"
	]

var player_stats: Dictionary
var player_traits: Array

var max_traits: int = 3

func update(dialog: Dialogic):
	update_stats(dialog)
	update_traits(dialog)

func update_stats(dialog: Dialogic):
	var value: int
	for stat in stats:
		value = get_variable(dialog, "stats", stat)
		player_stats[stat] = value
	emit_signal("update_stats")

func update_traits(dialog: Dialogic):
	var value: int
	for trait in traits:
		value = get_variable(dialog, "traits", trait)
		if value > 0:
			add_trait(trait, dialog)
	if player_traits.has("MULTITASKER"):
		max_traits = 5
	else:
		max_traits = 3
	emit_signal("update_traits")

func add_trait(trait: String, dialog: Dialogic):
	if not player_traits.has(trait):
		player_traits.push_front(trait)
		player_traits.resize(max_traits)
		_remove_old_traits(dialog)
		set_variable(dialog, "traits", trait, 1)
		

func get_variable(dialog: Dialogic, namespace: String, variable: String):
	var output = dialog.get_variable(namespace + "/" + variable)
	return int(output)

func set_variable(dialog: Dialogic, namespace: String, variable: String, value: int):
	dialog.set_variable(namespace + "/" + variable, value)

func _remove_old_traits(dialog: Dialogic):
	for trait in traits:
		if not player_traits.has(trait):
			set_variable(dialog, "traits", trait, 0)
