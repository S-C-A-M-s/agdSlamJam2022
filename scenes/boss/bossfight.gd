extends Node2D

func _ready():
	Misc.player = $Player
	$Player.connect("died", self, "_on_Player_died")
	$Boss.connect("died", self, "_on_Boss_died")
	
func _on_Player_died():
	Misc.boss_fight_loss()

func _on_Boss_died():
	Misc.boss_dead = true
	get_tree().change_scene("res://scenes/main.tscn")

func _process(delta):
	$Info.text = Misc.info
