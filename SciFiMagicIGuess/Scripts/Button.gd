extends Button

export var nextScene = ""
func _pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(nextScene)
	pass
