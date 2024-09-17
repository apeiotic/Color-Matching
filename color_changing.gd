extends Node3D
@export var color = ["Black", "Green", "Red"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func Body_Enter(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GLB.colors = color
	pass # Replace with function body.
