extends KinematicBody2D

var velocity : Vector2
var direction: Vector2
var speed : int = 300

var can_shoot : bool = true

export var health : int = 4

onready var hitbox = $Hitbox/CollisionShape2D
onready var arrow = $"player arrow"

func _input(event):
	if event.is_action_released("shoot") and can_shoot:
		Engine.time_scale = 1
		velocity = direction * speed
		
		arrow.visible = false
		can_shoot = false

func _physics_process(delta):
	animations()
	direction = position.direction_to(get_global_mouse_position())
	
	hitbox.disabled = velocity.abs().length() < 100
	
	if health <= 0:
		call_deferred("queue_free")
	
	arrow.look_at(get_global_mouse_position())
	
	
	# slowdown before shoot
	if Input.is_action_pressed("shoot") and can_shoot:
		$BodyAnimations.play("idle")
		arrow.visible = true
		Engine.time_scale = .1
	
	# decceleration
	velocity = velocity.linear_interpolate(Vector2.ZERO, .01)
	
	# collision and reflection
	var collision = move_and_collide(velocity * delta)
	if collision:
		$BodyAnimations.play("wall")
		can_shoot = true
		velocity = velocity.bounce(collision.normal)


func _on_Hurtbox_area_entered(area):
	health -= area.damage
	var knockback_direction = -position.direction_to(area.global_position)
	velocity += knockback_direction * area.knockback


func _on_Hitbox_area_entered(area):
	can_shoot = true
	
	var knockback_direction = -position.direction_to(area.global_position)
	velocity += knockback_direction * speed


func animations():
	rotation = velocity.angle()
	if velocity.abs().length() < 100:
		$BodyAnimations.play("idle")
	else:
		$BodyAnimations.play("shoot")
