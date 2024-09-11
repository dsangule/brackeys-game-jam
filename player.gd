extends CharacterBody2D

var speed = 300.0

func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	if Input.is_action_pressed("down"):
		velocity.y += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
	
	move_and_slide()	# doesn't work without this
	look_at(get_global_mouse_position())	# just for sprite rotation
