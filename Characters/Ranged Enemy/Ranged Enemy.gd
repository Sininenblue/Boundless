extends movement_script

var BULLET = preload("res://Combat/EnemyProjectile/EnemyProjectile.tscn")

var direction : Vector2
var speed : int = 50
var weight : float = .3
var direction_change_frequency : float = 3

var health : int = 3
var target : KinematicBody2D = null

var shoot_frequency : float = 2
onready var shoot_timer = $ShootTimer

onready var new_direction_timer = $NewDirectionTimer
onready var direction_check = $DirectionCheck
onready var arm = $Arm

func _ready():
	randomize()

func _physics_process(delta):
	move_character(direction, speed, weight)
	
	if health <= 0:
		call_deferred("queue_free")
	
	if target and is_instance_valid(target):
		arm.look_at(target.position)
	
	#checks direction and changes if it collides with something
	if direction_check.is_colliding():
		direction = -direction
		direction_check.cast_to = direction * 10
	else:
		direction_check.cast_to = direction * 10

#this is unique
func shoot():
	shoot_timer.start(rand_range(.7, shoot_frequency))
	if target:
		var bullet = BULLET.instance()
		bullet.transform = arm.global_transform
		get_parent().add_child(bullet)



func _on_NewDirectionTimer_timeout():
	new_direction_timer.start(rand_range(.5, direction_change_frequency))
	if randf() <= .6:
		direction = position.direction_to(position + Vector2(rand_range(-1,1),rand_range(-1,1)))
	else:
		direction = Vector2.ZERO

#this is unique
func _on_ShootTimer_timeout():
	shoot()


func _on_Hurtbox_area_entered(area):
	health -= area.damage
	var knockback_direction = -position.direction_to(area.global_position)
	velocity += knockback_direction * area.knockback


func _on_TargetDetection_body_entered(body):
	if "Player" in body.name:
		target = body 


