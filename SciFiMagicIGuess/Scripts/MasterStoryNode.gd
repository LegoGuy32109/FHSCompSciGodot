extends Node
# I can have the extends inheirt a sperate script not tied in the scene,
# from what I know about inheiritance this has to be useful
const choiceButtonReference = preload("res://Scenes/UX/ChoiceButton.tscn")

onready var actionContainer = get_owner().find_node("AdventureActions")
onready var masterStoryNode = get_owner().get_node("MasterStoryNode")


var button1 = {"obj": null, "isThere": false}
var button2 = {"obj": null, "isThere": false}
var button3 = {"obj": null, "isThere": false}
var button4 = {"obj": null, "isThere": false}

var buttons = [button1, button2, button3, button4]

var yesChoice
var noChoice

func _ready():
	
	pass

func runSelf():
	binaryOption("Yeah do it!","No, don't do it","Sandwich?","Die")
	pass

func binaryOption(yesWords="Yes",noWords="No",yesOption="",noOption=""):
	
	var yesBut
	var noBut
	
	yesChoice = self.find_node(yesOption)
	noChoice = self.find_node(noOption)
	
	# The 'for each' is easier to type, but it does loop unecessarily when 
	# the no button can be just the next sequential button
	
	for but in buttons:
		if not but["isThere"]:
			yesBut = createButton(but, "yesButton", yesWords, yesChoice)
			break
	for but in buttons:
		if not but["isThere"]:
			noBut = createButton(but, "noButton", noWords, noChoice)
			break


func createButton(but, name, text, data):
	var tempScene = choiceButtonReference.instance()  
	actionContainer.add_child(tempScene)
	but["obj"] = tempScene.get_child(0) 
	but["isThere"] = true
	but["obj"].name = name
	but["obj"].text = text
	but["obj"].data = data
	but["obj"].connect("buttonWasPressed", self, "interpretButton")
	return but["obj"]

# NO!! MAKE ONE PRESSED FUNCTION!!! Interpret information the button sends 
func interpretButton(data):
#	Data.name is the yesChoice/Option, as a stri ng. A little confused, but
#   I can take that to find destination of the next node in decision tree
#	print(data.name)
#	print(get_owner())
	clearOptions()
	if(is_instance_valid(data)):
		masterStoryNode.find_node(data.name).runSelf()
	else:
		masterStoryNode.get_node("DefaultNode").runSelf()
	
	pass

func clearOptions():
	for margCon in actionContainer.get_children():
		if not margCon.is_in_group("DefaultChoiceButtons"):
			margCon.get_parent().remove_child(margCon)
	
	for but in buttons:
		if is_instance_valid(but["obj"]):
			but["isThere"] = false
#			but["obj"].get_parent().remove_child(but["obj"])
