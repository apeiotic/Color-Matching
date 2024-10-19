extends Node3D

# Dialogue variables
var is_in_dialogue:bool = false
var TempLocalTime: int

@onready var player = get_node("CharacterBody3D")  # Adjust this path if needed

const Balloon = preload("res://dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"


func _ready() -> void:
	GLB.connect("EnablePlayerMovement", Callable(self, "EnablePlayerMovement"))
	TempLoadData()

func _process(delta: float) -> void:
	print(TempLocalTime)
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		#get_tree().change_scene_to_file("res://Levels/MainLevels/level2.tscn")
		GLBSaving.emit_signal("level1")

#region Dialogue system

func _on_area_detected_body_entered(body: Node3D) -> void:
	if not is_in_dialogue:
		start_dialogue()

func start_dialogue() -> void:
	is_in_dialogue = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if player:
		player.set_physics_process(false)
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)


func EnablePlayerMovement():
	player.set_physics_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#endregion

func TempLoadData():
	var SavedData: SavedGame = load("user://savegame.tres") as SavedGame
	TempLocalTime=SavedData.level1_time
