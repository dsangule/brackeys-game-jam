class_name NPC extends Interactable

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "this_is_a_node_title"

func action() ->void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
