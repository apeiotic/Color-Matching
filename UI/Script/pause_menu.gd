extends Control

@onready var hover: AudioStreamPlayer2D = $Sounds/Hover
@onready var select: AudioStreamPlayer2D = $Sounds/Select
@onready var settings_page: Control = $Settings_Page


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_page.hide()
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	Test_Esc()


func pause():
	get_tree().paused = true
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func Resume():
	get_tree().paused = false
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func Test_Esc():
	if Input.is_action_just_pressed("Esc") and !get_tree().paused:
		pause()
		
	elif Input.is_action_just_pressed("Esc") and get_tree().paused:
		Resume()


func _on_resume_button_pressed() -> void:
	select.play()
	Resume()
	

func _on_quit_button_pressed() -> void:
	select.play()
	get_tree().change_scene_to_file("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToMainMenu.tscn")




func _on_resume_button_mouse_entered() -> void:
	hover.play()


func _on_quit_button_mouse_entered() -> void:
	hover.play()


func _on_setting_button_mouse_entered() -> void:
	hover.play()


func _on_restart_button_pressed() -> void:
	select.play()
	Resume()
	get_tree().reload_current_scene()


func _on_restart_button_mouse_entered() -> void:
	hover.play()


func _on_setting_button_pressed() -> void:
	settings_page.show()
