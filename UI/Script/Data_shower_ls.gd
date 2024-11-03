extends Control

@onready var level_name_label: Label = $"Level Name Container/Level Name Label"
@onready var best_time: Label = $DataListed/VBoxContainer/BestTime/BestTime
@onready var second_best_time: Label = $DataListed/VBoxContainer/SecondBestTime/SecondBestTime
@onready var third_best_time: Label = $DataListed/VBoxContainer/ThirdBestTime2/ThirdBestTime
@onready var status: Label = $"DataListed/VBoxContainer/Status Container/Status"
@onready var level_preview: TextureRect = $LevelPreview_Container/LevelPreview
@onready var expected_time: Label = $"DataListed/VBoxContainer/Expected Time Container/Expected Time"

var selectedlevel:String
var SavingData : SavedGame = SavedGame.new()
var NameArray= ["void leaps", "double daring" , "rush of red", "Blue Velocity",
"Vertical Blitz", "Echo’s Edge", "Vertical Vortex" ]


func _ready() -> void:
	GLB.connect("LevelSelectorData", Callable(self, "SyncingData" ))
	selectedNone()
	



func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()



func selectedNone():
	var data = load_save_data()
	if data.FinishedLevel1: 
			status.text = "finished"
			best_time.text = data.level1_time
			second_best_time.text = data.level1_time2
			third_best_time.text = data.level1_time3
	else:
		status.text = "unfinished"
		best_time.text = "----"
		second_best_time.text = "----"
		third_best_time.text = "----"
	level_name_label.text = NameArray[0]
	expected_time.text = str(GLBSaving.ExpectedLevel1Time)  + ":00"

func SyncingData(Level):
	selectedlevel = Level
	var data = load_save_data()
	if Level == "level1":
		if data.FinishedLevel1: 
			status.text = "finished"
			best_time.text = data.level1_time
			second_best_time.text = data.level1_time2
			third_best_time.text = data.level1_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[0]
		expected_time.text = str(GLBSaving.ExpectedLevel1Time) + ":00"
	
	elif Level == "level2":
		if data.FinishedLevel2: 
			status.text = "finished"
			best_time.text = data.level2_time
			second_best_time.text = data.level2_time2
			third_best_time.text = data.level2_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[1]
		expected_time.text = str(GLBSaving.ExpectedLevel2Time) + ":00"
	
	elif Level == "level3":
		if data.FinishedLevel3: 
			status.text = "finished"
			best_time.text = data.level3_time
			second_best_time.text = data.level3_time2
			third_best_time.text = data.level3_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[2]
		expected_time.text = str(GLBSaving.ExpectedLevel3Time) + ":00"
	
	elif Level == "level4":
		if data.FinishedLevel4: 
			status.text = "finished"
			best_time.text = data.level4_time
			second_best_time.text = data.level4_time2
			third_best_time.text = data.level4_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[3]
		expected_time.text = str(GLBSaving.ExpectedLevel4Time) + ":00"
	
	elif Level == "level5":
		if data.FinishedLevel5: 
			status.text = "finished"
			best_time.text = data.level5_time
			second_best_time.text = data.level5_time2
			third_best_time.text = data.level5_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[4]
		expected_time.text = str(GLBSaving.ExpectedLevel5Time) + ":00"
	
	elif Level == "level6":
		if data.FinishedLevel6: 
			status.text = "finished"
			best_time.text = data.level6_time
			second_best_time.text = data.level6_time2
			third_best_time.text = data.level6_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[5]
		expected_time.text = str(GLBSaving.ExpectedLevel6Time) + ":00"
	


func _on_back_button_pressed() -> void:
	var mainmenu = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToMainMenu.tscn")
	get_tree().change_scene_to_packed(mainmenu)


func _on_play_pressed() -> void:
	if selectedlevel == "level1":
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel1.tscn")
		get_tree().change_scene_to_packed(Level)
	elif selectedlevel == "level2":
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel2.tscn")
		get_tree().change_scene_to_packed(Level)
	elif selectedlevel == "level3":
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel3.tscn")
		get_tree().change_scene_to_packed(Level)
	elif selectedlevel == "level4":
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel4.tscn")
		get_tree().change_scene_to_packed(Level)
	elif selectedlevel == "level5":
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel5.tscn")
		get_tree().change_scene_to_packed(Level)
	elif selectedlevel == "level6":
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel6.tscn")
		get_tree().change_scene_to_packed(Level)
		
		
		
		
	else: 
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel1.tscn")
		get_tree().change_scene_to_packed(Level)
