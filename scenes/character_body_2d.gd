extends CharacterBody2D

var direction = Vector2.ZERO
var SPEED = 100
var SCRAPE_SOUND = preload("res://scrape.mp3")
var tween = create_tween()

#Used to detect when the character lands
var was_in_air = !is_on_floor()

#Used to play through the audio instead of repeating the beginning
var stop_time = 0

#func fade_out(stream_player):
#	stream_player.volume

func moving_sound(move_sound):
	
	$AudioStreamPlayer2D/Timer.wait_time = move_sound.get_length()
	if stop_time >= move_sound.get_length():
		stop_time = 0
	
	if is_on_floor() && velocity.x != 0:
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = move_sound
			$AudioStreamPlayer2D.play(2)
			$AudioStreamPlayer2D/Timer.start()
	elif $AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stop()
		stop_time = move_sound.get_length() - $AudioStreamPlayer2D/Timer.time_left
		print(stop_time)

		
		
	#Land sounds
	#if is_on_floor() && was_in_air:
		#$AudioStreamPlayer2D.play(0.3)

func _physics_process(delta):
	
	#Gravity
	velocity.y += 2
	
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
	
	moving_sound(SCRAPE_SOUND)
	move_and_slide()
