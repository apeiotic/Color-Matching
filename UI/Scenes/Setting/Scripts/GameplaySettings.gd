extends Control

@onready var label_name: Label = $HBoxContainer/Label as Label
@onready var check_button: CheckButton = $HBoxContainer/CheckButton as CheckButton
@onready var hover: AudioStreamPlayer2D = $Audio/Hover
@onready var select: AudioStreamPlayer2D = $Audio/Select
@export_enum("Head Bob", "Head sway", "Camera Shake", "Camera Drag") var label_enum : String

var SavingData : SavedGame = SavedGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lable_Text()
	loadSettings()


func _process(delta: float) -> void:
	pass
	

func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()

func Lable_Text() -> void: 
	label_name.text = str(label_enum)


func loadSettings():
	var data = load_save_data()
	if label_enum =="Head Bob":
		if data.CameraBob == true: 
			GLB.Camera_Bob = true
			check_button.button_pressed = true
		else:
			GLB.Camera_Bob = false
			check_button.button_pressed = false
	
	
	if label_enum == "Head sway":
		if data.CameraSway == true: 
			GLB.Camera_Sway = true
			check_button.button_pressed = true
		else:
			GLB.Camera_Sway = false
			check_button.button_pressed = false
	
	if label_enum == "Camera Shake":
		if data.CameraShake == true:
			GLB.Camera_shake = true
			check_button.button_pressed = true
		else:
			GLB.Camera_shake = false
			check_button.button_pressed =  false
	
	if label_enum == "Camera Drag":
		if data.CameraDrag == true: 
			GLB.Camera_Drag = true
			check_button.button_pressed = true
		else:
			GLB.Camera_Drag = false
			check_button.button_pressed = false


func _on_check_button_toggled(toggled_on: bool) -> void:
	var data = load_save_data()
	
	if label_enum == "Camera Shake":
		if toggled_on == true: 
			data.CameraShake = true
			GLB.Camera_shake = true
		else: 
			data.CameraShake = false
			GLB.Camera_shake = false
	
	elif label_enum == "Camera Drag": 
		if toggled_on == true: 
			data.CameraDrag = true
			GLB.Camera_Drag = true
		else: 
			data.CameraDrag = false
			GLB.Camera_Drag = false
	
	elif label_enum == "Head Bob":
		if toggled_on == true: 
			data.CameraBob = true
			GLB.Camera_Bob = true
		else:
			data.CameraBob = false
			GLB.Camera_Bob = false
	
	elif label_enum == "Head sway":
		if toggled_on == true:
			data.CameraSway = true
			GLB.Camera_Sway = true
		else: 
			data.CameraSway = false
			GLB.Camera_Sway = false
	
	ResourceSaver.save(data, "user://savegame.tres")
