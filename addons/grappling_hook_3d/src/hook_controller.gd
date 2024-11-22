class_name HookController
extends Node
## Node that is responsible for managing the hook, and the hook interface.


@export_category("Hook Controller")
@export_group("Required Settings")
@export var hook_raycast: RayCast3D
## Usually the parent of the player's scene
@export var player_body: CharacterBody3D
## Input Map action name that triggers hook's launch
@export var launch_action_name: String
## Input Map action name that triggers hook's retraction
@export var retract_action_name: String
@export_group("Optional Settings")
@export var pull_speed: float = 1.0
## A 3D node that serves as the beginning on the rope model
@export var hook_source: Node3D
@export var TimerRunOut: Timer
@export_group("Advanced Settings")
@export var hook_scene: PackedScene = preload("res://addons/grappling_hook_3d/src/hook.tscn")

var is_hook_launched: bool = false
var _hook_model: Node3D = null
var hook_target_normal: Vector3 = Vector3.ZERO
var hook_target_node: Marker3D = null
var hook_target_position: Vector3

signal hook_launched()
signal hook_attached(body)
signal hook_detached()


func _physics_process(delta: float) -> void:
	
	
	if Input.is_action_just_pressed(launch_action_name) and GLB.Can_hook == true:
		hook_launched.emit()
		
		
		match is_hook_launched:
			false: _launch_hook()
			true: _retract_hook()
	
	if is_hook_launched:
		_handle_hook(delta)
	
	var distance_to_target = player_body.global_transform.origin.distance_to(hook_target_position)
	var near_distance_threshold = 2
	
	if is_hook_launched == true:
		if distance_to_target <= near_distance_threshold:
			_retract_hook()


## Attaches a Marker3D to the body that is in the way of the raycast.
## Enables the hook, emits proper signals.
func _launch_hook() -> void:
	if not hook_raycast.is_colliding():
		return
	#checking if the object is hookable or not
	var hookable_object = hook_raycast.get_collider()
	hook_target_position = hook_raycast.get_collision_point()
	if hookable_object.is_in_group("Hookable"):
		is_hook_launched = true
		hook_attached.emit()
		
		var body: Node3D = hook_raycast.get_collider()
		
		hook_target_node = Marker3D.new()
		body.add_child(hook_target_node)
		
		hook_target_node.position = hook_raycast.get_collision_point() - body.global_position
		hook_target_normal = hook_raycast.get_collision_normal()
		
		_hook_model = hook_scene.instantiate()
		add_child(_hook_model)
	else: 
		return


## Disables the hook, frees the target node and the hook model, emits required signals.
func _retract_hook() -> void:
	is_hook_launched = false
	
	hook_target_node.queue_free()
	_hook_model.queue_free()
	
	hook_detached.emit()


## Handles the physics of the hook, and its visible model.
## NOTE: It adds the directional velocity to the player.
func _handle_hook(delta: float) -> void:
	# Hook pull math
	var pull_vector = (hook_target_node.global_position - player_body.global_position).normalized()

	# Add forward momentum to the pull
	var forward_vector = player_body.global_transform.basis.z * -2  # Assuming -Z is forward
	var combined_vector = (pull_vector + forward_vector * 0.5).normalized()
	
	# Optional: Add a vertical boost for a smoother arc
	combined_vector.y += 0.5
	combined_vector = combined_vector.normalized()

	# Apply the force
	player_body.velocity += combined_vector * pull_speed * delta * 60
	
	# Hook model handling
	var source_position: Vector3
	if hook_source:
		source_position = hook_source.global_position
	else:
		source_position = player_body.global_position
	
	_hook_model.extend_from_to(source_position, hook_target_node.global_position, hook_target_normal)
