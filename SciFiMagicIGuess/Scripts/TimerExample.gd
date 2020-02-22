extends Node2D
signal iconLoaded

func _ready():
# warning-ignore:return_value_discarded
	$Timer.connect("timeout",self,"timerTimedOut")
	emit_signal("iconLoaded");
func timerTimedOut():
	$Sprite.visible = !$Sprite.visible
