extends Position2D

export var speed : int = 90

func _physics_process(delta):
	position += (transform.x * speed) * delta


func _on_Hitbox_area_entered(_area):
	call_deferred("queue_free")


func _on_Hitbox_body_entered(body):
	call_deferred("queue_free")
