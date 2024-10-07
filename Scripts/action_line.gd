extends ColorRect
var L_Playerspeed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("playerspeed", Callable(self, "saveplayerspeed"))
	pass # Replace with function body.

func saveplayerspeed (playerspeed):
	L_Playerspeed = playerspeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	compare_Speed_and_visibilty()
	


func compare_Speed_and_visibilty():
	if  L_Playerspeed > 7 : 
		material.set_shader_parameter("line_count", 1) 
		material.set_shader_parameter("mask_edge", lerp(0.5, 0.657, 0.1))
	
	
	if  L_Playerspeed > 9 :
		material.set_shader_parameter("line_count", 2)
		material.set_shader_parameter("mask_edge", lerp(0.657, 0.442, 0.1))
	
	
	if  L_Playerspeed < 4 : 
		material.set_shader_parameter("line_count", 0)
