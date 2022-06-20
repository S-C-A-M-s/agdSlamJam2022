extends Node

var stats: Array = [
	"sincerity", "affection", "similarity", "synergy", "respect"
	]
var traits: Array = [
	"BUFF_LEGS", "HISTORIAN", "CAFFIENATED", "EXHAUSTED",
	"ENABLER", "PIGLOVER", "CRIMINAL", "SMARTASS", "SAVIOUR"
	]

func stats(dialog: Dialogic):
	var output: Dictionary
	var value: int
	for stat in stats:
		value = get_variable(dialog, "stats", stat)
		output[stat] = value
	return output

func traits(dialog: Dialogic):
	var output: Dictionary
	var value: int
	for trait in traits:
		value = get_variable(dialog, "traits", trait)
		if value > 0:
			output[trait] = value
	return output

func get_variable(dialog: Dialogic, namespace: String, variable: String):
	var output = dialog.get_variable(namespace + "/" + variable)
	return int(output)
