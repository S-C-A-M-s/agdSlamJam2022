extends Node2D

func _ready():
	Misc.player = $Player
	$Player.connect("died", self, "_on_Player_died")
	
func _on_Player_died():
	get_tree().quit()
