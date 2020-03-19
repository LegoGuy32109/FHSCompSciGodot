extends TextureProgress
onready var labelText = get_parent().get_parent().get_node("EnemyHPStat")
export var maxHealth = 30
export var curHealth = 30
signal enemyDeath
func _ready():

# warning-ignore:return_value_discarded
	connect("enemyDeath",get_owner().get_node("Actions/ActionButtons"),"enemyDied")
	setLabel()
	pass
	
func dealDamage(d):
	#Check how much damage is actually dealt to enemy
	curHealth-=d
	setLabel()
	self.value = 100*(float(curHealth)/maxHealth)
	#print(self.value)
	if(curHealth <= 0):
		emit_signal("enemyDeath")
func setLabel():
	labelText.text = "HP "+str(curHealth)+" / "+str(maxHealth)+""
	pass
