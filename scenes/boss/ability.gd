extends Node

var queue: Array
var multitask: bool

onready var player = get_parent().get_node("Player")
onready var bullet := load("res://scenes/boss/projectiles/projectile.tscn")

func add_ability():
	if queue.size() < 3:
		queue.append(_pick_next())

func use(ability):
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

func _ready():
	randomize()
	if Stats.player_traits.empty():
		Stats.player_traits = ["CAFFEINATED","CRIMINAL","PIGLOVER"]
	if Misc.boss_file_check():
		Stats.player_traits = []
		Misc.boss_file_restore()
	for loop in 3:
		add_ability()

func _input(event):
	if event.is_action_pressed("use_trait") and not queue.empty():
		var ability = queue.back()
		queue.remove(queue.size() - 1)
		use(ability)
		if multitask and not ability == "MULTITASKER":
			yield(get_tree().create_timer(0.15), "timeout")
			use(ability)
			multitask = false

func _display_abilities():
	var text: String
	for slot in queue.size():
		var ability = queue[slot]
		if slot == queue.size() - 1:
			text = text + ability + " (Z)"
		else:
			text = text + ability + ", "
	$AbilityList.text = text

func _process(delta):
	_display_abilities()

func _pick_next():
	var size = Stats.player_traits.size()
	var slot = randi() % size
	return Stats.player_traits[slot]

func _projectile(texture: String, damage: int, rotation: float, scale: float = 0.1, speed: int = 700):
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = Vector2(player.position.x, player.position.y - 75)
	bullet_instance.rotation = player.rotation
	bullet_instance.texture = texture
	bullet_instance.texture_rotation = rotation
	bullet_instance.texture_scale = scale
	bullet_instance.speed = speed
	bullet_instance.damage = damage
	owner.add_child(bullet_instance)

# Abilities
func _buff_legs():
	Misc.info = "Movement Speed Increased"
	player.speed += 100
	yield(get_tree().create_timer(10), "timeout")
	player.speed = player.default_speed

func _historian():
	_projectile("res://assets/bossfight/projectiles/book.png", 40, 0)

func _caffeinated():
	Misc.info = "Attack Speed Increased!"
	player.attack_cooldown -= 0.005
	yield(get_tree().create_timer(15), "timeout")
	player.attack_cooldown = player.default_attack_cooldown

func _exhausted():
	_projectile("res://assets/bossfight/projectiles/sleepy.png", 38, 90, 0.5, 450)

func _enabler():
	_projectile("res://assets/bossfight/projectiles/hunny.png", 50, 90)

func _piglover():
	_projectile("res://assets/characters/cop/kmart5_police.png", 55, 90, 0.15)

func _criminal():
	_projectile("res://assets/bossfight/projectiles/knife.png", 55, 50, 0.08)

func _smartass():
	for loop in 5:
		_projectile("res://assets/bossfight/projectiles/nerd.png", 15, 90, 0.04)
		yield(get_tree().create_timer(0.1), "timeout")

func _saviour():
	Misc.info = "Gained 15 Health!"
	player.health += 15

func _multitasker():
	Misc.info = "Double next ability!"
	multitask = true

func _on_Cooldown_timeout():
	add_ability()
	print(queue)
