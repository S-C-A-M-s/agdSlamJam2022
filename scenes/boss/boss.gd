extends Entity

export (int, 10) var attack_speed

onready var bullet := load("res://scenes/boss/projectiles/seeking_projectile.tscn")

enum ACTIONS { SHOOT, SWIPE, BLOCK }

func _ready():
	$ActionLoop.wait_time = 1.1 - (attack_speed / 10)
	$ActionLoop.start()

func perform_action(action):
	match action:
		ACTIONS.SHOOT: _shoot_projectile()
		ACTIONS.SWIPE: print("swiped")
		ACTIONS.BLOCK: print("blocked")

func _shoot_projectile():
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = Vector2(position.x, position.y + 200)
	bullet_instance.rotation = 1.8
	bullet_instance.target = Misc.player
	owner.add_child(bullet_instance)
	print(bullet_instance)

func _pick_action():
	var size = ACTIONS.size()
	return randi() % size

func _on_ActionLoop_timeout():
	var action = _pick_action()
	perform_action(action)
