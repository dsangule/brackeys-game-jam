extends CharacterBody2D

@onready var anim_tree = $AnimationTree

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/InteractLabel"

@export var speed = 300.0
var direction = Vector2.ZERO

var isMoving = false
var isAttacking = false

func _ready():
	update_interactions()

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





# INTERACTION METHODS

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""
