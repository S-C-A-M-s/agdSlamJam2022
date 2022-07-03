extends Node

onready var boss_file = File.new()
var boss_filepath := "user://boss.save"

var player: Node
var info: String setget _set_info
var boss_dead: bool

func quit_game():
	get_tree().quit()

func _set_info(new_info):
	info = new_info
	yield(get_tree().create_timer(0.8), "timeout")
	info = ""

func boss_file_check():
	return boss_file.file_exists(boss_filepath)

func boss_file_restore():
	boss_file.open(boss_filepath, File.READ)
	Stats.player_traits = JSON.parse(boss_file.get_line()).result
	boss_file.close()

func boss_fight_loss():
	boss_file.open(boss_filepath, File.WRITE)
	boss_file.store_string(JSON.print(Stats.player_traits))
	boss_file.close()
	quit_game()
