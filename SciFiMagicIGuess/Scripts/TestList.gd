extends VBoxContainer
const ItemScene = preload("res://Scenes/UX/Item.tscn")
var items = []

func _ready():
	
	#Must have leave option
	addItem("<- Back",1,"")
	var exitBut = items[0].get_node("HBoxContainer/Button")
	var actionButtons = get_owner().get_parent()
	#Yeah this works!!!!!
	exitBut.connect("pressed",actionButtons,"backToActionMenu")
	
	addItem("Rock",3,"Useable to distract or slightly damage enemies")
	addItem("Small Health Potion",2,"When drank, restores 50 HP")
	addItem("Small Mana Potion",4,"When drank, restores 50 MP")
	addItem("Torch",1,"Can lightup dark areas for a short time")
	addItem("Gun",1,"Wait, where'd you get that?")
	addItem("Bullet",30,"Bullet? does that go with the gun?")
	addItem("Corpses",93,"Oh my lord, what have you done? So many innocent lives! The humanity! Augh I can't bear it.'")
	
	
	
	
func addItem(name, num, desc):
	items.append(ItemScene.instance())

	
	if(not num == 1):
		items[items.size()-1].get_node("HBoxContainer/Button/MarginContainer/HBoxContainer/ItemHead").text = str(name)+" x"+str(num)
	else:
		items[items.size()-1].get_node("HBoxContainer/Button/MarginContainer/HBoxContainer/ItemHead").text = str(name)
	var descLabel = items[items.size()-1].get_node("HBoxContainer/Button/MarginContainer/HBoxContainer/ItemDesc")
	descLabel.text = str(desc)
	#descLabel.set_h_size_flags(SIZE_EXPAND_FILL)  
	#descLabel.set_v_size_flags(SIZE_EXPAND_FILL)  
	add_child(items[items.size()-1])
