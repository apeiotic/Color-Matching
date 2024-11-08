extends Node3D
@onready var player: CharacterBody3D = $CharacterBody3D
@onready var death_menu: Control = $"Death menu"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("Died", Callable(self, "died_func"))
	death_menu.hide()

func died_func():
	player.queue_free()
	death_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	pass


func Obstacle(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.dead()


func FinishReached(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GLBSaving.emit_signal("Level8Finished")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.queue_free()
		GLBSaving.emit_signal("level8")
