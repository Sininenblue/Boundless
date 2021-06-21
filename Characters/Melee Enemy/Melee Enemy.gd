extends movement_script

func _physics_process(delta):
	if target and is_instance_valid(target):
		var target_angle = target.global_position.angle_to_point(global_position)
		arm.rotation = lerp_angle(arm.rotation, target_angle, .02)
