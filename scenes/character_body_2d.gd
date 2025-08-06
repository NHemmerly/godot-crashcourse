extends CharacterBody2D

func _physics_process(delta):
	var direction = Vector2.ZERO
	var SPEED = 100
	#Gravity
	velocity.y += 2
	
	if Input.is_action_just_pressed("Up") && is_on_floor():
		velocity.y = -1 * SPEED
	elif Input.is_action_pressed("Left"):
		velocity.x = -1 * SPEED
	elif Input.is_action_pressed("Right"):
		velocity.x = 1 * SPEED
	elif Input.is_action_pressed("Down") && is_on_floor():
		velocity.y = 1 * SPEED
	else:
			velocity.x = 0
	
	
	
	move_and_slide()
