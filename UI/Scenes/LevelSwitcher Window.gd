extends Control

@export var HoverSound: AudioStreamPlayer2D
@export_enum("level1", "level2", "level3", "level4", "level5", "level6",
"level7", "level8", "level9", "level10", "level11", "level12","level13",
"level14", "level15", "level16", "level17", "level18","level19", "level20",) var Level : String
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
var NameArray= ["Void Leaps", "Double Daring" , "Rush of Red", "Blue Velocity",
"Vertical Blitz", "Echo’s Edge", "Vertical Vortex" ]

var ImagePath= [
	"res://UI/images/Level Background/Untitled.png",
	"res://UI/images/Frame.png",
	"res://UI/images/Warning Image.png"
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
		var texture = load(ImagePath[2])
		MainLevelPreview.texture = texture
	
	elif Level == "level5":
		NameOfLebel.text = NameArray[4]
		var texture = load(ImagePath[2])
		MainLevelPreview.texture = texture
	
	elif Level == "level6":
		NameOfLebel.text = NameArray[5]
		var texture = load(ImagePath[2])
		MainLevelPreview.texture = texture
	
	elif Level == "level7":
		NameOfLebel.text = NameArray[6]
		var texture = load(ImagePath[2])
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
		
	
