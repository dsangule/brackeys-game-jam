extends CharacterBody2D

@onready var anim_tree = $AnimationTree

var direction = Vector2.ZERO

@export var speed = 3000.0
@export var patrolling_speed_modifier = 0.5
@export var max_patrol_radius = 100.0
@export var damage = 1

var player_in_area = false
var player

var isPatrolling = true
var speed_modifier = 1
var dead = false

var initial_pos
var target_pos

func _ready():
	dead = false
	initial_pos = position
	target_pos = position

func _physics_process(delta):
	if !dead:
		$Detection_area/CollisionShape2D.disabled = false
		direction = (target_pos-position).normalized()
		
		if player_in_area:
			target_pos = player.position
			isPatrolling = false
		else:
			if (target_pos-position).length() < 1 or get_slide_collision_count():
				var do_while = true
				while (target_pos-initial_pos).length() > max_patrol_radius or do_while:
					target_pos = initial_pos + Vector2(randf_range(-100.0, 100.0), randf_range(-100.0, 100.0))
					do_while = false
				isPatrolling = true
		
		# Movement
		if isPatrolling and (position-initial_pos).length() < max_patrol_radius:
			speed_modifier = patrolling_speed_modifier
		else:
			speed_modifier = 1
			
		velocity = direction * speed * speed_modifier * delta
		
		move_and_slide()
		
		# if (target_pos-position).length() > speed * delta:
			#position += (target_pos-position).normalized() * speed * delta
		#else:
			#position = target_pos
		
		update_anim_params()


func update_anim_params():
	anim_tree.set("parameters/conditions/isIdle", velocity == Vector2.ZERO)
	anim_tree.set("parameters/conditions/isMoving", velocity != Vector2.ZERO)
	
	if direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", direction)
		anim_tree.set("parameters/Walk/blend_position", direction)

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
