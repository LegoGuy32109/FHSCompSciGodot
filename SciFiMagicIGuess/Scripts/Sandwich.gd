extends "res://Scripts/MasterStoryNode.gd"

func _ready():
	pass
	
func runSelf():
	print("Sandwich option")
	#Display, would you like a sandwich?
	binaryOption("Yes, I'd like a sandwich","I'm good","Uh","hm")

