extends Node3D
@onready var death_menu: Control = $"Death menu"
@onready var player : CharacterBody3D = $CharacterBody3D
@onready var death_sounds = [$Node3D/Death, $Node3D/Death2]
var notificationCalled:bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("Died", Callable(self, "died_func"))
	death_menu.hide()
	

func play_random_death_sound():
	var random_sound = death_sounds[randi() % death_sounds.size()]
	random_sound.play()
	

func died_func():
	player.queue_free()
	death_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	play_random_death_sound()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GLBSaving.emit_signal("Level9Finished")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.queue_free()
		GLBSaving.emit_signal("level9")

func Callnotification():
	notificationCalled = true
	GLB.emit_signal("Notification_color", Color.RED, "danger!")
	GLB.emit_signal("Notification_Abilitytext", "Don't Stop And Use Tripple Jumps")

func Notification(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if notificationCalled == false:
			Callnotification()
