extends Node2D
class_name HealthComponent

@export var MAX_HEALTH = 10.0
var health

func _ready():
	health = MAX_HEALTH

func damage(attack):
	health -= attack
	print("Took damage")
	
	if health <= 0:
		get_parent().queue_free()
