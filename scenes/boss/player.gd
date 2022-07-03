extends Entity

export var default_speed := 450  # speed in pixels/sec
export var default_attack_cooldown := 0.02
var speed: int
var attack_cooldown
var velocity = Vector2.ZERO

var attack_pressed: bool
var in_cooldown: bool

onready var bullet := load("res://scenes/boss/projectiles/projectile.tscn")

func _ready():
	speed = default_speed
	attack_cooldown = default_attack_cooldown

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _process(delta):
	if attack_pressed and not in_cooldown:
		_shoot()
		_attack_cooldown()
		attack_pressed = false

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _attack_cooldown():
	in_cooldown = true
	yield(get_tree().create_timer(attack_cooldown), "timeout")
	in_cooldown = false

func _input(event):
	if event.is_action_pressed("ui_accept"):
		attack_pressed = true

func _shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = Vector2(position.x, position.y - 75)
	bullet_instance.rotation = rotation
	owner.add_child(bullet_instance)
