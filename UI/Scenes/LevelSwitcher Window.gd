extends Control


@export_enum("level1", "level2", "level3", "level4") var Level : String
@onready var MainLevelPreview: TextureRect = $"Main Image/TextureRect"
@onready var NameOfLebel: Label = $Name/Label
@onready var  BestTime: Label = $"Finished Time/Label"
@onready var BackGround: TextureRect = $TextureRect

@export var HoverSound: AudioStreamPlayer2D

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
	ApplyAssets()


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


func Hovered() -> void:
	HoverSound.play()
	var HoveredBG = load(HoverBGI)
	BackGround.texture = HoveredBG
	GLB.emit_signal("LevelSelectorData", Level)


func UnHovered() -> void:
	var normalBG = load(NormalBGI)
	BackGround.texture = normalBG
