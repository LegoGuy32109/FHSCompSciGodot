extends Node2D

onready var actionMenu = get_node("ActionMenu")

const AttackMenuScene = preload("res://Scenes/AttackMenu.tscn")
var attackMenu

const ItemMenuScene = preload("res://Scenes/ItemMenu.tscn")
var itemMenu

onready var textLog = get_owner().get_node("Log/TextLog")

onready var enemyHP = get_owner().get_node("Stats/MarginContainer/HBoxContainer2/MarginContainer2/VBoxContainer/EnemyHPStat/EnemyHealth")
onready var playerHP = get_owner().get_node("Stats/MarginContainer/HBoxContainer2/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HPStat/PlayerHealth")
onready var playerMP = get_owner().get_node("Stats/MarginContainer/HBoxContainer2/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/MPStat/PlayerMana")

var r = RandomNumberGenerator.new()
var attackDict = {}

#Used for no repition of textSkip
var introOver = false
var skirmishOver = false

func _ready():
	r.randomize()
	
	add_child(AttackMenuScene.instance())
	attackMenu = get_node("AttackMenu")
	#Scene hides when it enters
	#Ugh... I had to go through all the control nodes to reach the actual button
	attackMenu.get_node("MarginContainer/ScrollContainer/MoveList/leaveBut").connect("leftAttackMenu", self, "backToActionMenu")
	
	add_child(ItemMenuScene.instance())
	itemMenu = get_node("ItemMenu")
	# <- Back button has script in items that works different from attacks'.
	
	
	
	#Add attack moves, will update attack dictionary later in game
	attackDict["Rusty Sword"] = [4,8]
	attackDict["Fist"] = [1,5]
	attackDict["Flint Knife"] = [2,4]
#	print("Attack Dictonary")
#	print(attackDict)
	
	#Figured out how to add attack moves through a dictonary
	var moveList = attackMenu.get_node("MarginContainer/ScrollContainer/MoveList")
	for itemName in attackDict:
		moveList.addMove(itemName,attackDict[itemName][0],attackDict[itemName][1])
	
func backToActionMenu():
	attackMenu.hide()
	itemMenu.hide()
	get_node("ActionMenu").show()

#Function for finding damage value from the min and max in the attackDictonary
func findAttack(attackName):
	var attackMin = attackDict[attackName][0]
	var attackMax = attackDict[attackName][1]
	#Safety precaution
	if(attackMin > attackMax):
		var temp = attackMin
		attackMin = attackMax
		attackMax = temp
	var damage = r.randi_range(attackMin,attackMax)
#	print(damage)
	return damage
	
#Easier for new output of text log
func tl(out):
	textLog.text += "\n"+out
	pass
func t(out):
	textLog.text += " "+out
	pass
	
#Func called when attack button is pressed
func attackWasPressed(attackName):
#	print(str(attackDict[attackName][0])+" - "+str(attackDict[attackName][1]))
	if not skirmishOver:
		var damage = findAttack(attackName)
		tl("Sir John used his "+str(attackName)+"!")
		tl("Dealt "+str(damage)+" damage!")
		if(damage==attackDict[attackName][1]):
			t("CRITICAL HIT!!")
	
		#Subtracting enemy health
		
		enemyHP.dealDamage(damage)
	
	backToActionMenu()

#Enemy has died function
func enemyDied():
	#Randomize more death display options
	tl("The Goblin was vanquished!")
	tl("Let's get this bread XD")
	skirmishOver = true

#Function to skip text log and intro animations
func textSkip():
	if not introOver:
		textLog.get_parent().get_child(0).stop()
		textLog.percent_visible = 1
		enemyHP.get_parent().get_parent().get_node("AnimationPlayer").stop()
		enemyHP.value = 100;
		playerHP.value = 100;
		playerMP.value = 100;
		
		introOver = true
	
#Buttons into submenus
#Flee button changes Scene
func itemsButtonWasPressed():
	textSkip()

	actionMenu.hide()
	itemMenu.show()


func attackButtonWasPressed():
	textSkip()

	actionMenu.hide()
	attackMenu.show()
