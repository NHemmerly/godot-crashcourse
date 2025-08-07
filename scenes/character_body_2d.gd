extends CharacterBody2D

var direction = Vector2.ZERO
var SPEED = 100
var SCRAPE_SOUND = preload("res://scrape.mp3")
var tween = create_tween()

#Used to detect when the character lands
var was_in_air = !is_on_floor()

#Stores playback time whenever the audio is stopped
var stop_time = 0

#Called whenever stop_time >= the length of the audio 
func _on_timer_timeout() -> void:
	print("Timeout")
	stop_time = 0

#func fade_out(stream_player):
#	stream_player.volume

func moving_sound(move_sound):
	
	$AudioStreamPlayer2D/Timer.wait_time = move_sound.get_length()
	
	if is_on_floor() && velocity.x != 0:
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = move_sound
			$AudioStreamPlayer2D.play(stop_time)
			if $AudioStreamPlayer2D/Timer.paused:
				$AudioStreamPlayer2D/Timer.paused = false
			else:
				$AudioStreamPlayer2D/Timer.start()
	elif $AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stop()
		$AudioStreamPlayer2D/Timer.paused = true
		stop_time = move_sound.get_length() - $AudioStreamPlayer2D/Timer.time_left
		if stop_time >= move_sound.get_length():
			stop_time = 0

	#Land sounds
	#if is_on_floor() && was_in_air:
		#$AudioStreamPlayer2D.play(0.3)

func _physics_process(delta):
	
	#Gravity
	velocity.y += 2
	
	#Movement
	if Input.is_action_just_pressed("Up") && is_on_floor():
		velocity.y = -1 * SPEED
	if Input.is_action_pressed("Left"):
		velocity.x = -1 * SPEED
		$Conk.flip_h = true
	if Input.is_action_pressed("Right"):
		velocity.x = 1 * SPEED
		$Conk.flip_h = false
	if Input.is_action_pressed("Down") && is_on_floor():
		velocity.y = 1 * SPEED
	if !(Input.is_action_pressed("Right") || Input.is_action_pressed("Left")):
			velocity.x = 0
	
	
	
	#Rotation
	print(rotation_degrees)
	
	if is_on_floor():
		if (fmod(rotation_degrees, 90) < 2.0 && fmod(rotation_degrees, 90) > -2.0) && rotation != 0:
			if fmod(rotation_degrees, 90) > 0:
				rotation_degrees -= fmod(rotation_degrees, 90)
			elif fmod(rotation_degrees, 90) < 0:
				rotation_degrees += fmod(rotation_degrees, 90)
			#$Conk.rotation_degrees = 0
			#$CollisionShape2D.rotation_degrees = 0
			pass
		elif fmod(rotation_degrees, 90) < 0 && fmod(rotation, 90) != 0:
			rotation_degrees -= 2
			#$CollisionShape2D.rotation_degrees += 2
		elif fmod(rotation_degrees, 90) > 1 && fmod(rotation, 90) != 0:
			rotation_degrees += 2
			#$CollisionShape2D.rotation_degrees -= 2
	else:
		#$Conk.rotation_degrees += (velocity.y / 100)
		#$CollisionShape2D.rotation_degrees += (velocity.y / 100)
		rotation_degrees += (velocity.x / 100)
	
	#Spawn lock
	if !(0 <= position.x && position.x <= 1152):
		position.x = get_parent().get_node("Spawn").position.x
		position.y = get_parent().get_node("Spawn").position.y
	if !(0 <= position.y && position.y <= 648):
		position.x = get_parent().get_node("Spawn").position.x
		position.y = get_parent().get_node("Spawn").position.y
	
	moving_sound(SCRAPE_SOUND)
	move_and_slide()
