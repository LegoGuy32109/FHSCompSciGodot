extends VBoxContainer

const partyMemberScene = preload("res://Scenes/PartyMember.tscn")
var player
var char1
var char2

#These might be unesscessary?
#onready var playerStats = get_node("PartyMember/PartyMemberStats")
#onready var playerHealth = playerStats.get_node("VBoxContainer3/HBoxContainer/VBoxContainer/Health")
#onready var playerHealthLabel = playerStats.get_node("VBoxContainer3/HBoxContainer/VBoxContainer/HPLabel")

func _ready():
	var godotLogo = load("res://icon.png")
	var johnHappy = load("res://Assets/SpriteArt/sirJonFaces/johnHappy.png")
	var johnHurt = load("res://Assets/SpriteArt/sirJonFaces/johnHurt.png")
	var johnSad = load("res://Assets/SpriteArt/sirJonFaces/johnSad.png")
	add_child(partyMemberScene.instance())
	add_child(partyMemberScene.instance(),true)
	add_child(partyMemberScene.instance(),true)
	# Weird naming conventions, fixed by putting true on add child. @PartyMember@3 stuff
	player = get_node("PartyMember")
	char1 = get_node("PartyMember2")
	char2 = get_node("PartyMember3")

	char1.find_node("Name").text = "Depressed John"
	char2.find_node("Name").text = "Constipated John"
	
	player.find_node("CharacterIcon").set_texture(johnHappy)
	char1.find_node("CharacterIcon").set_texture(johnSad)
	char2.find_node("CharacterIcon").set_texture(johnHurt)
	pass
