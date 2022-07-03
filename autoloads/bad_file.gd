extends Node

onready var bad_file = File.new()
var bad_filepath := "user://stats.md"

var stat_txt = "# Stats\n## Or how you ruined the life of one Winnie-the-Pooh\n\nHe was a simple bear, of simple pleasures.  \nCould you blame him for getting out on the scene?  \nWhy did you act the way you did?  \nMaybe think about that!"

func bad_file_check():
	return bad_file.file_exists(bad_filepath)

func create_bad_file():
	bad_file.open(bad_filepath, File.WRITE)
	bad_file.store_string(stat_txt)
	bad_file.close()
	get_tree().quit()
