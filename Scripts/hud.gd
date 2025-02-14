extends Control

var Pplayerspeed: float = 0
var jumpcount 
var lookingat
var canhook: bool

@onready var text = $CanvasLayer/MarginContainer5/Color
@onready var speedometre = $CanvasLayer/MarginContainer4/Label
@onready var JumpCount: Label = $CanvasLayer/MarginContainer/Label
@onready var crosshair: TextureRect = $CanvasLayer/HBoxContainer/TextureRect
var crosshair1 = "res://UI/images/crosshair037.png"
var crosshair2 = "res://UI/images/crosshair038.png"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("playerspeed", Callable(self, "Playerspeed"))
	GLB.connect("CanHook", Callable(self, "CanHook"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canhook == false: 
		crosshair.texture = load(crosshair1)
	else: 
		crosshair.texture = load(crosshair2)
	var speed = Pplayerspeed
	
	
	if speed != null:
	# Multiply the speed by 5 and round it
		var rounded_speed = round(speed * 5)

		var speed_text = str(rounded_speed)

	# Set the label's text to the formatted speed
		speedometre.text = speed_text
	
	else:
		speedometre.text = "0"

func CanHook(FinalCanHook):
	canhook = FinalCanHook
	

func Playerspeed(playerspeed):
	Pplayerspeed = playerspeed

func _on_character_body_3d_color(PlayerColor: Variant) -> void:
	text.text = PlayerColor.to_lower()
	pass # Replace with function body.
