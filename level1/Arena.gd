extends Node2D

@export var level_id: int = 1
signal on_level_complete(int)
@export var BUGS = 0
var bugs_eaten = 0

func _process(delta: float) -> void:
	if bugs_eaten == BUGS:
		emit_signal("on_level_complete", level_id)
