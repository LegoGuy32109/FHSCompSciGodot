extends VBoxContainer

const attackMoveScene = preload("res://Scenes/UX/AttackMove.tscn")
var attackMove

func _ready():
	# Kind of thinking you only have 3 attacks at a time
#	addMove("Sword",10,14)
#	addMove("Fist",1,5)
#	addMove("Gun",0,100)
	#Each button added connects to ActionButtons script	
	pass
	
func addMove(moveName,low,high):
	attackMove = attackMoveScene.instance()
	add_child(attackMove)
	attackMove.setText(moveName,low,high)
	#attackMenu.text = "  "+str(moveName)+" ["+str(low)+"-"+str(high)+"]"
	
	#Puts moves in a list above back button
	move_child(attackMove, get_child_count()-2)
