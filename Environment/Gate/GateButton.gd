extends Sprite

var gates = []
export var glow : Color

func _ready():
	$ButtonGlow.modulate = glow
	var children = get_children()
	for child in children:
		if "Gate" in child.name:
			child._set_glow(glow)
			gates.append(child)


func _on_Hitbox_area_entered(area):
	$AnimationPlayer.play("press")
	for gate in gates:
		if gate.activated:
			gate._deactivate()
		else:
			gate._activate()
