extends Button


var data = "DefaultNode"
signal buttonWasPressed(dataStuff)

func _pressed():
	emit_signal("buttonWasPressed", data)
	pass
