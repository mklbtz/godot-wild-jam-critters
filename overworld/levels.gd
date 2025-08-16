# I made this confusing this is a level trigger not a level
extends Area2D
signal on_level_start(int)

var complete = false
@export var level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if !complete:
		emit_signal("on_level_start", level)

func _on_level_complete(index: int) -> void:
	queue_free()
