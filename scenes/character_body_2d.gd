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
	
	if !(0 <= position.x && position.x <= 1152):
		position.x = get_parent().get_node("Spawn").position.x
		position.y = get_parent().get_node("Spawn").position.y
	if !(0 <= position.y && position.y <= 648):
		position.x = get_parent().get_node("Spawn").position.x
		position.y = get_parent().get_node("Spawn").position.y
	
	move_and_slide()
