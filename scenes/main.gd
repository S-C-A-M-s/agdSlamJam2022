extends Node2D

export (String) var timeline

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = Dialogic.start(timeline)
	add_child(new_dialog)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print(Stats.traits($Dialogic))
		print(Stats.stats($Dialogic))
