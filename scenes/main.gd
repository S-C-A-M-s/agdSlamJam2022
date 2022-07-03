extends Control

export (String) var timeline

onready var dialog = Dialogic.start(timeline)

# Called when the node enters the scene tree for the first time.
func _ready():
	if BadFile.bad_file_check():
		get_tree().quit()
	add_child(dialog)

func _on_Tick_timeout():
	Stats.update($Dialogic)
