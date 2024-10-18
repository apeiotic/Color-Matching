extends Control
@onready var label_name: Label = $HBoxContainer/Label as Label
@onready var check_button: CheckButton = $HBoxContainer/CheckButton as CheckButton
@onready var hover: AudioStreamPlayer2D = $Audio/Hover
@onready var select: AudioStreamPlayer2D = $Audio/Select

@export_enum("Head Bob", "Head sway") var label_enum : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GLB.Camera_Bob == true :
		if label_enum =="Head Bob" :
			check_button.button_pressed = true
	else:
		if label_enum =="Head Bob" :
			check_button.button_pressed = false
	
	if GLB.Camera_Sway == true :
		if label_enum =="Head sway" :
			check_button.button_pressed = true
	else:
		if label_enum =="Head Bob" :
			check_button.button_pressed = false
	
	
	Lable_Text()

func Lable_Text() -> void: 
	label_name.text = str(label_enum)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if label_enum =="Head Bob":
		if check_button.button_pressed == true:
			GLB.Camera_Bob = true
		else:
			GLB.Camera_Bob = false
	
	if label_enum == "Head sway":
		if check_button.button_pressed == true:
			GLB.Camera_Sway = true
		else: 
			GLB.Camera_Sway = false
