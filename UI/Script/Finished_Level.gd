extends Control

@onready var FinalTime: Label = $Timer/HBoxContainer/Label2
@onready var BestScore: Label =$"Control/Times/VBoxContainer/1st label/1st label time"
@onready var SecondBestScore: Label = $"Control/Times/VBoxContainer/2nd label/2nd lable time"
@onready var ThirdBestScore: Label = $"Control/Times/VBoxContainer/3rd label/3rd label time"
@onready var expected_time: Label = $"Expected Time Control/TIme"

func _ready() -> void:
	hide()
	GLBSaving.connect("Level1_time", Callable(self,"Level1func" ))
	GLBSaving.connect("Level2_time", Callable(self,"Level2func" ))
	GLBSaving.connect("Level3_time", Callable(self,"Level3func" ))
	GLBSaving.connect("Level4_time", Callable(self,"Level4func" ))
	GLBSaving.connect("Level5_time", Callable(self,"Level5func" ))
	GLBSaving.connect("Level6_time", Callable(self,"Level6func" ))
	GLBSaving.connect("Level7_time", Callable(self,"Level7func" ))
	GLBSaving.connect("Level8_time", Callable(self,"Level8func" ))
	GLBSaving.connect("Level9_time", Callable(self,"Level9func" ))
	


# Function to load saved data
func load_save_data():
	# Create a temporary FileAccess instance to ensure data is committed
	var file = FileAccess.open("user://savegame.tres", FileAccess.READ_WRITE)
	if file:
		file.flush()  # Ensure data is committed
		file.close()
		
	# Load the saved data
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres", "Resource")
		if existing_data != null:
			return existing_data
	return null

# Function to update the leaderboard display
func load_and_display_leaderboard(Level : String):
	var data = load_save_data()
	if Level == "Level1":
		if data != null:
			BestScore.text = str(data.level1_time)
			SecondBestScore.text = str(data.level1_time2)
			ThirdBestScore.text = str(data.level1_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel1Time) + ".00" + " seconds"
	if Level == "Level2":
		if data != null:
			BestScore.text = str(data.level2_time)
			SecondBestScore.text = str(data.level2_time2)
			ThirdBestScore.text = str(data.level2_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel2Time) + ".00" + " seconds"
	if Level == "Level3":
		if data != null:
			BestScore.text = str(data.level3_time)
			SecondBestScore.text = str(data.level3_time2)
			ThirdBestScore.text = str(data.level3_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel3Time) + ".00" + " seconds"
	if Level == "Level4":
		if data != null:
			BestScore.text = str(data.level4_time)
			SecondBestScore.text = str(data.level4_time2)
			ThirdBestScore.text = str(data.level4_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel4Time) + ".00" + " seconds"
	if Level == "Level5":
		if data != null:
			BestScore.text = str(data.level5_time)
			SecondBestScore.text = str(data.level5_time2)
			ThirdBestScore.text = str(data.level5_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel5Time) + ".00" + " seconds"
	if Level == "Level6":
		if data != null:
			BestScore.text = str(data.level6_time)
			SecondBestScore.text = str(data.level6_time2)
			ThirdBestScore.text = str(data.level6_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel6Time) + ".00" + " seconds"
	if Level == "Level7":
		if data != null:
			
			BestScore.text = str(data.level7_time)
			SecondBestScore.text = str(data.level7_time2)
			ThirdBestScore.text = str(data.level7_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel7Time) + ".00" + " seconds"
	if Level == "Level8":
		if data != null:
			
			BestScore.text = str(data.level8_time)
			SecondBestScore.text = str(data.level8_time2)
			ThirdBestScore.text = str(data.level8_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel8Time) + ".00" + " seconds"
	if Level == "Level9":
		if data != null:
			
			BestScore.text = str(data.level9_time)
			SecondBestScore.text = str(data.level9_time2)
			ThirdBestScore.text = str(data.level9_time3)
			expected_time.text = str(GLBSaving.ExpectedLevel9Time) + ".00" + " seconds"


# Called when level 1 is completed
func Level1func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level1")
	

func Level2func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level2")
	print("level2func called")

func Level3func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level3")
	

func Level4func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level4")

func Level5func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level5")


func Level6func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level6")
	
func Level7func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level7")
	
func Level8func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level8")

func Level9func(FormattedTime: String):
	var data = load_save_data()
	show()
	FinalTime.text = FormattedTime
	load_and_display_leaderboard("Level9")

func _on_main_menu_pressed() -> void:
	var LoadingMainMenu = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToMainMenu.tscn")
	get_tree().change_scene_to_packed(LoadingMainMenu)



func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()

func get_current_level_name() -> String:
	# Get the scene's filename using filename property
	var scene_path = get_tree().current_scene.scene_file_path
	var scene_name = scene_path.get_file().get_basename()  # Get only the filename, excluding the path and extension
	return scene_name

func _on_next_level_pressed() -> void:
	var current_level_name = get_current_level_name()
	print(current_level_name)
	
	if current_level_name.to_lower() == "level1":
		var level2 = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel2.tscn")
		get_tree().change_scene_to_packed(level2)
	
	if current_level_name.to_lower() == "level2":
		print("onlevel2")
		var level3 = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel3.tscn")
		get_tree().change_scene_to_packed(level3)
	
	if current_level_name.to_lower() == "level3":
		var level4 = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel4.tscn")
		get_tree().change_scene_to_packed(level4)
	
	if current_level_name.to_lower() == "level4":
		var level5 = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel5.tscn")
		get_tree().change_scene_to_packed(level5)
	
	if current_level_name.to_lower() == "level5":
		var level6 = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel6.tscn")
		get_tree().change_scene_to_packed(level6)
	
	if current_level_name.to_lower() == "level_6":
		var level7 = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel7.tscn")
		get_tree().change_scene_to_packed(level7)
