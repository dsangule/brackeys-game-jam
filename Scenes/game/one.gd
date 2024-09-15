extends Node2D

@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "zero"

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_title)
	#DialogueManager.dialogue_ended.connect(switchScene)
	pass # Replace with function body.
	#
#func switchScene(something):
	#pass
