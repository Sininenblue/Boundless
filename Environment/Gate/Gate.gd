extends Sprite

export var activated : bool = true

func _activate():
	activated = true
	$AnimationPlayer.play_backwards("fall")

func _deactivate():
	activated = false
	$AnimationPlayer.play("fall")

func _set_glow(glow):
	$GateGlow.modulate = glow
