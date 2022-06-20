extends Node

signal update_stats
signal update_traits

var stats: Array = [
	"sincerity", "affection", "similarity", "synergy", "respect"
	]
var traits: Array = [
	"BUFF_LEGS", "HISTORIAN", "CAFFIENATED", "EXHAUSTED",
	"ENABLER", "PIGLOVER", "CRIMINAL", "SMARTASS", "SAVIOUR"
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
		if value > 0 and not player_traits.has(trait):
			player_traits.push_front(trait)
			player_traits.resize(max_traits)
	emit_signal("update_traits")

func get_variable(dialog: Dialogic, namespace: String, variable: String):
	var output = dialog.get_variable(namespace + "/" + variable)
	return int(output)
