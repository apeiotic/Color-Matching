extends ColorRect

var L_stamina = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("playerspeed", Callable(self, "staminafunc"))
	pass # Replace with function body.

func staminafunc(playerspeed):
	L_stamina = playerspeed/10
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	material.set_shader_parameter("value", L_stamina)
	
	
	
