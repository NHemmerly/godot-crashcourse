extends Area2D

var draw_shop_box = false

func _draw() -> void:
	var SHOP_RECT = Rect2(Vector2($CollisionShape2D.position.x - floor($CollisionShape2D.shape.size.x/2), \
								$CollisionShape2D.position.y - floor($CollisionShape2D.shape.size.y/2)), \
					Vector2($CollisionShape2D.shape.size.x, \
							$CollisionShape2D.shape.size.y))
	if draw_shop_box:
		draw_rect(SHOP_RECT, Color("ALICE_BLUE"), false)
		
func _physics_process(_delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			if Input.is_action_just_pressed("interact"):
				print("open Shop :)")
			draw_shop_box = true
	if not bodies:		
		draw_shop_box = false
	
	queue_redraw()
			
	
