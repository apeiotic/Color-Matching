extends Node3D
@onready var death_menu: Control = $"Death menu"
@onready var Player: CharacterBody3D = $CharacterBody3D
@onready var finsihed_levels: Control = $"Finsihed Levels"
@onready var player: CharacterBody3D = $CharacterBody3D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

@export var dialogue_resource2: DialogueResource


var is_in_dialogue:bool = false
var is_in_dialogue2:bool = false

const Balloon = preload("res://dialogue/balloon.tscn")
const Balloon2 = preload("res://dialogue/balloon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLB.connect("Died", Callable(self, "died_func"))
	GLB.connect("EnablePlayerMovement", Callable(self, "EnablePlayerMovement"))
	death_menu.hide()



func died_func():
	Player.queue_free()
	death_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


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


func _on_area_3d_2_body_entered(body: Node3D) -> void:
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


func start_dialogue2() -> void:
	
	is_in_dialogue2 = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if player:
		player.set_physics_process(false)
		player.stop_animations()
	var Balloon2: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(Balloon2)
	Balloon2.start(dialogue_resource2, dialogue_start)
	get_tree().paused = true

func EnablePlayerMovement():
	player.set_physics_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_area_3d_3_body_entered(body: Node3D) -> void:
	
	if body.is_in_group("Player"):
		print("start dialogue 2 called")
		if not is_in_dialogue2:
			start_dialogue2()
