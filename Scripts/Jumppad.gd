extends MeshInstance3D

@export var repel_strength = 15.0
var Player_Color = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("color", Callable(self, "ColorSaving"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ColorSaving(PlayerColor):
	Player_Color = PlayerColor
	print("this is from jumpad", Player_Color)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if Player_Color == "Lime":
			var repel_direction = global_transform.basis.y.normalized()
			var player_velocity = repel_direction * repel_strength
			body.velocity += player_velocity


func PlayerColor(PlayerColor: Variant) -> void:
	Player_Color = PlayerColor
	pass # Replace with function body.


func _on_character_body_3d_color(PlayerColor: Variant) -> void:
	Player_Color = PlayerColor
	pass # Replace with function body.
