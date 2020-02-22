extends Node2D

onready var actionMenu = get_node("ActionMenu")

const AttackMenuScene = preload("res://Scenes/AttackMenu.tscn")
var attackMenu

const ItemMenuScene = preload("res://Scenes/ItemMenu.tscn")
var itemMenu


func _ready():

	add_child(AttackMenuScene.instance())
	attackMenu = get_node("AttackMenu")
	#Scene hides when it enters
	
	#Ugh... I had to go through all the control nodes to reach the actual button
	attackMenu.get_node("MarginContainer/VBoxContainer/leaveBut").connect("leftAttackMenu", self, "backToActionMenu")
	
	add_child(ItemMenuScene.instance())
	itemMenu = get_node("ItemMenu")
	#Need to figure out how to get the leave button from items... oof
	#itemMenu.get_node("MarginContainer/Panel/ScrollContainer/MarginContainer/ListH/Item/BoxContainer/Button").connect("pressed", self, "backToActionMenu")
	
func backToActionMenu():
	attackMenu.hide()
	itemMenu.hide()
	get_node("ActionMenu").show()



func itemsButtonWasPressed():
	actionMenu.hide()
	itemMenu.show()


func attackButtonWasPressed():
	actionMenu.hide()
	attackMenu.show()
