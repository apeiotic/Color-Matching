extends Node3D

# Dialogue variables
var is_in_dialogue = false
var required_spaces = 2
var space_count = 0
@onready var player = get_node("CharacterBody3D")  # Adjust this path if needed

const Balloon = preload("res://dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"



func _ready() -> void:
	pass # Replace with function body if needed

func _process(delta: float) -> void:
	if is_in_dialogue:
		if Input.is_action_just_pressed("ui_accept"):  # Assuming space is mapped to "ui_accept"
			space_count += 1
			print("Space pressed. Count: ", space_count)  # Debug print
			if space_count >= required_spaces:
				end_dialogue()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Levels/MainLevels/level2.tscn")

func _on_area_detected_body_entered(body: Node3D) -> void:
	if not is_in_dialogue:
		start_dialogue(2)

func start_dialogue(spaces_required: int) -> void:
	is_in_dialogue = true
	required_spaces = spaces_required
	space_count = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if player:
		player.set_physics_process(false)
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)

func end_dialogue() -> void:
	is_in_dialogue = false
	required_spaces = 0
	space_count = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if player:
		player.set_physics_process(true)

func _unhandled_input(event: InputEvent) -> void:
	if is_in_dialogue and event.is_action_pressed("ui_cancel"):  # Allow canceling dialogue with Esc
		end_dialogue()
