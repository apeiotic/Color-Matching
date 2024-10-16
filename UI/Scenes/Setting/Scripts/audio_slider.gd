extends Control

@onready var audio_name_lbl: Label = $"HBoxContainer/Audio Name Lbl" as Label
@onready var audio_num_lbl_2: Label = $"HBoxContainer/Audio Num Lbl2" as Label
@onready var h_slider: HSlider = $HBoxContainer/HSlider as HSlider

@export_enum("Master", "Musics", "SoundEffects") var bus_name : String

var bus_index : int = 0

func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed)
	set_bus_name_by_index()
	set_name_lable_text()
	set_slider_value()

func set_name_lable_text() -> void: 
	audio_name_lbl.text = str(bus_name)



func set_audio_num_lable_text() -> void:
	audio_num_lbl_2.text = str(h_slider.value * 100) + "%"


func set_bus_name_by_index()-> void: 
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value() -> void: 
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_lable_text()

func on_value_changed(value : float) -> void: 
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_num_lable_text()
