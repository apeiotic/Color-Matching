extends Control

@onready var hover: AudioStreamPlayer2D = $Node/Hover
@onready var select: AudioStreamPlayer2D = $Node/Select


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/tutorial_level.tscn")


func _on_level_1_pressed() -> void:
	select.play()
	await select.finished
	var loadingscreenL1 = load("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel1.tscn")
	get_tree().change_scene_to_packed(loadingscreenL1)


func _on_level_2_pressed() -> void:
	select.play()
	await select.finished
	var loadingscreenL2 = load("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel2.tscn")
	get_tree().change_scene_to_packed(loadingscreenL2)


func _on_level_3_pressed() -> void:
	select.play()
	await select.finished
	var loadingscreenL3 = load("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel3.tscn")
	get_tree().change_scene_to_packed(loadingscreenL3)


func _on_level_4_pressed() -> void:
	select.play()
	await select.finished
	var loadingscreenL4 = load("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel4.tscn")
	get_tree().change_scene_to_packed(loadingscreenL4)


func _on_level_5_pressed() -> void:
	select.play()
	await select.finished
	var loadingscreenL5 = load("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel5.tscn")
	get_tree().change_scene_to_packed(loadingscreenL5)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Scenes/Main_menu.tscn")


func _on_level_6_pressed() -> void:
	select.play()
	await select.finished
	var loadingscreenL6 = load("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel6.tscn")
	get_tree().change_scene_to_packed(loadingscreenL6)

func _on_level_1_mouse_entered() -> void:
	hover.play()
	

func _on_level_2_mouse_entered() -> void:
	hover.play()


func _on_level_3_mouse_entered() -> void:
	hover.play()


func _on_level_4_mouse_entered() -> void:
	hover.play()


func _on_level_5_mouse_entered() -> void:
	hover.play()


func _on_back_button_mouse_entered() -> void:
	hover.play()
