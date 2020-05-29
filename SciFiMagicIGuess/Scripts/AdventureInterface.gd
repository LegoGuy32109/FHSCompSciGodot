extends Node2D

const ItemMenuScene = preload("res://Scenes/UX/ItemMenu.tscn")
onready var itemMenu = get_node("Items/ItemMenu")

onready var actionContainer = find_node("AdventureActions")
onready var items = find_node("Items")
onready var masterStoryNode = find_node("MasterStoryNode")

func _ready():


	DefaultButs(false)  
	pass # Replace with function body.

func DefaultButs(showButs=true):
	if showButs:
		for child in actionContainer.get_children():
			if child.name == "AttackContainer" or child.name == "InvestigateContainer" or child.name == "ItemsContainer" or child.name == "RestContainer":
				child.show()
	else:
		for child in actionContainer.get_children():
			if child.name == "AttackContainer" or child.name == "InvestigateContainer" or child.name == "ItemsContainer" or child.name == "RestContainer":
				child.hide()
	
	# I'm having the story start at the end of the ready function, hope that helps
	masterStoryNode.runSelf()

func rest(): 
	#Show a background of party sleeping and animate it's opacity from 0 to 100
	#hold it for a while, display 'Party is now well rested' refill stats,
	#and then 100 to 0, hide. 
	pass

func attack():
	# May need to add as a child instead, to change variables like inventory and enemies
	get_tree().change_scene("res://Scenes/Combat.tscn")

func itemsPressed():
	items.popup()
	
func closeItemsPopup():
	items.hide()
