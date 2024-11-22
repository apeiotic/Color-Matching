extends Node3D
@export var color = ["Black", "Green", "Red", "Lime", "Blue", "Cyan", "Orange"]
var change_colorTo = "Black"
signal ChangeColor
@onready var color_changing: AudioStreamPlayer2D = $Node3D/ColorChanging

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GLB.emit_signal("ColorChangerForMesh", color[0])
	


func Body_Enter(body: Node3D) -> void:
	ChangeColor.emit(color[0])
	GLB.colorchange.emit(color[0])
	color_changing.play()
	 # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	GLB.colorchange.emit(color[0])
	
	 # Replace with function body.
