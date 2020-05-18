extends Button

signal leftAttackMenu

func _pressed():
	emit_signal("leftAttackMenu")
