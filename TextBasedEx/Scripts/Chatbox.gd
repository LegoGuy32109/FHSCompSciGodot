extends Label

var drawTextSpeed: int = 0
var chatterLimit: int = 900

func _ready():
	pass

func showChatter():
	if drawTextSpeed < chatterLimit:
		drawTextSpeed+=1
		self.visible_characters = drawTextSpeed
	pass
func _process(delta):
	showChatter()
	pass
