extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Stats.add_sincerity("3")
	var new_dialog = Dialogic.start("test")
	add_child(new_dialog)
