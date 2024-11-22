extends Node

signal JumppadCollision
signal color(PlayerColor)
signal stamina(stamina)
signal playerspeed(playerspeed)
signal colorchange(color)
signal ColorChangerForMesh(color)
signal ColorChanging(color)
signal EnablePlayerMovement
signal Died
signal Died_With_Level(level)
signal Notification_color(GivenColor: Color, Text: String)
signal Notification_Abilitytext(AbilityList: String)
signal SaveWorldEnvironment(Value:bool, Type: String)
signal LevelSelectorData(HoveredLevel: String)
signal LSClicked
signal Restarted



var sensitivity : float = 1.5
var Camera_Sway = true
var Camera_Bob = true
var Can_hook: bool = true
var state: bool = false
var Camera_Drag: bool = true
var Camera_shake : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		emit_signal("Restarted")
	
