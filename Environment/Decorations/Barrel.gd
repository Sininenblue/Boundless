extends Sprite

func _ready():
	if randf() < .5:
		self.frame = 0
	else:
		self.frame = 1
