extends RichTextLabel

signal textComplete
var awaiting = false

func _ready():
	pass
	
func resetText(text):
	self.visible_characters = 0
	self.text = text
	
# warning-ignore:unused_argument
func _process(delta):
	if self.percent_visible < 100:
		self.visible_characters += 1
	if self.percent_visible == 100:
	#send some signal that text is complete to masterStoryNode
		pass

func continuePressed():
	self.visible_characters = 200
	pass # Replace with function body.
