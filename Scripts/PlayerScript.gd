extends CharacterBody3D

#variables
var walking = false
var CanDash = true
var CanSlimeJump = true
var jumppading= false
var SlimeJump = false
var fallen = false
var SPEED = 5.0
var JUMP_VELOCITY = 4.5
var jump_count = 0
var max_jump = 1
var sprinting_speed = 10
var stamina = 100
var CameraSprintFov = 90.0
var CameraNormalFov = 75.0
var gravity = Vector3(0.0, -10.2, 0.0)
var lerp_amount = 0.09
var sway_speed = 0.05
var colors = ["Black", "Green", "Red", "Lime", "Blue", "Cyan", "Orange"]
var PlayerColor = colors[0]

#signals
signal color(PlayerColor)
signal canhook()

#refrences
@onready var detector = $"Neck/Standing Raycast"
@onready var camera = $"Neck/Neck 2/Camera3D"
@onready var dashraycast = $"Neck/Dash raycast"
@onready var jumptimer = $Neck/JumpTimer
@onready var HUD= $"Neck/Neck 2/Camera3D/HUD"
@onready var deathtimer = $"Neck/Death Timer"
@onready var neck = $Neck
@onready var neck_animation = $Neck/AnimationPlayer
@onready var JumppadTimer= $Neck/JumpPad
@onready var RandomTimer = $Neck/RandomTimers

#at start function
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
#Event tick
func _physics_process(delta: float) -> void:
	
	color.emit(PlayerColor)
	GLB.emit_signal("color", PlayerColor)
	
	sprint()
	dash()
	jump()
	print(jumppading)
	
	if detector.is_colliding():
		var collider = detector.get_collider()
		var groups = collider.get_groups()
		for group in groups:
			if "Orange" in group.to_lower():
				if PlayerColor == "Orange":
					OnOrange()
				else: 
					NotSameColor()
			if "green" in group.to_lower():
				if PlayerColor == "Green":
					OnGreen()
				else: 
					NotSameColor()
			if "black" in group.to_lower():
				
				if PlayerColor == "Black":
					OnBlack()
				else: 
					NotSameColor()
			if "red" in group.to_lower():
				if PlayerColor == "Red":
					OnRed()
				else: 
					NotSameColor()
			if "Lime"in group.to_lower():
				pass
	else: 
		
		normal()
	# Add the gravity.
	if not is_on_floor():
		velocity += gravity * delta
		fallen = true
	
	if fallen == true: 
		if is_on_floor():
			RandomTimer.start(0.5)
			jumppading = true
			neck_animation.stop()
			neck_animation.play("Falling Animation")
			fallen = false


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
	
	#Camera Sway
	if GLB.Camera_Sway == true and jumppading != true and SlimeJump != true:
		if input_dir.x > 0:
			neck.rotation.z = lerp_angle(neck.rotation.z, deg_to_rad(-2), sway_speed)
		elif input_dir.x < 0:
			neck.rotation.z = lerp_angle(neck.rotation.z, deg_to_rad(2), sway_speed)
		else:
			neck.rotation.z = lerp_angle(neck.rotation.z, deg_to_rad(0), sway_speed)
	
	#Camera Sway
	if GLB.Camera_Sway == true and jumppading != true and SlimeJump != true:
		if input_dir.y > 0:
			neck.rotation.x = lerp_angle(neck.rotation.x, deg_to_rad(1.5), sway_speed)
		elif input_dir.y < 0:
			neck.rotation.x = lerp_angle(neck.rotation.x, deg_to_rad(-1.5), sway_speed)
		else: 
			neck.rotation.x = lerp_angle(neck.rotation.x, deg_to_rad(0), sway_speed)
	
	#Camera Bob
	if GLB.Camera_Bob == true and jumppading != true and SlimeJump != true: 
		if input_dir.y> 0:
			neck_animation.play("Bob")
		elif input_dir.y < 0:
			neck_animation.play("Bob")
		else:
			neck_animation.stop()
	
	move_and_slide()



