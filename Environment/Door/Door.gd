extends Sprite

export var next_level : PackedScene

export var activated = false

func _activate():
	$AnimationPlayer.play("open")
	activated = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "open":
		$AnimationPlayer.play("Activated")


func _on_Detection_body_entered(body):
	if activated and "Player" in body.name:
		get_tree().change_scene_to(next_level)
