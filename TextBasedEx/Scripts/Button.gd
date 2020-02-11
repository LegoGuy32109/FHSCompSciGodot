extends Button
export var nextScene = ""
func _pressed():
	get_tree().change_scene(nextScene)
	pass
