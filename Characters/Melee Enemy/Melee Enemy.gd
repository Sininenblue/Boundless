extends movement_script

var direction : Vector2
var speed : int = 20
var weight : float = .2
var direction_change_frequency : float = 3

var health : int = 3
var target : KinematicBody2D = null

onready var direction_check = $DirectionCheck
onready var new_direction_timer = $NewDirectionTimer
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


func _on_NewDirectionTimer_timeout():
	new_direction_timer.start(rand_range(.5, direction_change_frequency))
	if randf() <= .6:
		direction = position.direction_to(position + Vector2(rand_range(-1,1),rand_range(-1,1)))
	else:
		direction = Vector2.ZERO
