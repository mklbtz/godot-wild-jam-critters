extends CharacterBody2D

@export var speed := 150.0
@export var jump_velocity := 300.0
@export var shoot_velocity := 80.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var left = Input.is_action_pressed(&"move_left")
	var right = Input.is_action_pressed(&"move_right")
	var tongue = Input.is_action_just_pressed("tongue")
	var jump = false
	var direction = 0
	
	if right:
		sprite.flip_h = true
		direction = 1
	elif left:
		sprite.flip_h = false
		direction = -1

	# Play animations
	if is_on_floor() and not jump:
		if left or right:
			sprite.play("move")
		else:
			sprite.play("idle")
	
	# Apply movement
	if left or right:
		velocity.x = direction * speed
	else:
		velocity.x = 0

	move_and_slide()
