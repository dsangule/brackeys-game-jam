extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

@export var speed = 300.0

var isMoving = false
var direction = "none"

func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y -= speed
		isMoving = true
		direction = "up"
	if Input.is_action_pressed("down"):
		velocity.y += speed
		isMoving = true
		direction = "down"
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		isMoving = true
		direction = "left"
	if Input.is_action_pressed("right"):
		velocity.x += speed
		isMoving = true
		direction = "right"
	if velocity == Vector2.ZERO:
		isMoving = false
	
	move_and_slide()	# doesn't work without this
	
	if isMoving == true:
		if direction == "up":
			anim.play("walk_up")
		elif direction == "down":
			anim.play("walk_down")
		elif direction == "left":
			anim.play("walk_left")
		elif direction == "right":
			anim.play("walk_right")
		
	elif isMoving == false:
		if direction == "up":
			anim.play("idle_up")
		elif direction == "down":
			anim.play("idle_down")
		elif direction == "left":
			anim.play("idle_left")
		elif direction == "right":
			anim.play("idle_right")
