extends KinematicBody2D

export var speed = 450  # speed in pixels/sec
var velocity = Vector2.ZERO

onready var bullet := load("res://scenes/boss/projectile.tscn")

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
		_shoot()

func _shoot():
	var bullet_instance = bullet.instance()
	owner.add_child(bullet_instance)
	bullet_instance.start(transform, null, 0)
	bullet_instance.position.y -= 80
	print(bullet_instance)
