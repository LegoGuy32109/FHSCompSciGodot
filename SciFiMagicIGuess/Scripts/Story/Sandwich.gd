extends "res://Scripts/Story/MasterStoryNode.gd"

func _ready():
	testDict = {
		"Yes, I'd like a sandwich": "Sandwich?",
		"I'm good": "Die",
		
	}
	pass
	
func runSelf():
	print("Sandwich option")
	#Display, would you like a sandwich?
	textLog.text = "Would you like a sandwich friend?"
#	binaryOption("Yes, I'd like a sandwich","I'm good","Uh","hm")
	option(testDict)

