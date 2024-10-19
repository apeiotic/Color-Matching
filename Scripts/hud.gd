extends Control

var Pplayerspeed: float = 0
var jumpcount 
var lookingat

@onready var text = $CanvasLayer/MarginContainer5/Color
@onready var speedometre = $CanvasLayer/MarginContainer4/Label
@onready var JumpCount: Label = $CanvasLayer/MarginContainer/Label
@onready var texture_rect: TextureRect = $CanvasLayer/HBoxContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("playerspeed", Callable(self, "Playerspeed"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var speed = Pplayerspeed
	
	
	if speed != null:
	# Multiply the speed by 5 and round it
		var rounded_speed = round(speed * 5)

		var speed_text = str(rounded_speed) + " km/h"

	# Set the label's text to the formatted speed
		speedometre.text = speed_text
	
	else:
		speedometre.text = "0 km/h"


func Playerspeed(playerspeed):
	Pplayerspeed = playerspeed

func _on_character_body_3d_color(PlayerColor: Variant) -> void:
	text.text = PlayerColor
	pass # Replace with function body.
