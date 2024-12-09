extends Node3D
@onready var death_menu: Control = $"Death menu"
@onready var Player: CharacterBody3D = $CharacterBody3D
@onready var finsihed_levels: Control = $"Finsihed Levels"
@onready var player: CharacterBody3D = $CharacterBody3D
@onready var notification: Control = $Control
@onready var death_sounds = [$Node3D3/Death, $Node3D3/Death2]
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

var notificationCalled: bool
var notificationCalled2: bool
var is_in_dialogue:bool = false
const Balloon = preload("res://dialogue/balloon.tscn")
var SavingData : SavedGame = SavedGame.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("Died", Callable(self, "died_func"))
	GLB.connect("EnablePlayerMovement", Callable(self, "EnablePlayerMovement"))
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
		get_tree().change_scene_to_file("res://Levels/MainLevels/Level3.tscn")


func Finished(body: Node3D) -> void:
	if body.is_in_group("Player"):
		GLBSaving.emit_signal("Level2Finished")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.queue_free()
		GLBSaving.emit_signal("level2")
	
func load_save_data():
	if FileAccess.file_exists("user://savegame.tres"):
		var existing_data = ResourceLoader.load("user://savegame.tres")
		if existing_data != null:
			return existing_data
	return SavingData.new()


func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		var data = load_save_data()
		if not is_in_dialogue:
			if data.DialogueSeen2== false:
				start_dialogue()

func start_dialogue() -> void:
	var data = load_save_data()
	data.DialogueSeen2 = true
	ResourceSaver.save(data, "user://savegame.tres")
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



func Callnotification():
	notificationCalled = true
	GLB.emit_signal("Notification_color", Color.ORANGE, "orange")
	GLB.emit_signal("Notification_Abilitytext", "Tripple jump Accquired, Speed Increased, ....")

func Callnotification2():
	notificationCalled2 = true
	GLB.emit_signal("Notification_color", Color.LIME, "lime")
	GLB.emit_signal("Notification_Abilitytext", "Access Allowed on jumppad")


func Notification_Calling(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if notificationCalled != true: 
			Callnotification()


func SecondNotification(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if notificationCalled2 != true: 
			Callnotification2()
