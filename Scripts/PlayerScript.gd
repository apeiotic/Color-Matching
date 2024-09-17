extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 4.5
var walking = false
var sensitivity = 0.01
var sprinting_speed = 12
var stamina = 100

@onready var camera = $"Camera And other Stuff/Camera3D"



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _physics_process(delta: float) -> void:
	
	sprint()
	print(camera.fov)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var camera_basis = camera.global_transform.basis
	var direction = camera_basis * Vector3(input_dir.x, 0, input_dir.y)
	direction = direction.normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		walking= true
	else:
		var lerp_amount = 0.09 # Adjust this value for smoother/faster deceleration
		velocity.x = lerp(velocity.x, 0.0, lerp_amount)
		velocity.z = lerp(velocity.z, 0.0, lerp_amount)
		walking=false
	move_and_slide()


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity/3)
		camera.rotate_x(-event.relative.y * sensitivity/3)



func sprint(): #(Run this function in physics process delta)
	if Input.is_action_pressed("Sprint"):
		if walking==true: #(when moving set the walking to true)
			SPEED = sprinting_speed
			camera.fov = lerp(camera.fov, 90.0, 0.075) #(this is for FOV change of camera so you would need a refrence to camera)
	if Input.is_action_just_released("Sprint"):
		SPEED= 8.5
	if not Input.is_action_pressed("Sprint"):
		camera.fov = lerp(camera.fov, 75.0, 0.1)
