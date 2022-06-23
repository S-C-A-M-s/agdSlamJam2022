extends Area2D

export var speed = 700
export var damage = 5
export var steer_force = 75.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

func start(_transform, _target, _rotation):
	global_transform = _transform
	rotation += ( rand_range(-0.09, 0.09) + _rotation )
	velocity = transform.x * speed
	target = _target

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta

func _on_Projectile_body_entered(body):
	print(body)
	if body.is_in_group("mobs"):
		body.queue_free()
	if body.is_in_group("entity"):
		queue_free()
		if body.has_method("hit"):
			body.hit(damage)
 
