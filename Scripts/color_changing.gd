extends Node3D
@export var color = ["Black", "Green", "Red", "Lime", "Blue", "Cyan", "Orange"]
var change_colorTo = "Black"
signal ChangeColor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func Body_Enter(body: Node3D) -> void:
	ChangeColor.emit(color[0])
	GLB.colorchange.emit(color[0])
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	GLB.colorchange.emit(color[0])
	print("ashaofbalkfwww")
	pass # Replace with function body.
