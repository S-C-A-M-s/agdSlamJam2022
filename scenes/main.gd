extends Control

export (String) var timeline

var dialog

onready var debug = $StatsHUD/PopupDialog/VBoxContainer/TextEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	if Misc.boss_dead:
		timeline = "win"
	if BadFile.bad_file_check():
		get_tree().quit()
	dialog = Dialogic.start(timeline)
	add_child(dialog)

func _on_Tick_timeout():
	Stats.update($Dialogic)

func _input(event):
	if event.is_action_pressed("ui_debug"):
		$StatsHUD/PopupDialog.popup_centered()

func _on_SetTrait_pressed():
	if Stats.traits.has(debug.text):
		Stats.add_trait(debug.text, $Dialogic)
	debug.text = ""

func _on_LoadTimeline_pressed():
	timeline = debug.text
	if not timeline.empty():
		Dialogic.change_timeline(timeline)
	debug.text = ""
