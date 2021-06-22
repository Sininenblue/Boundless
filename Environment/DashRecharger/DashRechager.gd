extends Sprite


func _ready():
	$AnimationPlayer.play("activated")



func _on_RespawnTimer_timeout():
	$AnimationPlayer.play("activated")


func _on_Hitbox_body_entered(body):
	if "Player" in body.name:
		$AnimationPlayer.play("deactivated")
		$RespawnTimer.start()
		body.can_shoot = true
