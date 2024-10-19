extends Node3D

@export var trauma_reduction_rate := 1.0

@export var max_x := 10.0
@export var max_y := 10.0
@export var max_z := 5.0

@export var noise : Noise
@export var noise_speed := 50.0

var trauma := 0.0
var speed: float
var time := 0.0

@onready var camera := $"."
@onready var initial_rotation := camera.rotation_degrees as Vector3

func _ready() -> void:
	GLB.connect("playerspeed", Callable(self, "saveplayerspeed"))



func _process(delta):
	time += delta
	trauma = max(trauma - delta * trauma_reduction_rate, 0.0)
	
	if GLB.Camera_shake == true:
		trauma_amount_based_on_speed()
	else:
		trauma ==0.0
	
	camera.rotation_degrees.x = initial_rotation.x + max_x * get_shake_intensity() * get_noise_from_seed(0)
	camera.rotation_degrees.y = initial_rotation.y + max_y * get_shake_intensity() * get_noise_from_seed(1)
	camera.rotation_degrees.z = initial_rotation.z + max_z * get_shake_intensity() * get_noise_from_seed(2)

func add_trauma(trauma_amount : float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)

func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
	

func saveplayerspeed(playerspeed):
	speed = playerspeed


func trauma_amount_based_on_speed():
	if speed > 7:
		add_trauma(0.05)
		max_x = 0.5
		max_y= 0.5
		max_z = 0.25
	
	if speed > 8.5:
		add_trauma(0.1)
		max_x = 1.0
		max_y=1.0
		max_z = 1.0
	
	if speed > 10.0:
		add_trauma(0.8)
		max_x =2.0
		max_y= 2.0
		max_z =1.0
