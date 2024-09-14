extends Node

# Initialize a global state variable
var has_met: bool = false

# Function to update the has_met state
func set_has_met(value: bool) -> void:
	has_met = value
