extends Button
signal selectedMove(name)
var actionButtons
var moveName = "Unknown"

func emit():
	emit_signal("selectedMove",str(moveName))

# warning-ignore:shadowed_variable
func setText(moveName,low,high):
	self.moveName = moveName
	self.text = "  "+str(moveName)+" ["+str(low)+"-"+str(high)+"]"
	
func _enter_tree():
	actionButtons = get_tree().get_root().get_node("Combat/Actions/ActionButtons")
	#Connect being pressed with emiting it's own custom signal
# warning-ignore:return_value_discarded
	connect("pressed",self,"emit")
	#Connect the custom signal to ActionButtons
# warning-ignore:return_value_discarded
	connect("selectedMove",actionButtons,"attackWasPressed")

