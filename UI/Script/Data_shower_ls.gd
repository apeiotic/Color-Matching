extends Control

@onready var level_name_label: Label = $"Level Name Container/Level Name Label"
@onready var best_time: Label = $DataListed/VBoxContainer/BestTime/BestTime
@onready var second_best_time: Label = $DataListed/VBoxContainer/SecondBestTime/SecondBestTime
@onready var third_best_time: Label = $DataListed/VBoxContainer/ThirdBestTime2/ThirdBestTime
@onready var status: Label = $"DataListed/VBoxContainer/Status Container/Status"
@onready var MainLevelPreview: TextureRect = $LevelPreview_Container/LevelPreview
@onready var expected_time: Label = $"DataListed/VBoxContainer/Expected Time Container/Expected Time"
@export var deniedSoundefffect: AudioStreamPlayer2D


#@onready var cant_play: TextureRect = $DataListed/PlayButton/CantPlay


var selectedlevel:String
var SavingData : SavedGame = SavedGame.new()
var NameArray= ["level 1", "level 2" , "level 3", "level 4", "level 5", 
"level 6", "level 7", "level 8", "level 9", "level 10", "level 11", "level 12" ]

var ImagePath= [
	"res://UI/images/Level Background/Level1.png",
	"res://UI/images/Level Background/Level2.png",
	"res://UI/images/Level Background/Level3.png",
	"res://UI/images/Level Background/level4.png",
	"res://UI/images/Level Background/Level5.png",
	"res://UI/images/Level Background/Level6.png",
	"res://UI/images/Level Background/Level7.png",
	"res://UI/images/Level Background/Level8.png",
	"res://UI/images/Level Background/Level9.png",
	"res://UI/images/Level Background/Level10.png",
	"res://UI/images/Level Background/Level11.png",
	"res://UI/images/Level Background/Level12.png"
]



func _ready() -> void:
	GLB.connect("LevelSelectorData", Callable(self, "SyncingData" ))
	selectedNone()
	#cant_play.hide()


func ApplyAssets(): 
	if selectedlevel == "level1":
		var texture = load(ImagePath[0])
		MainLevelPreview.texture = texture
	elif selectedlevel == "level2":

		var texture = load(ImagePath[1])
		MainLevelPreview.texture = texture
	elif selectedlevel == "level3":

		var texture = load(ImagePath[2])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level4":

		var texture = load(ImagePath[3])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level5":

		var texture = load(ImagePath[4])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level6":

		var texture = load(ImagePath[5])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level7":

		var texture = load(ImagePath[6])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level8":

		var texture = load(ImagePath[7])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level9":

		var texture = load(ImagePath[8])
		MainLevelPreview.texture = texture
		
	elif selectedlevel == "level10":

		var texture = load(ImagePath[9])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level11":

		var texture = load(ImagePath[10])
		MainLevelPreview.texture = texture
	
	elif selectedlevel == "level12":

		var texture = load(ImagePath[11])
		MainLevelPreview.texture = texture


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
			ApplyAssets()
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
		ApplyAssets()
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
		ApplyAssets()
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
		ApplyAssets()
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
		ApplyAssets()
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
		ApplyAssets()
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
	
	elif Level == "level7":
		ApplyAssets()
		if data.FinishedLevel7: 
			status.text = "finished"
			best_time.text = data.level7_time
			second_best_time.text = data.level7_time2
			third_best_time.text = data.level7_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[6]
		expected_time.text = str(GLBSaving.ExpectedLevel7Time) + ":00"
	
	elif Level == "level8":
		ApplyAssets()
		if data.FinishedLevel8: 
			status.text = "finished"
			best_time.text = data.level8_time
			second_best_time.text = data.level8_time2
			third_best_time.text = data.level8_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[7]
		expected_time.text = str(GLBSaving.ExpectedLevel8Time) + ":00"
	
	elif Level == "level9":
		ApplyAssets()
		if data.FinishedLevel9: 
			status.text = "finished"
			best_time.text = data.level9_time
			second_best_time.text = data.level9_time2
			third_best_time.text = data.level9_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[8]
		expected_time.text = str(GLBSaving.ExpectedLevel9Time) + ":00"
	
	elif Level == "level10":
		ApplyAssets()
		if data.FinishedLevel10: 
			status.text = "finished"
			best_time.text = data.level10_time
			second_best_time.text = data.level10_time2
			third_best_time.text = data.level10_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[9]
		expected_time.text = str(GLBSaving.ExpectedLevel10Time) + ":00"
	
	elif Level == "level11":
		ApplyAssets()
		if data.FinishedLevel11: 
			status.text = "finished"
			best_time.text = data.level11_time
			second_best_time.text = data.level11_time2
			third_best_time.text = data.level11_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[10]
		expected_time.text = str(GLBSaving.ExpectedLevel11Time) + ":00"
	
	elif Level == "level12":
		ApplyAssets()
		if data.FinishedLevel12: 
			status.text = "finished"
			best_time.text = data.level12_time
			second_best_time.text = data.level12_time2
			third_best_time.text = data.level12_time3
		else:
			status.text = "unfinished"
			best_time.text = "----"
			second_best_time.text = "----"
			third_best_time.text = "----"
		level_name_label.text = NameArray[11]
		expected_time.text = str(GLBSaving.ExpectedLevel12Time) + ":00"


func _on_back_button_pressed() -> void:
	var mainmenu = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToMainMenu.tscn")
	get_tree().change_scene_to_packed(mainmenu)


func _on_play_pressed() -> void:
	var data = load_save_data()
	
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
		
	elif selectedlevel == "level7":
		
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel7.tscn")
		get_tree().change_scene_to_packed(Level)
		
	elif selectedlevel == "level8":
		
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel8.tscn")
		get_tree().change_scene_to_packed(Level)
	
	elif selectedlevel == "level9":
		
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel9.tscn")
		get_tree().change_scene_to_packed(Level)
	
	elif selectedlevel == "level10":
		
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel10.tscn")
		get_tree().change_scene_to_packed(Level)
	
	elif selectedlevel == "level11":
		
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel11.tscn")
		get_tree().change_scene_to_packed(Level)
	
	elif selectedlevel == "level12":
		
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel12.tscn")
		get_tree().change_scene_to_packed(Level)
	
	
	else: 
		var Level = preload("res://UI/Scenes/LoadingScreens/LS_LevelSwitrToLevel1.tscn")
		get_tree().change_scene_to_packed(Level)
