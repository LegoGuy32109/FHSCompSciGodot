extends Button

export var nextScene = ""
func _pressed():
	get_tree().change_scene(nextScene)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
