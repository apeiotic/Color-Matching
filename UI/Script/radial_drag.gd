extends ColorRect
var L_Playerspeed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("playerspeed", Callable(self, "saveplayerspeed"))

func saveplayerspeed (playerspeed):
	L_Playerspeed = playerspeed



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GLB.Camera_Drag == true: 
		if L_Playerspeed > 7:
			material.set_shader_parameter("max_drag_distance", 0.05)
		
		if L_Playerspeed >9:
			material.set_shader_parameter("max_drag_distance", 0.1)
			
		if L_Playerspeed < 7:
			material.set_shader_parameter("max_drag_distance", 0)
		
