extends Node3D
@onready var death_menu: Control = $"Death menu"
@onready var player : CharacterBody3D = $CharacterBody3D
@onready var death_sounds = [$Node3D/Death, $Node3D/Death2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("Died", Callable(self, "died_func"))


func play_random_death_sound():
	var random_sound = death_sounds[randi() % death_sounds.size()]
	random_sound.play()

func died_func():
	player.queue_free()
	death_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	play_random_death_sound()


func Finished(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GLBSaving.emit_signal("Level10Finished")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.queue_free()
		GLBSaving.emit_signal("level10")
