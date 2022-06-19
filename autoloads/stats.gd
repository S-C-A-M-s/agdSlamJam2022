extends Node

var affection: int
var similarity: int
var symbiosis: int
var sincerity: int

func add_affection(amount: String):
	affection += int(amount)

func add_similarity(amount: String):
	similarity += int(amount)

func add_symbiosis(amount: String):
	symbiosis += int(amount)

func add_sincerity(amount: String):
	sincerity += int(amount)

func print_stats():
	print(affection, similarity, symbiosis, sincerity)
