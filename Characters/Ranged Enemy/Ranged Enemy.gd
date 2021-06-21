extends movement_script

var BULLET = preload("res://Combat/EnemyProjectile/EnemyProjectile.tscn")

var shoot_frequency : float = 2
onready var shoot_timer = $ShootTimer

func _physics_process(_delta):
	if target and is_instance_valid(target):
		arm.look_at(target.position)


func shoot():
	shoot_timer.start(rand_range(.7, shoot_frequency))
	if target:
		var bullet = BULLET.instance()
		bullet.transform = arm.global_transform
		get_parent().add_child(bullet)

func _on_ShootTimer_timeout():
	shoot()

