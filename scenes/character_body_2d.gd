extends CharacterBody2D

var GRAVITY_FLIP = false
var GRAVITY = -2

func _physics_process(delta):
	var direction = Vector2.ZERO
	var SPEED = 200
	#Gravity
	if GRAVITY_FLIP:
		velocity.y += GRAVITY
	else:
		velocity.y += -GRAVITY
	
	if Input.is_action_just_pressed("Up"):
		GRAVITY_FLIP = true
		velocity.y = -1 * SPEED
	if Input.is_action_pressed("Left"):
		velocity.x = -1 * SPEED
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("Right"):
		velocity.x = 1 * SPEED
		$Sprite2D.flip_h = false
	if Input.is_action_just_pressed("Down"):
		GRAVITY_FLIP = false
		velocity.y = 1 * SPEED
	if !(Input.is_action_pressed("Left") || Input.is_action_pressed("Right")):
		velocity.x = 0
		
	if velocity.y >= 0:
		$Sprite2D.flip_v = false
	else: 
		$Sprite2D.flip_v = true
	
	if !(0 <= position.x && position.x <= 1152):
		position.x = get_parent().get_node("Spawn").position.x
		position.y = get_parent().get_node("Spawn").position.y
	if !(0 <= position.y && position.y <= 648):
		position.x = get_parent().get_node("Spawn").position.x
		position.y = get_parent().get_node("Spawn").position.y
	
	move_and_slide()
