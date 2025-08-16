extends StaticBody2D

@export var threshold = 0
@onready var collider = $CollisionShape2D
@onready var frog = $"../../OverworldFrog"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if frog.strength > threshold:
		collider.disabled = true
