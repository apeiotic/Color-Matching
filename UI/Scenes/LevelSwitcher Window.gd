extends Control

@export var HoverSound: AudioStreamPlayer2D
@export_enum("level1", "level2", "level3", "level4", "level5", "level6",
"level7", "level8", "level9", "level10", "level11", "level12") var Level : String
@onready var MainLevelPreview: TextureRect = $"Main Image/TextureRect"
@onready var NameOfLebel: Label = $Name/Label
@onready var BestTime: Label = $"Finished Time/BestTime"
@onready var BackGround: TextureRect = $TextureRect
@onready var locked_or_not: ColorRect = $LockedORnot
@onready var choose_next_level: TextureRect = $ChooseNextLevel


var SavingData : SavedGame = SavedGame.new()
var clicked: bool
var HoverBGI = "res://UI/images/GUI/Hover_MainPanel01.png"
var NormalBGI = "res://UI/images/GUI/MainPanel01.png"
var NameArray= ["Level 1", "Level 2" , "Level 3", "Level 4", 
"Level 5", "Level 6", "Level 7", "Level 8", "Level 9", "Level 10", "Level 11", "Level 12" ]

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
	locked_or_not.hide()
	choose_next_level.hide()
	ApplyAssets()
	NextLevelToPlay()
	syncTime()
	is_finished()
	GLB.connect("LSClicked", Callable(self, "unclick"))
	

func is_finished():
	var data = load_save_data()
	if Level == "level2":
		if data.FinishedLevel1 == false:
			locked_or_not.show()
	
	if Level == "level3":
		if data.FinishedLevel2 == false:
			locked_or_not.show()
	
	if Level == "level4":
		if data.FinishedLevel3 == false:
			locked_or_not.show()
	
	if Level == "level5":
		if data.FinishedLevel4 == false:
			locked_or_not.show()
			
	if Level == "level6":
		if data.FinishedLevel5 == false:
			locked_or_not.show()
	
	if Level == "level7":
		if data.FinishedLevel6 == false:
			locked_or_not.show()
			
	if Level == "level8":
		if data.FinishedLevel7 == false:
			locked_or_not.show()
	
	if Level == "level9":
		if data.FinishedLevel8 == false:
			locked_or_not.show()
	
	if Level == "level10":
		if data.FinishedLevel9 == false:
			locked_or_not.show()
	
	if Level == "level11":
		if data.FinishedLevel10 == false:
			locked_or_not.show()
	
	if Level == "level12":
		if data.FinishedLevel11 == false:
			locked_or_not.show()


func NextLevelToPlay():
	var data = load_save_data()
	if Level == "level1":
		if data.FinishedLevel2 == false:
			if data.FinishedLevel1 == false:
				choose_next_level.show()
	elif Level == "level2":
		if data.FinishedLevel3 == false:
			if data.FinishedLevel2 == false:
				if data.FinishedLevel1 == true:
					choose_next_level.show()
	elif Level == "level3":
		if data.FinishedLevel4 == false:
			if data.FinishedLevel3 == false:
				if data.FinishedLevel2 == true:
					choose_next_level.show()
	elif Level == "level4":
		if data.FinishedLevel5 == false:
			if data.FinishedLevel4 == false:
				if data.FinishedLevel3 == true:
					choose_next_level.show()
	elif Level == "level5":
		if data.FinishedLevel6 == false:
			if data.FinishedLevel5 == false:
				if data.FinishedLevel4 == true:
					choose_next_level.show()
	elif Level == "level6":
		if data.FinishedLevel7 == false:
			if data.FinishedLevel6 == false:
				if data.FinishedLevel5 == true:
					choose_next_level.show()
	elif Level == "level7":
		if data.FinishedLevel8 == false:
			if data.FinishedLevel7 == false:
				if data.FinishedLevel6 == true:
					choose_next_level.show()
	elif Level == "level8":
		if data.FinishedLevel9 == false:
			if data.FinishedLevel8 == false:
				if data.FinishedLevel7 == true:
					choose_next_level.show()
	elif Level == "level9":
		if data.FinishedLevel10 == false:
			if data.FinishedLevel9 == false:
				if data.FinishedLevel8 == true:
					choose_next_level.show()
	elif Level == "level10":
		if data.FinishedLevel11 == false:
			if data.FinishedLevel10 == false:
				if data.FinishedLevel9 == true:
					choose_next_level.show()
	elif Level == "level11":
		if data.FinishedLevel12 == false:
			if data.FinishedLevel11 == false:
				if data.FinishedLevel10 == true:
					choose_next_level.show()
	elif Level == "level12":
		if data.FinishedLevel12 == false:
			if data.FinishedLevel11 == true:
				choose_next_level.show()


