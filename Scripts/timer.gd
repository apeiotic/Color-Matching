extends Node2D

@onready var label = $Label
@onready var timer = $Timer
@onready var total_time_milliseconds : int = 0 
@onready var FormattedTime: String  # Using milliseconds to track time
var SavingData : SavedGame = SavedGame.new()

var cantime: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 0.01  # Timer triggers every 10 milliseconds
	timer.start()
	
	#---------Level Completed-----------#
	GLBSaving.connect("Level1Finished", Callable(self, "Level1Finished"))
	
	#--------Saving Connection------------#
	GLBSaving.connect("level1", Callable(self, "TimeSaveLevel1"))
	GLBSaving.connect("level2", Callable(self, "TimeSaveLevel2"))
	GLBSaving.connect("level3", Callable(self, "TimeSaveLevel3"))

# Timer update
func _on_timer_timeout() -> void:
	if cantime == true:
		total_time_milliseconds += 10
		var sec = int(total_time_milliseconds / 1000)  
		var millis = total_time_milliseconds % 1000 / 10 
		FormattedTime = '%02d:%02d' % [sec, millis]  
		$Label.text = FormattedTime

# Load existing save data, or create a new instance if none exists
func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()

# Function to convert time strings back to total milliseconds for comparison
func time_to_milliseconds(time_string: String) -> int:
	var time_parts = time_string.split(":")
	var seconds = int(time_parts[0])
	var milliseconds = int(time_parts[1])
	return seconds * 1000 + milliseconds

# Save leaderboard for level 1 (times as strings)
func TimeSaveLevel1():
	var data = load_save_data()

	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)

	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level1_time == "" or time_to_milliseconds(data.level1_time) > current_time_ms:
		data.level1_time3 = data.level1_time2  # Shift times down
		data.level1_time2 = data.level1_time
		data.level1_time = FormattedTime
	elif data.level1_time2 == "" or time_to_milliseconds(data.level1_time2) > current_time_ms:
		data.level1_time3 = data.level1_time2
		data.level1_time2 = FormattedTime
	elif data.level1_time3 == "" or time_to_milliseconds(data.level1_time3) > current_time_ms:
		data.level1_time3 = FormattedTime

	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")

# When level 1 is finished
func Level1Finished():
	cantime = false
	GLBSaving.emit_signal("Level1_time", FormattedTime)

# Saving Level 2 and Level 3 data in a similar fashion
func TimeSaveLevel2():
	var data = load_save_data()
	data.level2_time = FormattedTime
	ResourceSaver.save(data, "user://savegame.tres")

func TimeSaveLevel3():
	var data = load_save_data()
	data.level3_time = FormattedTime
	ResourceSaver.save(data, "user://savegame.tres")
