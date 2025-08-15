class_name Tongue extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var bug_sticker: PinJoint2D = $BugSticker
@onready var frog_spring: DampedSpringJoint2D = $"../FrogSpring"

enum Modes { stopped, shooting, catching }

var shoot_velocity := 400.0
var mode := Modes.stopped


func _ready() -> void:
	gravity_scale = 0
	bug_sticker.set_physics_process(false)
	visible = false
	freeze = true
	contact_monitor = false
	max_contacts_reported = 10


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if mode == Modes.stopped: 
		return
	elif mode == Modes.catching:
		pass
	elif mode == Modes.shooting:
		pass


func shoot():
	if mode == Modes.shooting: return
	mode = Modes.shooting
	visible = true
	freeze = false
	contact_monitor = true
	frog_spring.stiffness = 10
	frog_spring.damping = 0.1
	apply_central_impulse(
		Vector2(0, shoot_velocity)
	)


func catch(bug: Bug):
	if mode == Modes.catching: return
	print("Gotcha! %s" % bug)
	mode = Modes.catching
	#contact_monitor = false
	bug.caught = true
	bug_sticker.node_b = bug.get_path()
	frog_spring.stiffness = 80
	frog_spring.damping = 1.0


func stop():
	if mode == Modes.stopped: return
	print("Stopped")
	mode = Modes.stopped
	visible = false
	freeze = true
	contact_monitor = false

	bug_sticker.set_physics_process(false)
	var other = bug_sticker.node_b
	if other is Bug:
		print("Score!")
