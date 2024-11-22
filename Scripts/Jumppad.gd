extends MeshInstance3D
@onready var JumpSound: AudioStreamPlayer2D = $Node3D/JumpSound


@export var repel_strength = 15.0
var Player_Color = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("color", Callable(self, "ColorSaving"))
	


func ColorSaving(PlayerColor):
	Player_Color = PlayerColor

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if Player_Color == "Lime":
			JumpSound.play()
			var repel_direction = global_transform.basis.y.normalized()
			var player_velocity = repel_direction * repel_strength
			body.velocity += player_velocity
			body.jumppadeffect()
			
		else: 
			body.NotSameColor()


func PlayerColor(PlayerColor: Variant) -> void:
	Player_Color = PlayerColor
	


func _on_character_body_3d_color(PlayerColor: Variant) -> void:
	Player_Color = PlayerColor
	
