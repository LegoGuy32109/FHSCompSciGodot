extends Node2D
#export var attackMoveLoc = ""
#Work on establishing export var later
signal attackSceneEntered
const AttackMenuScene = preload("res://Scenes/UX/AttackMenu.tscn")
	


func _on_AttackBut_toggled(button_pressed):
	emit_signal("attackSceneEntered")
	add_child(AttackMenuScene.instance())

