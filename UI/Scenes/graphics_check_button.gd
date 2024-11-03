extends Control


@onready var NameLabel: Label = $HBoxContainer/Label
@onready var _Button: CheckButton = $HBoxContainer/CheckButton

@export_enum("SDFGI", "Glow", "Fog") var label_enum : String
var SavingData : SavedGame = SavedGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NameLabel.text = label_enum
	


func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()


func LoadData():
	var data = load_save_data()
	if label_enum == "SDFGI":
		if data._SDFGI == true:
			Graphics.world_environment.environment.sdfgi_enabled = true
			_Button.button_pressed = true
		else:
			Graphics.world_environment.environment.sdfgi_enabled = false
			_Button.button_pressed = false
	
	if label_enum == "Glow":
		if data.Glow == true:
			Graphics.world_environment.environment.glow_enabled = true
			_Button.button_pressed = true
		else:
			Graphics.world_environment.environment.glow_enabled = false
			_Button.button_pressed = false
	
	
	if label_enum == "Fog":
		if data.Fog== true:
			Graphics.world_environment.environment.fog_enabled = true
			_Button.button_pressed = true
		else:
			Graphics.world_environment.environment.fog_enabled = false
			_Button.button_pressed = false
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	if label_enum == "SDFGI":
		Graphics.world_environment.environment.sdfgi_enabled = toggled_on
		GLB.emit_signal("SaveWorldEnvironment", toggled_on,"SDFGI")
	if label_enum == "Glow":
		Graphics.world_environment.environment.glow_enabled = toggled_on
		GLB.emit_signal("SaveWorldEnvironment", toggled_on,  "Glow")
	if label_enum == "Fog":
		Graphics.world_environment.environment.fog_enabled = toggled_on
		GLB.emit_signal("SaveWorldEnvironment", toggled_on, "Fog")


func _on_timer_timeout() -> void:
	LoadData()
