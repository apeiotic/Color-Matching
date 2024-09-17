extends CharacterBody3D

var SPEED = 5.0
var JUMP_VELOCITY = 4.5
var walking = false
var sensitivity = 0.01
var sprinting_speed = 10
var stamina = 100
var CameraSprintFov = 90.0
var CameraNormalFov = 75.0
var gravity = Vector3(0.0, -9.8, 0.0)
var CanDash = true
var Is_Dashing = false
var lerp_amount = 0.09


@onready var detector = $"Camera And other Stuff/Standing Raycast"
@onready var camera = $"Camera And other Stuff/Camera3D"
@onready var  dashtimer = $"Camera And other Stuff/Timer"


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _physics_process(delta: float) -> void:
	
	sprint()
	
	
	
	if detector.is_colliding():
		var collider = detector.get_collider()
		var groups = collider.get_groups()
		for group in groups:
			if "black" in group.to_lower():
				print("Standing on an object with a 'black' group!")
				if GLB.colors == "Black":
					OnBlack()
				else: 
					NotSameColor()
			if "red" in group.to_lower():
				print("Standing on an object with a 'Red' group!")
				if GLB.colors == "Red":
					OnRed()
				else: 
					NotSameColor()
	else: 
		if Is_Dashing == false:
			normal()
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += gravity * delta

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
		
		velocity.x = lerp(velocity.x, 0.0, lerp_amount)
		velocity.z = lerp(velocity.z, 0.0, lerp_amount)
		walking=false
	move_and_slide()


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity/3)
		camera.rotate_x(-event.relative.y *sensitivity/3)


func sprint(): #(Run this function in physics process delta)
	if Input.is_action_pressed("Sprint"):
		if walking==true: #(when moving set the walking to true)
			SPEED = sprinting_speed
			camera.fov = lerp(camera.fov, CameraSprintFov, 0.075) #(this is for FOV change of camera so you would need a refrence to camera)
	if Input.is_action_just_released("Sprint"):
		SPEED= 8.5
	if not Input.is_action_pressed("Sprint"):
		camera.fov = lerp(camera.fov, CameraNormalFov, 0.1)



func dash(): 
	if Input.is_action_just_pressed("Dash"):
		if CanDash == true: 
			if walking == true:
				dashtimer.start()
				lerp_amount = 0.01
				SPEED = 20
				Is_Dashing = true
				

func OnBlack(): #what to do when standing on black
	SPEED =  3
	sprinting_speed = 5
	JUMP_VELOCITY = 4
	CameraSprintFov = 80.0
	CameraNormalFov = 65.0

func OnRed():
	SPEED =  8
	sprinting_speed = 13
	JUMP_VELOCITY = 3
	CameraSprintFov = 110.0
	CameraNormalFov = 80.0


func normal(): #when youre on something which is not in any group
	SPEED = 5.0
	JUMP_VELOCITY = 4.5
	sprinting_speed = 10
	CameraNormalFov = 75.0
	CameraSprintFov = 90.0
	lerp_amount = 0.09

func NotSameColor(): #function of what to do when our color doesnt match to what Im standing on 
	print("Dead")


func _on_timer_timeout() -> void:
	normal()
	Is_Dashing = false
	
