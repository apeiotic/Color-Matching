extends Node3D
@onready var death_menu: Control = $"Death menu"
@onready var player: CharacterBody3D = $CharacterBody3D
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
var notificationCalled = false

const Balloon = preload("res://dialogue/balloon.tscn")

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
	GLB.emit_signal("Notification_Abilitytext", "Speed Increased, Jump Velocity Increased, 
	Dash Ability Accquired (Press 'V')," )


func Notification(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if notificationCalled != true:
			Callnotification()
