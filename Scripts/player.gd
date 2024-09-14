extends CharacterBody2D

@onready var anim_tree = $AnimationTree

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/InteractLabel"
@onready var actionable_finder =  $"Interaction Components/InteractionArea"

var input_vector: Vector2 = Vector2.ZERO

@export var speed = 8000.0
var direction = Vector2.ZERO

var canMove = true
var canAttack = true

func _ready():
	update_interactions()
	DialogueManager.dialogue_ended.connect(setCanAttack) #returns a DialogueResource back idk why, but made the function to accept something
	DialogueManager.dialogue_ended.connect(setCanMove) #returns a DialogueResource back idk why, but made the function to accept something
	
func _process(delta):
	update_anim_params()

func _physics_process(delta):
	velocity = Vector2()
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction && canMove:
		velocity = direction * speed * delta
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()	# doesn't work without this

func update_anim_params():
	anim_tree.set("parameters/conditions/isIdle", velocity == Vector2.ZERO)
	anim_tree.set("parameters/conditions/isMoving", velocity != Vector2.ZERO)
	anim_tree.set("parameters/conditions/isAttacking", Input.is_action_just_pressed("attack") && canAttack)
	
	if direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", direction)
		anim_tree.set("parameters/Walk/blend_position", direction)
		anim_tree.set("parameters/Attack/blend_position", direction)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			if actionables[0].has_method("action") :
				actionables[0].action()
				canMove = false
				canAttack = false
			return
# PLAYER	( Important )

func player():
	pass



# INTERACTION METHODS

func _on_interaction_area_area_entered(area):
	#print("Entered area:", area.name)
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

func interact_with_npc(npc: Node):
	if npc is NPC:
		print("Calling npc interaction")
		npc.interact_with_player()  # Calls the NPC's interaction method

# Testing
func setCanMove(something): #returns a DialogueResource back idk why, but made the function to accept something
	canMove=true

func setCanAttack(something):
	canAttack=true
