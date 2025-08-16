extends "res://overworld/CameraManager.gd"

func _on_level_start(level: int):
	var cam_name = "Level%sCam" % level
	cameras[cam_name].enabled = true
	cameras[name].enabled = false

func _on_level_complete(level: int):
	var cam_name = "Level%sCam" % level
	cameras[cam_name].enabled = false
	cameras[name].enabled = true
