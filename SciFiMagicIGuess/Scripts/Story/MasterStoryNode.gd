extends Node
# I can have the extends inheirt a sperate script not tied in the scene,
# from what I know about inheiritance this has to be useful
const choiceButtonReference = preload("res://Scenes/UX/ChoiceButton.tscn")

onready var actionContainer = get_owner().find_node("AdventureActions")
onready var masterStoryNode = get_owner().get_node("MasterStoryNode")
onready var adventureInterface = get_owner()
onready var textLog = get_owner().find_node("TextLog")

var testDict = {
	"Talk to the man": "Sandwich?",
	"Ignore the man, go to the city": "Die",
	
}

func _ready():
	
	pass
	
# warning-ignore:unused_argument
func introAnimationOver(anim_name):
	runSelf()
	pass
	
func runSelf():
	textLog.resetText("You approach an old man, he sits resolute on a flattened boulder next to the road. Not far is the city of Alcarann, which you peer in the distance.")
	option(testDict)
	pass

func option(buttonDictionary):
	for key in buttonDictionary:
#		print(key, " / ", buttonDictionary[key])
		createButton(key, key, buttonDictionary[key])
	pass

func createButton(name, text, data):
	var tempScene = choiceButtonReference.instance()  
	actionContainer.add_child(tempScene)
	var but = tempScene.get_child(0)
	but.name = name
	but.text = text
	but.data = data
	but.connect("buttonWasPressed", self, "interpretButton")


func interpretButton(data):

	clearOptions()
#	print(data)
	if(not is_instance_valid(data)):
		masterStoryNode.find_node(data).runSelf()
	else:
		masterStoryNode.get_node("DefaultNode").runSelf()
	
	pass 

func clearOptions():
	for margCon in actionContainer.get_children():
		if not margCon.is_in_group("DefaultChoiceButtons"):
			margCon.get_parent().remove_child(margCon)
	
#	for but in buttons:
#		if is_instance_valid(but["obj"]):
#			but["isThere"] = false
#			but["obj"].get_parent().remove_child(but["obj"])


