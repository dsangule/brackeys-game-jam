class_name NPC extends Interactable

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "this_is_a_node_title"
@export var dialogue_second: String = "second_time"



func action() ->void:
	print("Player is interacting with NPC")
	if(has_met_player == false):
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	else:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_second)
	interact_with_player()
		
#func interact_with_player():
	#print("NPC interaction logic here!")

###NPC checks whether it has interacted with the player beforehand or not
var has_met_player: bool = false  # Track if the player has interacted with this NPC

#Called when the player interacts with the NPC
func interact_with_player():
	if has_met():
		print("You've already met this NPC.")
	else:
		print("This is your first time meeting this NPC.")
		# Perform any actions related to the first-time meeting
		set_has_met()

# Check if the player has already met the NPC
func has_met() -> bool:
	return has_met_player

# Mark the NPC as 'met' by the player
func set_has_met() -> void:
	has_met_player = true
