extends Node2D

onready var actionMenu = get_node("ActionMenu")
onready var blockPlayer = get_parent().get_node("BlockPlayer")
const AttackMenuScene = preload("res://Scenes/AttackMenu.tscn")
var attackMenu

const ItemMenuScene = preload("res://Scenes/ItemMenu.tscn")
var itemMenu

onready var textLog = get_owner().get_node("Log/TextLog")

#Possibly going to need enemy party container like below
onready var enemyHP = get_owner().find_node("EnemyHealth")

#Variables for magic and life bars of player party
onready var partyContainer = get_owner().find_node("PartyContainer")

onready var enemyPlayer = get_owner().find_node("EnemyAnimator")

var r = RandomNumberGenerator.new()
var attackDict = {}
#Temp for testing purposes
var enemyAttackDict = {"Sharp Metal":[0,4]}
#Used for no repition of textSkip
var introOver = false
var skirmishOver = false

func _ready():
	r.randomize()
	
	add_child(AttackMenuScene.instance())
	attackMenu = get_node("AttackMenu")
	#Scene hides when it enters
	#Ugh... I had to go through all the control nodes to reach the actual button
	attackMenu.find_node("leaveBut").connect("leftAttackMenu", self, "backToActionMenu")
	
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
	var moveList = attackMenu.find_node("MoveList")
	for itemName in attackDict:
		moveList.addMove(itemName,attackDict[itemName][0],attackDict[itemName][1])
	
func backToActionMenu():
	attackMenu.hide()
	itemMenu.hide()
	get_node("ActionMenu").show()

#Function for finding damage value from the min and max in the attackDictonary
func findAttack(attackName,dict):
	var attackMin = dict[attackName][0]
	var attackMax = dict[attackName][1]
	#Safety precaution
	if(attackMin > attackMax):
		var temp = attackMin
		attackMin = attackMax
		attackMax = temp
	var damage = r.randi_range(attackMin,attackMax)
#	print(damage)
	return damage

func findEnemyAttack():
	r.randomize()
	#Choose attack
	var attackName = "Sharp Metal"
	#Chose which character to attack
	var charIndex = r.randi_range(0,( len( partyContainer.get_children() )-1 ))
	#Char attacked is a marginContainer
	var charAttacked = partyContainer.get_child(charIndex)
	#Find damage in neutral findAttack method
	enemyPlayer.play("EnemyAttack")
	yield(enemyPlayer,"animation_finished")
	
	var damage = findAttack(attackName,enemyAttackDict)
	charAttacked.find_node("Health").dealDamage(damage)
	tl("Scraplin used "+str(attackName)+" dealing "+str(damage)+" to "+str(charAttacked.find_node("Name").text))
	blockPlayer.visible = false
	
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
		var damage = findAttack(attackName,attackDict)
		tl("== Player Turn ==")
		tl("Sir John used his "+str(attackName)+"!")
		tl("Dealt "+str(damage)+" damage!")
		if(damage==attackDict[attackName][1]):
			t("CRITICAL HIT!!")
	
		#Subtracting enemy health
		
		enemyHP.dealDamage(damage)
		if enemyHP.value > 0:
			#Stop control
			blockPlayer.visible = true
			#yield enemy took damage/doged
			enemyPlayer.play("EnemyHurt")
			yield(enemyPlayer,"animation_finished")
			tl("-- Enemy Turn --")
			#Enemy move
			#yield enemy attack anim - may fit in findEnemyAttack
			#can fit in weapon through param later v
			var enemyDamage = findEnemyAttack()
			#yield character anim had damage dealt - may be in their Health dealDamage method
			#Give back control
			#blockPlayer.visible = false
		
		
		
	backToActionMenu()

#Enemy has died function
func enemyDied():
	#Randomize more death display options
	enemyPlayer.play("EnemyDied")
	tl("The Scraplin was vanquished!")
	tl("Let's get this bread XD")
	get_node("BattleTheme").stop()
	get_node("VictoryMusic").play()
	skirmishOver = true

#Function to skip text log and intro animations
func textSkip():
	if not introOver:
		textLog.get_parent().get_child(0).stop()
		textLog.percent_visible = 1
		enemyHP.get_parent().get_parent().get_node("EnemyAnimator").stop()
		enemyHP.value = 100;
		# GENIUS
		for player in partyContainer.get_children():
			#Not sure how to specify 'PartyMember' type but this works for now
			if player is MarginContainer:
				player.find_node("CharAnimator").stop()
				player.find_node("Health").value = 100;
				player.find_node("Magic").value = 100;
		
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
