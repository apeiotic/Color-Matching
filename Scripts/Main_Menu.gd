extends Control

@onready var SD_hover: AudioStreamPlayer2D = $Audio/Hover
@onready var SD_select: AudioStreamPlayer2D = $Audio/Select
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	SD_select.play()
	get_tree().quit()


func _on_play_pressed() -> void:
	SD_select.play()
	await SD_select.finished 
	get_tree().change_scene_to_file("res://UI/Scenes/level_switcher.tscn")


func _on_play_mouse_entered() -> void:
	SD_hover.play()


func _on_quit_mouse_entered() -> void:
	SD_hover.play()


func _on_settings_mouse_entered() -> void:
	SD_hover.play()
