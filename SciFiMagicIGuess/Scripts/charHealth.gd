extends TextureProgress
onready var labelText = get_parent().get_child(0)
export var maxHealth = 50
export var curHealth = 50
signal charDied
func _ready():
#	print(get_owner().get_node("Actions/ActionButtons").name)
## warning-ignore:return_value_discarded
#	connect("enemyDeath",get_owner().get_node("Actions/ActionButtons"),"enemyDied")
#	setLabel()
	pass
	
func dealDamage(d):
	#Check how much damage is actually dealt to enemy
	curHealth-=d
	setLabel()
	self.value = 100*(float(curHealth)/maxHealth)
	#print(self.value)
	if(curHealth <= 0):
		emit_signal("charDied")
func setLabel():
	labelText.text = "HP "+str(curHealth)+" / "+str(maxHealth)+""
	pass
