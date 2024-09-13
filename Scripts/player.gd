extends CharacterBody2D

@onready var anim_tree = $AnimationTree

@export var speed = 300.0
var direction = Vector2.ZERO

var isMoving = false
var isAttacking = false

func _process(delta):
	update_anim_params()

func _physics_process(delta):
	velocity = Vector2()
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()	# doesn't work without this

func update_anim_params():
	anim_tree.set("parameters/conditions/isIdle", velocity == Vector2.ZERO)
	anim_tree.set("parameters/conditions/isMoving", velocity != Vector2.ZERO)
	anim_tree.set("parameters/conditions/isAttacking", Input.is_action_just_pressed("attack"))
	
	if direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", direction)
		anim_tree.set("parameters/Walk/blend_position", direction)
		anim_tree.set("parameters/Attack/blend_position", direction)
		

## Find the nearest actionable, if there is one
func check_nearest_actionable() -> void:
	var areas: Array[Area2D] = actionable_finder.get_overlapping_areas() 
	var shortest_distances : float = INF
	var next_nearest_actionables: Actionable = null
	for area in areas:
		var distances:float = area.global_position.distance_to(global_position)
		if distance<shortest_distance:
			shortest_distance = distance
			next_nearest_actionable = area
		if next_nearest_actionable != nearest_actionable or not is_instance_valid(next_nearest_actionable):
			nearest_actionable = next_nearest_actionable
			Events.emit_signal("nearest_actionable_changed", nearest_actionable)
	
