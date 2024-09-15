extends Node2D

@export var dialogue_resource: DialogueResource
@export var dialogue_resource2: DialogueResource
@export var dialogue_title: String = "zero"

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_title)
	DialogueManager.dialogue_ended.connect(spawnGlave)
	pass # Replace with function body.
	#
	
func spawnGlave(_something):
	var scene = preload("res://Assets/Prefabs/Glaive Warrior.tscn")
	var instance = scene.instantiate()
	instance.position = Vector2(200,200)
	add_child(instance)
#func switchScene(something):
	#pass
