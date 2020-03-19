extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 300
onready var curLoc = Vector2(self.position)
onready var nextLoc = curLoc
onready var gap = Vector2()

var weMovin = false
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Cur loc "+str(curLoc))
	pass # Replace with function body.


func goTo(xy):
	weMovin = true
	print("We movin!")
	nextLoc = xy
	print("Cur loc "+str(curLoc))
	print("Next loc "+str(nextLoc))
#	gap = Vector2(nextLoc - curLoc)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
#	print("Cur loc "+str(curLoc))
#	print("Next loc "+str(nextLoc))
#	print(curLoc != nextLoc)
	if curLoc != nextLoc:
		gap = Vector2(nextLoc - position)
# warning-ignore:return_value_discarded
		move_and_slide(gap.normalized() * speed)

		if gap.abs() < Vector2(10,10):
			set_position(nextLoc)
	if position == nextLoc:
# warning-ignore:return_value_discarded
		move_and_slide(gap*0.1)
	
	curLoc = position
		
