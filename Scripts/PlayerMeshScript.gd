extends MeshInstance3D
var playercolor = ""
var M_Black = preload("res://Materials/Player Colors/P_Black.tres")
var M_Red = preload("res://Materials/Player Colors/P_Red.tres")
var M_Blue = preload("res://Materials/Player Colors/P_Blue.tres")
var M_Cyan = preload("res://Materials/Player Colors/P_Cyan.tres")
var M_lime = preload("res://Materials/Player Colors/P_Lime.tres")
var M_Green = preload("res://Materials/Player Colors/P_Green.tres")
var M_Default = preload("res://Materials/Player Colors/P_Default.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("color", Callable(self, "SaveColor"))
	pass # Replace with function body.

func SaveColor(PlayerColor):
	playercolor = PlayerColor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playercolor == "Black":
		set_surface_override_material(0, M_Black)
	elif playercolor == "Red": 
		set_surface_override_material(0, M_Red)
	elif playercolor == "Green": 
		set_surface_override_material(0, M_Green)
	elif playercolor == "Blue": 
		set_surface_override_material(0, M_Blue)
	elif playercolor == "Cyan": 
		set_surface_override_material(0, M_Cyan)
	else: 
		set_surface_override_material(0, M_Default)
