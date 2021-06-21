class_name movement_script extends KinematicBody2D

var velocity : Vector2
var direction : Vector2
var target : KinematicBody2D = null


export var speed : int = 50
export var weight : float = .3
export var direction_change_frequency : float = 3
export var health : int = 3


onready var new_direction_timer = $NewDirectionTimer
onready var direction_check = $DirectionCheck
onready var arm = $Arm

func _ready():
	randomize()
	
	new_direction_timer.connect("timeout", self, "_on_NewDirectionTimer_timeout")
	$Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")
	$TargetDetection.connect("body_entered",self,"_on_TargetDetection_body_entered")


func _physics_process(_delta):
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, weight)
	velocity = move_and_slide(velocity)
	
	if health <= 0:
		call_deferred("queue_free")
	
	
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


func _on_Hurtbox_area_entered(area):
	health -= area.damage
	var knockback_direction = -position.direction_to(area.global_position)
	velocity += knockback_direction * area.knockback


func _on_TargetDetection_body_entered(body):
	if "Player" in body.name:
		target = body 
