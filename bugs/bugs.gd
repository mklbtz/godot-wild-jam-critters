extends CharacterBody2D

@export var speed := 170

func _physics_process(delta: float) -> void:
	velocity.x = 1 * speed
	move_and_slide()
