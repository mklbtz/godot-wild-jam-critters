class_name Bug extends RigidBody2D

@export var speed := 100

var caught := false

func _ready() -> void:
	contact_monitor = true
	gravity_scale = 0
	lock_rotation = true
	apply_central_impulse(
		Vector2(speed, 0)
	)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass


func _on_timer_timeout() -> void:
	if caught: return
	
	var current := linear_velocity
	apply_central_impulse(-current) # stop!
	var new = current.orthogonal().normalized() * speed
	apply_central_impulse(new)
