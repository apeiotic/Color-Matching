extends Node3D

# Dialogue variables
var is_in_dialogue:bool = false
var level = self

@onready var death_menu: Control = $"Death menu"
@onready var Player: CharacterBody3D = $CharacterBody3D
@onready var player = get_node("CharacterBody3D")  # Adjust this path if needed
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@onready var death_sounds = [$Node3D/Death, $Node3D/Death2]
const Balloon = preload("res://dialogue/balloon.tscn")
var notificationCalled: bool

func _ready() -> void:
	GLB.connect("EnablePlayerMovement", Callable(self, "EnablePlayerMovement"))
	GLB.connect("Died", Callable(self, "died_func"))
	death_menu.hide()
	Callnotification()

func _process(delta: float) -> void:
	pass


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
		#get_tree().change_scene_to_file("res://Levels/MainLevels/level2.tscn")
		died_func()

func _on_area_3d_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GLBSaving.emit_signal("Level1Finished")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.queue_free()
		GLBSaving.emit_signal("level7")
		

#region Dialogue system

func _on_area_detected_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if not is_in_dialogue:
			start_dialogue()

func start_dialogue() -> void:
	is_in_dialogue = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if player:
		player.set_physics_process(false)
		player.stop_animations()
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
	get_tree().paused = true


func EnablePlayerMovement():
	player.set_physics_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

#endregion


func Callnotification():
	notificationCalled = true
	GLB.emit_signal("Notification_color", Color.BLACK, "black")
	GLB.emit_signal("Notification_Abilitytext", "Walking Speed Slower,Sprinting Speed Slowed.... ")
