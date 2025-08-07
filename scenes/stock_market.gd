extends Node2D

var conkScene = load("res://scenes/conk.tscn")

func _ready():
	var conk = conkScene.instantiate()
	add_child(conk)	
	conk.position = $spawn_right.position


func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			get_tree().change_scene_to_file("res://scenes/somethingstupid.tscn")
