extends Control
@onready var hover: AudioStreamPlayer2D = $Audio/Hover
@onready var select: AudioStreamPlayer2D = $Audio/Select


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gameplay_mouse_entered() -> void:
	hover.play()


func _on_graphics_mouse_entered() -> void:
	hover.play()


func _on_sound_mouse_entered() -> void:
	hover.play()
