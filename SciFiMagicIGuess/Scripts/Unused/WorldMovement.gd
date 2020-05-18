extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 300
onready var curLoc = Vector2(self.position)
onready var nextLoc = curLoc
onready var gap = Vector2()

var weMovin = false
var info = [false,false,false,"test desc xd"]

onready var locActions = get_node("LocationActions")
onready var actions = locActions.get_children()

onready var DestDisc = get_node("DestinationDescription")
onready var DestText = DestDisc.find_node("text")
var curDiscText = "test Discription :0"

func _ready():
	actionHide()
	# This doesn't work for some reason
#	locActions.hide()
	DestDisc.hide()
	
	pass 

func actionHide():
	for but in actions:
		print("Hiding "+str(but.name))
		but.hide()
		
func actionShow():
	for i in range(len(actions)):
		if info[i]:
#			print("Showing "+str(actions[i].name))
			actions[i].show()
			
func goTo(xy, newinfo):
	if not weMovin:
		weMovin = true
		# Options to display when reaching destination
		# Reset what's being shown
		info = newinfo
		actionHide()
		DestDisc.hide()
		
		# May turn info into a dictionary, i dunno it's very simple
		curDiscText = info[3]
		print("We movin!")
		nextLoc = xy
		print("Cur loc "+str(curLoc))
		print("Next loc "+str(nextLoc))

	pass

func investigate():
	print("investigating")
	actionHide()
	DestText.text = curDiscText
	DestDisc.show()
	DestText.display()
	pass

func discriptionEvent(event):
#	print(event)

	if event.is_action_pressed("mouseDown"):
		DestDisc.hide()
		actionShow()
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):

	if curLoc != nextLoc:
		set_position(nextLoc)
#		gap = Vector2(nextLoc - position)
## warning-ignore:return_value_discarded
#		move_and_slide(gap.normalized() * speed)
#
#		if gap.abs() < Vector2(5,5):
#			set_position(nextLoc)
#			weMovin = false
#			actionShow()
#	if position == nextLoc:
# warning-ignore:return_value_discarded
	# Player reached destination
#		move_and_slide(gap*0.1)
		
			
		curLoc = position
		


