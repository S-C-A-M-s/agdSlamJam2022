extends StaticBody2D

export var health: int setget _health_changed
export var invulnerable: bool
export (int, 10) var attack_speed

onready var bullet := load("res://scenes/boss/projectile.tscn")

enum ACTIONS { SHOOT, SWIPE, BLOCK }

var immune: bool
var dead: bool

func _ready():
	$ImmuneCooldown.start()
	$ActionLoop.wait_time = 1.1 - (attack_speed / 10)
	$ActionLoop.start()

func hit(damage: int):
	if not immune or invulnerable:
		self.health -= damage
	if health <= 0:
		_damaged()
		dead = true

func perform_action(action):
	match action:
		ACTIONS.SHOOT: _shoot_projectile()
		ACTIONS.SWIPE: print("swiped")
		ACTIONS.BLOCK: print("blocked")

func _shoot_projectile():
	var bullet_instance = bullet.instance()
	owner.add_child(bullet_instance)
	bullet_instance.start(transform, Misc.player, 1.25)
	bullet_instance.position.y += 200
	print(bullet_instance)

func _health_changed(new_health):
	_damaged()
	health = new_health
	print(health)

func _damaged():
	modulate = Color.red
	immune = true
	$ImmuneCooldown.start()

func _pick_action():
	var size = ACTIONS.size()
	return randi() % size

func _on_ImmuneCooldown_timeout():
	if not dead:
		modulate = Color.white
		immune = false

func _on_ActionLoop_timeout():
	var action = _pick_action()
	perform_action(action)
