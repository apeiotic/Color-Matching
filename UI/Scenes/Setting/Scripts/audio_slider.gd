extends Control

@onready var audio_name_lbl: Label = $"HBoxContainer/Audio Name Lbl" as Label
@onready var audio_num_lbl_2: Label = $"HBoxContainer/Audio Num Lbl2" as Label
@onready var h_slider: HSlider = $HBoxContainer/HSlider as HSlider
var SavingData : SavedGame = SavedGame.new()
@export_enum("Master", "Musics", "SoundEffects") var bus_name : String

var bus_index : int = 0

func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed)
	set_bus_name_by_index()
	set_name_lable_text()
	LoadSettings()
	set_slider_value()

func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()


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
	var data = load_save_data()
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_num_lable_text()
	if bus_name == "Musics":
		data.Music = value
	if bus_name == "SoundEffects":
		data.SFX_sound = value
	if bus_name == "Master":
		data.MasterSound = value
	
	ResourceSaver.save(data, "user://savegame.tres")

func LoadSettings():
	var data = load_save_data()
	if bus_name == "Musics":
		var MusicVolume = data.Music
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(MusicVolume))
	if bus_name == "SoundEffects":
		var MusicVolume = data.SFX_sound
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(MusicVolume))
	if bus_name == "Master":
		var MusicVolume = data.MasterSound
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(MusicVolume))
