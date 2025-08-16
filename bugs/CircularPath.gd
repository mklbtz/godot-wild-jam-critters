extends PathFollow2D

@export var speed = 150  # Pixels per second

func _process(delta):
	progress_ratio += speed * delta / get_parent().curve.get_baked_length()
	# Optionally, if you want the object to rotate to match the path direction:
	# rotation = unit_rotation
