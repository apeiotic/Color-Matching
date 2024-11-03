extends Node

var world_environment: WorldEnvironment
var Light: DirectionalLight3D
var SavingData : SavedGame = SavedGame.new()

func _ready() -> void:
	GLB.connect("SaveWorldEnvironment", Callable(self, "SavingWorldEnvironment"))


func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()


func SavingWorldEnvironment(Value, Type):
	var data = load_save_data()
	if Type == "SDFGI":
		data._SDFGI = Value
	if Type == "Fog": 
		data.Fog = Value
	if Type == "Glow":
		data.Glow = Value
	
	ResourceSaver.save(data, "user://savegame.tres")
