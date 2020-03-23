extends TextureButton

export var attack = false
export var investigate = false
export var rest = false
# Add image to display for investigate
export var investText = "The area is like this..."

onready var info = [attack, investigate, rest, investText]
signal IwasPressed
onready var butPos = Vector2(get_position()+Vector2(22,13))
# Called when the node enters the scene tree for the first time.
func _ready():
#	print("ButPos "+str(butPos))
	# Only works with player kinematic body in scene
# warning-ignore:return_value_discarded
	connect("IwasPressed", get_owner().find_node("Player"), "goTo")
	pass # Replace with function body.

func _pressed():
	emit_signal("IwasPressed",butPos, info)
#	emit_signal("")
#	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
