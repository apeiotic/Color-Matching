extends Node2D

@onready var text = $TextEdit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_body_3d_color(PlayerColor: Variant) -> void:
	text.text = PlayerColor
	pass # Replace with function body.
