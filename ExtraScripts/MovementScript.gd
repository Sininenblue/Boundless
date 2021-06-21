class_name movement_script extends KinematicBody2D

var velocity : Vector2

func move_character(direction:Vector2, speed:float, weight:float):
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, weight)


func _physics_process(delta):
	velocity = move_and_slide(velocity)
