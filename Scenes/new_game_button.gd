extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	preload("res://Scenes/game/zero.tscn")
	pass # Replace with function body.

func _pressed():
	get_tree().change_scene_to_file("res://Scenes/game/zero.tscn")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
