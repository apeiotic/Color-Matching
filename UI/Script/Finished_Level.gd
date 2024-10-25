extends Control
@onready var FinalTime: Label = $Timer/HBoxContainer/Label2
var SavingData : SavedGame = SavedGame.new()

@onready var BestScore: Label = $"Control/Times/VBoxContainer/Label 1"
@onready var SecondBestScore: Label = $"Control/Times/VBoxContainer/Label 2"
@onready var ThirdBestScore: Label = $"Control/Times/VBoxContainer/Label 3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLBSaving.connect("Level1_time", Callable(self,"Level1func" ))
	hide()
	

func load_save_data():
	# Try to load existing save data if it exists
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	# If the save file doesn't exist, return a new instance of SavingData
	return SavingData.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Leaderboard(level : String):
	var data = load_save_data()
	if level == "level1":
		BestScore.text = "Time     " + data.level1_time
		SecondBestScore.text = "Time     " + data.level1_time2
		ThirdBestScore.text = "Time     "  + data.level1_time3

func Level1func(FormattedTime):
	Leaderboard("level1")
	show()
	FinalTime.text = FormattedTime
