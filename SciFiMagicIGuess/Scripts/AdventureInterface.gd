extends Node2D

const ItemMenuScene = preload("res://Scenes/UX/ItemMenu.tscn")
onready var itemMenu = get_node("Items/ItemMenu")

onready var actionContainer = find_node("AdventureActions")
onready var items = find_node("Items")
# Called when the node enters the scene tree for the first time.
func _ready():


#	for child in actionContainer.get_children():
#		child.hide()
	pass # Replace with function body.


func attack():
	# May need to add as a child instead, to change variables like inventory and enemies
	get_tree().change_scene("res://Scenes/Combat.tscn")

func itemsPressed():
	items.popup()
	
func closeItemsPopup():
	items.hide()