func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * GLB.sensitivity/3)
		camera.rotate_x(-event.relative.y *GLB.sensitivity/3)

func sprint(): #(Run this function in physics process delta)
	if Input.is_action_pressed("Sprint"):
		if walking==true: #(when moving set the walking to true)
			SPEED = sprinting_speed
			camera.fov = lerp(camera.fov, CameraSprintFov, 0.075) #(this is for FOV change of camera so you would need a refrence to camera)
	if Input.is_action_just_released("Sprint"):
		SPEED= 8.5
	if not Input.is_action_pressed("Sprint"):
		camera.fov = lerp(camera.fov, CameraNormalFov, 0.1)

func dash(): #Dash function
	if Input.is_action_just_pressed("Dash"):
		if CanDash and walking: 
			var Blink_Dist = 5
			if PlayerColor != "Black":
				if dashraycast.is_colliding(): 
					var NewDashLoc = dashraycast.get_collision_point()
					var NewBlinkDist = position.z - NewDashLoc.z
					translate(Vector3(0,0, -NewBlinkDist))
					CanDash = false
				else: 
					translate(Vector3(0,0, -Blink_Dist))
					CanDash = false
			else:
				translate(Vector3(0,0, -Blink_Dist))
				CanDash = false

func jump(): #Jump, you can do tripple or any amount jump by changing 'max jump' var
	if Input.is_action_just_pressed("Jump") and jump_count< max_jump:
		jumptimer.start()
		velocity.y = JUMP_VELOCITY
		neck.rotation.x = lerp_angle(neck.rotation.x, deg_to_rad(-2), 0.35)
	if PlayerColor != "Orange": 
		max_jump = 1
	elif PlayerColor != "Red" : 
		max_jump= 2
	if is_on_floor() :
		jump_count = 0

func OnBlack(): #what to do when standing on black
	SPEED =  3
	sprinting_speed = 5
	JUMP_VELOCITY = 4
	CameraSprintFov = 80.0
	CameraNormalFov = 65.0

func OnOrange():
	max_jump = 3
	GLB.Can_hook = true

func OnRed(): #what to do when standing on red
	SPEED =  8
	sprinting_speed = 13
	JUMP_VELOCITY = 3
	CameraSprintFov = 110.0
	CameraNormalFov = 80.0
	CanDash = true
	max_jump = 3
	lerp_amount = 0.12

func OnGreen(): #what to do when standing on green
	JUMP_VELOCITY = 10.0
	AutoJumping()



func normal(): #when youre on something which is not in any group
	SPEED = 5.0
	JUMP_VELOCITY = 4.5
	sprinting_speed = 10
	CameraNormalFov = 75.0
	CameraSprintFov = 90.0
	lerp_amount = 0.09

func AutoJumping(): #Autojumping, for slimy object
	velocity.y = JUMP_VELOCITY
	SlimeJump = true
	neck_animation.stop()
	neck_animation.play("MiniJump")
	jumptimer.start(0.4)
	print(neck_animation.current_animation)
	if is_on_floor() and CanSlimeJump == true: 
		AutoJumping()

func NotSameColor(): #function of what to do when our color doesnt match to what Im standing on 
	dead()
	pass

func dead():
	print("You are Dead")
	deathtimer.start()

func jumppadeffect():
	JumppadTimer.start()
	jumppading = true
	neck_animation.stop()
	neck_animation.play("JumpPad")
	
	print(neck_animation.current_animation)

#singals and shit
func _on_color_change(color: Variant) -> void:
	PlayerColor = color

func _on_timer_2_timeout() -> void:
	jump_count +=1 
	pass # Replace with function body.

func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()


func jump_pad_timeout() -> void:
	jumppading = false
	SlimeJump= false
	pass # Replace with function body.


func RandomTImerEnd() -> void:
	jumppading= false
	fallen= false
	print("Randomize timer end")
