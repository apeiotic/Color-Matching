extends MeshInstance3D
var Color_Selected : String

@onready var mesh_ins: MeshInstance3D = $"."
@onready var label_3d: Label3D = $"../../Label3D"


var M_Red = preload("res://Materials/ColorChanger/M_CC_Red.tres")
var M_Black = preload("res://Materials/ColorChanger/M_CC_Black.tres")
var M_Cyan = preload ("res://Materials/ColorChanger/M_CC_Cyan.tres")
var M_Lime = preload("res://Materials/ColorChanger/M_CC_Lime.tres")
var M_Orange = preload("res://Materials/ColorChanger/M_CC_Orange.tres")
var M_Green = preload("res://Materials/ColorChanger/M_CC_Green.tres")
var M_Blue = preload("res://Materials/ColorChanger/M_CC_Blue.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("ColorChangerForMesh", Callable(self, "meshcolor"))
	



func meshcolor(color):
	Color_Selected = color
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Color_Selected == "Black":
		mesh_ins.set_surface_override_material(0, M_Black)
		label_3d.text = "black"
	elif Color_Selected == "Red":
		mesh_ins.set_surface_override_material(0, M_Red)
		label_3d.text = "red"
	elif Color_Selected == "Blue":
		mesh_ins.set_surface_override_material(0, M_Blue)
		label_3d.text = "blue"
	elif Color_Selected == "Cyan":
		mesh_ins.set_surface_override_material(0, M_Cyan)
		label_3d.text = "cyan"
	elif Color_Selected == "Lime":
		mesh_ins.set_surface_override_material(0, M_Lime)
		label_3d.text = "lime"
	elif Color_Selected == "Green":
		mesh_ins.set_surface_override_material(0, M_Green)
		label_3d.text = "green"
	elif Color_Selected == "Orange":
		mesh_ins.set_surface_override_material(0, M_Orange)
		label_3d.text = "orange"
