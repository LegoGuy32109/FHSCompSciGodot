extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal IwasPressed
onready var butPos = Vector2(get_position()+Vector2(22,13))
# Called when the node enters the scene tree for the first time.
func _ready():
	print("ButPos "+str(butPos))
# warning-ignore:return_value_discarded
	connect("IwasPressed", get_owner().find_node("Player"), "goTo")
	pass # Replace with function body.

func _pressed():
	emit_signal("IwasPressed",butPos)
#	emit_signal("")
#	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
