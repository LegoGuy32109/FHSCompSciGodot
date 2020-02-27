extends Button
signal selectedMove(name)
var actionButtons
var moveName = "Unknown"

func emit():
	emit_signal("selectedMove",str(moveName))

func setText(moveName,low,high):
	self.moveName = moveName
	self.text = "  "+str(moveName)+" ["+str(low)+"-"+str(high)+"]"
	
func _enter_tree():
	actionButtons = get_tree().get_root().get_node("Combat/Actions/ActionButtons")
	#Connect being pressed with emiting it's own custom signal
	connect("pressed",self,"emit")
	#Connect the custom signal to ActionButtons
	connect("selectedMove",actionButtons,"attackWasPressed")

