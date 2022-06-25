extends Entity

export var default_speed := 450  # speed in pixels/sec
var speed: int
var velocity = Vector2.ZERO

onready var bullet := load("res://scenes/boss/projectiles/projectile.tscn")

func _ready():
	speed = default_speed

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

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print(rotation)
		_shoot()

func _shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = Vector2(position.x, position.y - 75)
	bullet_instance.rotation = rotation
	owner.add_child(bullet_instance)
