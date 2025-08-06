extends CharacterBody2D

var direction = Vector2.ZERO
var SPEED = 100
var MOVE_SOUND = preload("res://scrape.mp3")
var tween = create_tween()

#func fade_out(stream_player):
#	stream_player.volume

func _physics_process(delta):
	
	var was_in_air = !is_on_floor()
	
	#Gravity
	velocity.y += 2
	
	#Move sounds
	if is_on_floor() && velocity.x != 0:
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = MOVE_SOUND
			$AudioStreamPlayer2D.play()
	else:
		$AudioStreamPlayer2D.stop()
		
	#Land sounds
	if is_on_floor() && was_in_air:
		$AudioStreamPlayer2D.play(0.3)
	
	if Input.is_action_just_pressed("Up") && is_on_floor():
		velocity.y = -1 * SPEED
	elif Input.is_action_pressed("Left"):
		velocity.x = -1 * SPEED
		$Sprite2D.flip_h = true
	elif Input.is_action_pressed("Right"):
		velocity.x = 1 * SPEED
		$Sprite2D.flip_h = false
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
