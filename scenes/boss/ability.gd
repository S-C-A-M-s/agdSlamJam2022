extends Node

var queue: Array

onready var player = get_parent().get_node("Player")
onready var bullet := load("res://scenes/boss/projectiles/projectile.tscn")

func add_ability():
	if queue.size() < 3:
		queue.append(_pick_next())

func use():
	var ability = queue.front()
	match ability:
		"BUFF_LEGS": _buff_legs()
		"HISTORIAN": _historian()
		"CAFFEINATED": _caffeinated()
		"EXHAUSTED": _exhausted()
		"ENABLER": _enabler()
		"PIGLOVER": _piglover()
		"CRIMINAL": _criminal()
		"SMARTASS": _smartass()
		"SAVIOUR": _saviour()
		"MULTITASKER": _multitasker()
	queue.remove(0)

func _ready():
	if Stats.player_traits.empty():
		Stats.player_traits = ["SAVIOUR","BUFF_LEGS","CAFFEINATED"]
	print(_pick_next())

func _input(event):
	if event.is_action_pressed("use_trait") and not queue.empty():
#		use()
		_historian()

func _pick_next():
	var size = Stats.player_traits.size()
	var slot = randi() % size
	return Stats.player_traits[slot]

# Abilities
func _buff_legs():
	player.speed += 60
	yield(get_tree().create_timer(10), "timeout")
	player.speed = player.default_speed

func _historian():
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = Vector2(player.position.x, player.position.y - 75)
	bullet_instance.rotation = player.rotation
	bullet_instance.texture = "res://assets/bossfight/book.png"
	bullet_instance.damage = 40
	owner.add_child(bullet_instance)

func _caffeinated():
	pass

func _exhausted():
	pass

func _enabler():
	pass

func _piglover():
	pass

func _criminal():
	pass

func _smartass():
	pass

func _saviour():
	pass

func _multitasker():
	pass

func _on_Cooldown_timeout():
	add_ability()
	print(queue)