func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()


func ApplyAssets(): 
	if Level == "level1":
		NameOfLebel.text = NameArray[0]
		var texture = load(ImagePath[0])
		MainLevelPreview.texture = texture
	elif Level == "level2":
		NameOfLebel.text = NameArray[1]
		var texture = load(ImagePath[1])
		MainLevelPreview.texture = texture
	elif Level == "level3":
		NameOfLebel.text = NameArray[2]
		var texture = load(ImagePath[2])
		MainLevelPreview.texture = texture
	
	elif Level == "level4":
		NameOfLebel.text = NameArray[3]
		var texture = load(ImagePath[3])
		MainLevelPreview.texture = texture
	
	elif Level == "level5":
		NameOfLebel.text = NameArray[4]
		var texture = load(ImagePath[4])
		MainLevelPreview.texture = texture
	
	elif Level == "level6":
		NameOfLebel.text = NameArray[5]
		var texture = load(ImagePath[5])
		MainLevelPreview.texture = texture
	
	elif Level == "level7":
		NameOfLebel.text = NameArray[6]
		var texture = load(ImagePath[6])
		MainLevelPreview.texture = texture
	
	elif Level == "level8":
		NameOfLebel.text = NameArray[7]
		var texture = load(ImagePath[7])
		MainLevelPreview.texture = texture
	
	elif Level == "level9":
		NameOfLebel.text = NameArray[8]
		var texture = load(ImagePath[8])
		MainLevelPreview.texture = texture
		
	elif Level == "level10":
		NameOfLebel.text = NameArray[9]
		var texture = load(ImagePath[9])
		MainLevelPreview.texture = texture
	
	elif Level == "level11":
		NameOfLebel.text = NameArray[10]
		var texture = load(ImagePath[10])
		MainLevelPreview.texture = texture
	
	elif Level == "level12":
		NameOfLebel.text = NameArray[11]
		var texture = load(ImagePath[11])
		MainLevelPreview.texture = texture


func Hovered() -> void:
	HoverSound.play()
	var HoveredBG = load(HoverBGI)
	BackGround.texture = HoveredBG


func UnHovered() -> void:
	if clicked != true: 
		var normalBG = load(NormalBGI)
		BackGround.texture = normalBG

#to Unclick the button when I click on some other shit
func unclick():
	var normalBG = load(NormalBGI)
	BackGround.texture = normalBG
	clicked = false


func button_pressed() -> void:
	GLB.emit_signal("LevelSelectorData", Level)
	GLB.emit_signal("LSClicked")
	var HoveredBG = load(HoverBGI)
	BackGround.texture = HoveredBG
	clicked = true

func syncTime():
	var data = load_save_data()
	
	if Level == "level1":
		if data.FinishedLevel1 == true:
			BestTime.text = data.level1_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level2":
		if data.FinishedLevel2 == true:
			BestTime.text = data.level2_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level3":
		if data.FinishedLevel3 == true:
			BestTime.text = data.level3_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level4":
		if data.FinishedLevel4 == true:
			BestTime.text = data.level4_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level5":
		if data.FinishedLevel5 == true:
			BestTime.text = data.level5_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level6":
		if data.FinishedLevel6 == true:
			BestTime.text = data.level6_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level7":
		if data.FinishedLevel7 == true:
			BestTime.text = data.level7_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level8":
		if data.FinishedLevel8 == true:
			BestTime.text = data.level8_time
		else:
			BestTime.text = "Unfinished"
		
	elif Level == "level9":
		if data.FinishedLevel9 == true:
			BestTime.text = data.level9_time
		else:
			BestTime.text = "Unfinished"
		
	elif Level == "level10":
		if data.FinishedLevel10 == true:
			BestTime.text = data.level10_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level11":
		if data.FinishedLevel11 == true:
			BestTime.text = data.level11_time
		else:
			BestTime.text = "Unfinished"
	
	elif Level == "level12":
		if data.FinishedLevel12 == true:
			BestTime.text = data.level12_time
		else:
			BestTime.text = "Unfinished"
