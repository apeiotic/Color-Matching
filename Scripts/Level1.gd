extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass

#death
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Levels/test_scene.tscn")
	pass # Replace with function body.
func _on_world_border_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Levels/test_scene.tscn")
	pass # Replace with function body.


#finsih line reached
func Finish_Line_reached(body: Node3D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Levels/MainLevels/level4.tscn")
