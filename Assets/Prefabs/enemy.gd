extends CharacterBody2D

@onready var anim_tree = $AnimationTree

var direction = Vector2.ZERO

var speed = 50
var damage

var health = 100
var dead = false

var player_in_area = false
var player

#temp
var initial_pos

func _ready():
	dead = false
	initial_pos = position

func _physics_process(delta):
	if !dead:
		$Detection_area/CollisionShape2D.disabled = false
		direction = velocity.normalized()
		
		if player_in_area:
			position += (player.position - position) / speed
		else:
			position += initial_pos * randf_range(-2.0, 2.0)
		
		update_anim_params()


func update_anim_params():
	anim_tree.set("parameters/conditions/isIdle", velocity == Vector2.ZERO)
	anim_tree.set("parameters/conditions/isMoving", velocity != Vector2.ZERO)
	
	if direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", direction)
		anim_tree.set("parameters/Walk/blend_position", direction)


func _on_detection_area_body_entered(body):
	pass # Replace with function body.


func _on_detection_area_body_exited(body):
	pass # Replace with function body.
