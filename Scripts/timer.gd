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
	GLBSaving.connect("Level2Finished", Callable(self, "Level2Finished"))
	GLBSaving.connect("Level3Finished", Callable(self, "Level3Finished"))
	GLBSaving.connect("Level4Finished", Callable(self, "Level4Finished"))
	GLBSaving.connect("Level5Finished", Callable(self, "Level5Finished"))
	GLBSaving.connect("Level6Finished", Callable(self, "Level6Finished"))
	GLBSaving.connect("Level7Finished", Callable(self, "Level7Finished"))
	GLBSaving.connect("Level8Finished", Callable(self, "Level8Finished"))
	GLBSaving.connect("Level9Finished", Callable(self, "Level9Finished"))
	
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
	var milliseconds = int(time_parts[0])
	return seconds * 1000 + milliseconds


# Save leaderboard for level 1 (times as strings)
func TimeSaveLevel1():
	var data = load_save_data()
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level1 hihgscores saving
	
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
	#endregion
	
	data.FinishedLevel1 = true
	
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level1_time", FormattedTime)

func TimeSaveLevel2():
	var data = load_save_data()
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level2 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level2_time == "" or time_to_milliseconds(data.level2_time) > current_time_ms:
		data.level2_time3 = data.level2_time2  # Shift times down
		data.level2_time2 = data.level2_time
		data.level2_time = FormattedTime
	elif data.level2_time2 == "" or time_to_milliseconds(data.level2_time2) > current_time_ms:
		data.level2_time3 = data.level2_time2
		data.level2_time2 = FormattedTime
	elif data.level2_time3 == "" or time_to_milliseconds(data.level2_time3) > current_time_ms:
		data.level2_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel2 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level2_time", FormattedTime)

func TimeSaveLevel3():
	var data = load_save_data()
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level3 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level3_time == "" or time_to_milliseconds(data.level3_time) > current_time_ms:
		data.level3_time3 = data.level3_time2  # Shift times down
		data.level3_time2 = data.level3_time
		data.level3_time = FormattedTime
	elif data.level3_time2 == "" or time_to_milliseconds(data.level3_time2) > current_time_ms:
		data.level3_time3 = data.level3_time2
		data.level3_time2 = FormattedTime
	elif data.level3_time3 == "" or time_to_milliseconds(data.level3_time3) > current_time_ms:
		data.level3_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel3 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level3_time", FormattedTime)

func TimeSaveLevel4():
	var data = load_save_data()
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level4 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level4_time == "" or time_to_milliseconds(data.level4_time) > current_time_ms:
		data.level4_time3 = data.level4_time2  # Shift times down
		data.level4_time2 = data.level4_time
		data.level4_time = FormattedTime
	elif data.level4_time2 == "" or time_to_milliseconds(data.level4_time2) > current_time_ms:
		data.level4_time3 = data.level4_time2
		data.level4_time2 = FormattedTime
	elif data.level4_time3 == "" or time_to_milliseconds(data.level4_time3) > current_time_ms:
		data.level4_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel4 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level4_time", FormattedTime)

func TimeSaveLevel5():
	var data = load_save_data()
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level5 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level5_time == "" or time_to_milliseconds(data.level5_time) > current_time_ms:
		data.level5_time3 = data.level5_time2  # Shift times down
		data.level5_time2 = data.level5_time
		data.level5_time = FormattedTime
	elif data.level5_time2 == "" or time_to_milliseconds(data.level5_time2) > current_time_ms:
		data.level5_time3 = data.level5_time2
		data.level5_time2 = FormattedTime
	elif data.level5_time3 == "" or time_to_milliseconds(data.level5_time3) > current_time_ms:
		data.level5_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel5 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level5_time", FormattedTime)

func TimeSaveLevel6():
	var data = load_save_data()
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level6 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level6_time == "" or time_to_milliseconds(data.level6_time) > current_time_ms:
		data.level6_time3 = data.level6_time2  # Shift times down
		data.level6_time2 = data.level6_time
		data.level6_time = FormattedTime
	elif data.level6_time2 == "" or time_to_milliseconds(data.level6_time2) > current_time_ms:
		data.level6_time3 = data.level6_time2
		data.level6_time2 = FormattedTime
	elif data.level6_time3 == "" or time_to_milliseconds(data.level6_time3) > current_time_ms:
		data.level6_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel6 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level6_time", FormattedTime)


func TimeSaveLevel7():
	var data = load_save_data()
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level7 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level7_time == "" or time_to_milliseconds(data.level7_time) > current_time_ms:
		data.level7_time3 = data.level7_time2  # Shift times down
		data.level7_time2 = data.level7_time
		data.level7_time = FormattedTime
	elif data.level7_time2 == "" or time_to_milliseconds(data.level7_time2) > current_time_ms:
		data.level7_time3 = data.level7_time2
		data.level7_time2 = FormattedTime
	elif data.level7_time3 == "" or time_to_milliseconds(data.level7_time3) > current_time_ms:
		data.level7_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel7 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level7_time", FormattedTime)

func TimeSaveLevel8():
	var data = load_save_data()
	
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level7 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level8_time == "" or time_to_milliseconds(data.level8_time) > current_time_ms:
		data.level8_time3 = data.level8_time2  # Shift times down
		data.level8_time2 = data.level8_time
		data.level8_time = FormattedTime
	elif data.level8_time2 == "" or time_to_milliseconds(data.level8_time2) > current_time_ms:
		data.level8_time3 = data.level8_time2
		data.level8_time2 = FormattedTime
	elif data.level8_time3 == "" or time_to_milliseconds(data.level8_time3) > current_time_ms:
		data.level8_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel8 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level8_time", FormattedTime)

func TimeSaveLevel9():
	var data = load_save_data()
	
	
	# Convert the current formatted time into milliseconds for comparison
	var current_time_ms = time_to_milliseconds(FormattedTime)
	
	#region Level9 hihgscores saving
	
	# If there is no existing time, or if the current time is better, update the leaderboard
	if data.level9_time == "" or time_to_milliseconds(data.level9_time) > current_time_ms:
		data.level9_time3 = data.level9_time2  # Shift times down
		data.level9_time2 = data.level9_time
		data.level9_time = FormattedTime
	elif data.level9_time2 == "" or time_to_milliseconds(data.level9_time2) > current_time_ms:
		data.level9_time3 = data.level9_time2
		data.level9_time2 = FormattedTime
	elif data.level9_time3 == "" or time_to_milliseconds(data.level9_time3) > current_time_ms:
		data.level9_time3 = FormattedTime
	#endregion
	
	data.FinishedLevel9 = true
	# Save the data back to the file
	ResourceSaver.save(data, "user://savegame.tres")
	GLBSaving.emit_signal("Level9_time", FormattedTime)


# When level 1 is finished
func Level1Finished():
	cantime = false
	TimeSaveLevel1()
	

func Level2Finished():
	cantime = false
	TimeSaveLevel2()


func Level3Finished():
	cantime = false
	TimeSaveLevel3()
	
func Level4Finished():
	cantime = false
	TimeSaveLevel4()

func Level5Finished():
	cantime = false
	TimeSaveLevel5()

func Level6Finished():
	cantime = false
	TimeSaveLevel6()

func Level7Finished():
	cantime = false
	TimeSaveLevel7()

func Level8Finished():
	cantime = false
	TimeSaveLevel8()

func Level9Finished():
	cantime = false
	TimeSaveLevel9()
