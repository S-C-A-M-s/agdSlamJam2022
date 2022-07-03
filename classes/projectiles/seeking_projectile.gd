extends Projectile
class_name SeekingProjectile

export var steer_force = 75.0

var acceleration = Vector2.ZERO
var target: Node

func init():
	rotation += ( rand_range(-0.09, 0.09) )
	velocity = transform.x * speed

func process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer
