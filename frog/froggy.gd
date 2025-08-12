extends CharacterBody2D

@export var speed := 150.0
@export var jump_velocity := 300.0
@export var shoot_velocity := 80.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var tongue: CharacterBody2D = $Tongue
@onready var tongueTimer: Timer = $Tongue/Timer

func _ready() -> void:
	stop_tongue()


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis(&"move_left", &"move_right")
	var tongue: bool = Input.is_action_just_pressed(&"tongue")
	var jump: bool = false # no jump yet

	set_animation_direction(direction, jump)

	if tongue:
		shoot_tongue()
	
	if not is_on_floor(): # no jump yet
		velocity += get_gravity() * delta

	velocity.x = direction * speed

	move_and_slide()


func stop_tongue():
	tongue.visible = false
	tongue.process_mode = Node.PROCESS_MODE_DISABLED


func shoot_tongue():
	tongue.visible = true
	tongue.process_mode = Node.PROCESS_MODE_PAUSABLE
	tongue.velocity = Vector2.DOWN
	tongue.velocity.y *= shoot_velocity


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
