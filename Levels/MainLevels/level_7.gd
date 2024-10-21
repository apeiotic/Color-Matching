extends Node3D
@onready var death_menu: Control = $"Death menu"
@onready var Player: CharacterBody3D = $CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("Died", Callable(self, "died_func"))
	death_menu.hide()

func died_func():
	Player.queue_free()
	death_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
