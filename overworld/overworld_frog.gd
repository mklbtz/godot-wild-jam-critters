extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -400.0
var disable_input = false
@onready var animated_sprite = $AnimatedSprite2D
var strength = 1

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var up_direction := Input.get_axis("ui_up", "ui_down")
	
	if disable_input: 
		return
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#play animations
	if direction == 0 && up_direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	# applies to movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if up_direction:
		velocity.y = up_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _on_level_start(level: int):
	disable_input = true

func _on_level_complete(level: int):
	strength += 1
	disable_input = false
