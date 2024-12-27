extends Node3D
@onready var death_menu: Control = $"Death menu"
@onready var player: CharacterBody3D = $CharacterBody3D
@onready var death_sounds = [$Node3D2/Death, $Node3D2/Death2]
var notificationCalled = false


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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GLBSaving.emit_signal("Level3Finished")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.queue_free()
		GLBSaving.emit_signal("level3")

func Callnotification():
	print("nitfucaagigfiagsif")
	notificationCalled = true
	GLB.emit_signal("Notification_color", Color.RED, "red")
	GLB.emit_signal("Notification_Abilitytext", "Speed Increased, Jump Velocity Increased. " )


func Notification(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if notificationCalled != true:
			Callnotification()
