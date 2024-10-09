extends Control


@onready var SD_hover: AudioStreamPlayer2D = $Audio/Hover
@onready var SD_select: AudioStreamPlayer2D = $Audio/Select

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_quit_pressed() -> void:
	SD_select.play()
	get_tree().quit()


func _on_play_pressed() -> void:
	SD_select.play()
	await (0.9)
	
	var loadingscreen = load("res://UI/Scenes/LoadingScreens/LS_MainToLevelSwitr.tscn")
	get_tree().change_scene_to_packed(loadingscreen)
	


func _on_play_mouse_entered() -> void:
	SD_hover.play()


func _on_quit_mouse_entered() -> void:
	SD_hover.play()


func _on_settings_mouse_entered() -> void:
	SD_hover.play()
