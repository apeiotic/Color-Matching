extends Control
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var audio_num_lbl_2: Label = $"HBoxContainer/Audio Num Lbl2"

var SavingData : SavedGame = SavedGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_sens()

func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	audio_num_lbl_2.text = str(GLB.sensitivity)



func _on_h_slider_value_changed(value: float) -> void:
	var data = load_save_data()
	GLB.sensitivity = value
	data.Senstivity = value
	ResourceSaver.save(data, "user://savegame.tres")

func load_sens():
	var data = load_save_data()
	h_slider.value = data.Senstivity
	GLB.sensitivity = data.Senstivity
	audio_num_lbl_2.text = str(data.Senstivity)
	ResourceSaver.save(data, "user://savegame.tres")
