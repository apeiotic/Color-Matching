extends Node

signal JumppadCollision
signal color(PlayerColor)
signal stamina(stamina)
signal playerspeed(playerspeed)
signal colorchange(color)
signal dead

var sensitivity  = 0.01
var Camera_Sway = true
var Camera_Bob = true
var Can_hook = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().quit()
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		
	
	pass
