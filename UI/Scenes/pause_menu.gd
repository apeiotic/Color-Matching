extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	Resume()
	


func _on_quit_button_pressed() -> void:
	get_tree().quit()
