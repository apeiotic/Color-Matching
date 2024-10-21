extends Node2D

@onready var label = $Label
@onready var timer = $Timer
@onready var total_time_milliseconds : int = 0 
@onready var FormattedTime: String  # Using milliseconds to track time
var SavingData : SavedGame = SavedGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 0.01  # Timer triggers every 10 milliseconds
	timer.start()
	
	#--------Saving Connection------------#
	GLBSaving.connect("level1", Callable(self, "TimeSaveLevel1"))
	GLBSaving.connect("level2", Callable(self, "TimeSaveLevel2"))
	GLBSaving.connect("level3", Callable(self, "TimeSaveLevel3"))
	

# This is called every time the timer times out (every 10 milliseconds)
func _on_timer_timeout() -> void:
	total_time_milliseconds += 10
	print(FormattedTime)
	var sec = int(total_time_milliseconds / 1000)  
	var millis = total_time_milliseconds % 1000 / 10 
	FormattedTime = '%02d:%02d' % [sec, millis]  
	$Label.text = FormattedTime


func load_save_data():
	# Try to load existing save data if it exists
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	# If the save file doesn't exist, return a new instance of SavingData
	return SavingData.new()


func TimeSaveLevel1():
	# Load existing save data before modifying
	var data = load_save_data()
	data.level1_time = str(FormattedTime)
	# Save updated data back to the file
	ResourceSaver.save(data, "user://savegame.tres")


func TimeSaveLevel2():
	var data = load_save_data()
	data.level2_time = str(FormattedTime)
	ResourceSaver.save(data, "user://savegame.tres")


func TimeSaveLevel3():
	var data = load_save_data()
	data.level3_time = str(FormattedTime)
	ResourceSaver.save(data, "user://savegame.tres")
