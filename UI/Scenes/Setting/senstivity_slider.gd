extends Control
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var audio_num_lbl_2: Label = $"HBoxContainer/Audio Num Lbl2"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	audio_num_lbl_2.text = str(GLB.sensitivity * 10)


func _on_h_slider_value_changed(value: float) -> void:
	GLB.sensitivity = value/5
