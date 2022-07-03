extends KinematicBody2D

class_name Entity

export var health: int setget _health_changed
export var invulnerable: bool
export var immune_time: float = 0.08

var immune: bool
var dead: bool

signal died

func hit(damage: int):
	if not immune or invulnerable:
		self.health -= damage

func _health_changed(new_health):
	if not get_tree() == null:
		if new_health < health:
			_damaged()
		else:
			_healed()
	health = new_health
	if health <= 0:
		_damaged()
		dead = true
		emit_signal("died")

func _damaged():
	modulate = Color.red
	immune = true
	var immune_timer := get_tree().create_timer(immune_time)
	immune_timer.connect("timeout", self, "_on_immune_timer_timeout")

func _healed():
	modulate = Color.green
	yield(get_tree().create_timer(immune_time), "timeout")
	modulate = Color.white

func _on_immune_timer_timeout():
	if not dead:
		modulate = Color.white
		immune = false
