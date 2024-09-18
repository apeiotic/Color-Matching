extends MeshInstance3D

var repel_strength = 15.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		var repel_direction = global_transform.basis.y.normalized()
		var player_velocity = repel_direction * repel_strength
		body.velocity += player_velocity
	pass # Replace with function body.
