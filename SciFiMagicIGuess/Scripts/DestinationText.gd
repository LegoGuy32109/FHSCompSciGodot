extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible_characters = 0
	pass # Replace with function body.

func display():
	timer.start()
	visible_characters = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func timerTimed():
	if visible_characters > 120:
		timer.stop()
	visible_characters = visible_characters + 1
	pass # Replace with function body.
