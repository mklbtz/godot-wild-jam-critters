extends PathFollow2D

@export var SPEED = 180.0
var reverse_direction = false

func _process(delta: float) -> void:
	if reverse_direction:
		progress -= SPEED * delta
	else:
		progress += SPEED * delta

	if progress >= get_parent().curve.get_baked_length():
		reverse_direction = true
	elif progress <= 0:
		reverse_direction = false
