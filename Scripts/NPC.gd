class_name NPC extends Area2D

@export var interact_label = "none"
@export var interact_type = "Dialog"
@export var interact_value = "none"

@export var dialogue_resource: DialogueResource
@export var dialogue_npc_first: String = "npc_first"
@export var dialogue_npc_second: String = "npc_second"
#@export var dialogue_bug_first: String = "bug_first"
#@export var dialogue_bug_second: String = "bug_second"
#@export var dialogue_storm_first: String = "storm_first"
#@export var dialogue_storm_second: String = "storm_second"



func action() ->void:
	print("Player is interacting with NPC")
	#if(area.name == "Witch"):
	if(has_met_player == false):
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_npc_first)
	else:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_npc_second)
	interact_with_player()
		

#NPC checks whether it has interacted with the player beforehand or not
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
