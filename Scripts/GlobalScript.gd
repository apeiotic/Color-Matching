extends Node

signal JumppadCollision
signal color(PlayerColor)
signal stamina(stamina)
signal playerspeed(playerspeed)
signal colorchange(color)
signal ColorChangerForMesh(color)

var sensitivity  = 0.01
var Camera_Sway = true
var Camera_Bob = true
var Can_hook = false
var state = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Esc"):
		#toggle_pause()
	
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	
