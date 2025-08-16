extends Camera2D

static var cameras = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	cameras[name] = self
