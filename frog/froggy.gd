class_name Frog	extends CharacterBody2D

@export var speed := 150.0
@export var jump_velocity := 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var tongue: Tongue = $Tongue

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis(&"move_left", &"move_right")
	var shoot := Input.is_action_just_pressed(&"tongue")
	var jump := false # no jump yet

	set_animation_direction(direction, jump)

	if shoot:
		shoot_tongue()
	
	if not is_on_floor(): # no jump yet
		velocity += get_gravity() * delta

	velocity.x = direction * speed

	move_and_slide()


func stop_tongue():
	tongue.stop()


func shoot_tongue():
	tongue.shoot()


func set_animation_direction(direction: int, jump: bool):
	if direction > 0: # right
		sprite.flip_h = true
	elif direction < 0: # left
		sprite.flip_h = false

	# Play animations
	if is_on_floor() and not jump:
		if direction == 0:
			sprite.play(&"idle")
		else:
			sprite.play(&"move")
	else: 
		sprite.play(&"move") # jumping?


func _on_tongue_body_entered(body: Node) -> void:
	if body is Bug:
		tongue.catch(body)
	elif body == self:
		tongue.stop()
	else:
		print("huh?")
