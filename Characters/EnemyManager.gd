extends Node2D

signal Enemies_Killed

var children = []
# Called when the node enters the scene tree for the first time.
func _ready():
	children = get_children()

func _dead(body):
	children.erase(body)
	if children.size() <= 0:
		emit_signal("Enemies_Killed")
