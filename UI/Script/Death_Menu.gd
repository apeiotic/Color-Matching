extends Control
@onready var hover: AudioStreamPlayer2D = $Node/Hover
@onready var select: AudioStreamPlayer2D = $Node/Select
@onready var settings_page: Control = $Settings_Page

var ComapairingCurrentLevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_page.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(ComapairingCurrentLevel)
	pass


func _on_restart_pressed() -> void:
	print(get_tree().current_scene)
	get_tree().reload_current_scene()
	


func _on_button_mouse_entered() -> void:
	hover.play()


func _on_button_2_mouse_entered() -> void:
	hover.play()


func _on_button_3_mouse_entered() -> void:
	hover.play()


func _on_main_menu_pressed() -> void:
	var LoadingMainMenu = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToMainMenu.tscn")
	get_tree().change_scene_to_packed(LoadingMainMenu)


func _on_settings_pressed() -> void:
	settings_page.show()
