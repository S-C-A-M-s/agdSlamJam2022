extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = Dialogic.start("kindling")
	add_child(new_dialog)
