extends Area2D

class_name Projectile

export var speed = 700
export var damage = 5
export (String, FILE) var texture
export var texture_rotation: float
export var texture_scale: float = 0.1

var velocity := Vector2.ZERO

func init():
	velocity = Vector2(speed, 0).rotated(rotation)

func process(delta):
	pass

func hit(body):
	if body.is_in_group("entity"):
		damage(body)

func damage(body):
	queue_free()
	if body.has_method("hit"):
		body.hit(damage)

func _ready():
	$Texture.texture = load(texture)
	$Texture.rotation_degrees = texture_rotation
	$Texture.scale = Vector2(texture_scale, texture_scale)
	connect("body_entered", self, "_on_Projectile_body_entered")
	init()

func _physics_process(delta):
	process(delta)
	position += velocity * delta

func _on_Projectile_body_entered(body):
	hit(body)
 
