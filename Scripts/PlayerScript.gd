extends CharacterBody3D

#region Variables
#variables
#-------Booleans----------#
var walking = false
var CanSlimeJump = true
var jumppading= false
var SlimeJump = false
var fallen = false
var sprinting = true
var can_wallrun = false
var is_wallrunning = false
var is_wallrun_jumping = false
var CanWallrunDelay = false
var Wallrunned = false


var wallrun_current_angle = 0
var wallrun_angle = 15
var wallrun_delay = 0.4
var SPEED : float = 5.0
var JUMP_VELOCITY = 4.5
var jump_count = 0
var max_jump = 1
var AutojumpingValue = 5.5
var sprinting_speed = 10
var stamina = 100
var CameraSprintFov = 90.0
var CameraNormalFov = 75.0
var gravity = Vector3(0.0, -10.2, 0.0)
var wall_jump_dir = Vector3.ZERO
var wall_jump_horizontal_power =2.5
var wall_jump_vertical_power = 0.7
var wall_jump_factor = 0.4
var wind_volume_target = -10.0  # Default quiet volume
var transition_speed = 0.1      # Adjust how fast volume changes

var lerp_amount = 0.09
var sway_speed = 0.05
var colors = ["Black", "Green", "Red", "Lime", "Blue", "Cyan", "Orange"]
var standingColor = ""
var side = ""
var PlayerColor = colors[0]
var x_rotation = 0.0
var direction = Vector3()
var Current_Level
#endregion

#signals
signal color(PlayerColor)
signal canhook()

#region Refrences
#refrences

@onready var wallrun_delay_default = wallrun_delay
@onready var detector = $"Neck/Standing Raycast"
@onready var camera = $"Neck/Neck 2/Neck 3/Camera3D"

@onready var jumptimer = $Neck/JumpTimer
@onready var HUD= $"Neck/Neck 2/Neck 3/Camera3D/HUD"
@onready var deathtimer = $"Neck/Death Timer"
@onready var neck = $Neck
@onready var neck_animation = $Neck/AnimationPlayer
@onready var JumppadTimer= $Neck/JumpPad
@onready var RandomTimer = $Neck/RandomTimers
@onready var staminabar = $"Effects/MarginContainer/Stamina ProgressBar"
@onready var neck2 = $"Neck/Neck 2"
@onready var LeftWallDetector = $Neck/LeftWallDetector
@onready var RIghtWallDetector = $Neck/RightWallDetector
@onready var ActionLine = $Effects/ActionLine
@onready var wallrun_delayTimer: Timer = $Neck/WallrunDelay
@onready var looking_at_raycast: RayCast3D = $"Neck/Looking At Raycast"
@onready var radial_drag: ColorRect = $"Effects/Radial Drag"
@onready var green_jump_pad_sound: AudioStreamPlayer2D = $Soundeffects/GreenJumpPadSound
@onready var jump_sound: AudioStreamPlayer2D = $Soundeffects/JumpSound
@onready var jump_sound_2: AudioStreamPlayer2D = $Soundeffects/JumpSound2


#endregion

#at start function
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GLB.connect("colorchange", Callable(self, "ColorChanging"))
	
#Event tick
func _physics_process(delta: float) -> void:

	
	if Input.is_action_just_pressed("Esc"): 
		HUD.hide()
		ActionLine.hide()
		
	else:
		HUD.show()
	
	Current_Level = get_tree().current_scene
	if is_wallrunning == true: 
		Wallrunned = true
		CanWallrunDelay = true
	
	#region if not is on floor and checking for wallrun
	
	
	
	if is_on_floor():
		can_wallrun = false
		wallrun_delay = 0.4
		is_wallrunning = false
		is_wallrun_jumping = false
		Wallrunned = false
	
	
	else:
		wallrun_delay = clamp(wallrun_delay - delta, 0, wallrun_delay_default)
		if wallrun_delay == 0:
			
			if not LeftWallDetector.is_colliding() and not RIghtWallDetector.is_colliding():
				can_wallrun = false
			
			if LeftWallDetector.is_colliding():
				var leftwalls = LeftWallDetector.get_collider()
				var leftgroups = leftwalls.get_groups()
				
				for group in leftgroups:
					if "orange" in group.to_lower():
						if PlayerColor ==  "Orange":
							can_wallrun = true
						else:
							can_wallrun = false
					else:
						can_wallrun = false
			elif RIghtWallDetector.is_colliding():
				var rightwalls = RIghtWallDetector.get_collider()
				var rightgroups = rightwalls.get_groups()
				
				for group in rightgroups: 
					if "orange" in group.to_lower():
						if PlayerColor ==  "Orange":
							can_wallrun = true
						else: 
							can_wallrun = false
					else:
						can_wallrun = false
		else:
			can_wallrun = false
			
			
		velocity += gravity * delta
		fallen = true
	
	
	
	
	#if is_wallrunning == true:
		#Wallrunned = true
		#CanWallrunDelay = true
		
	
	if CanWallrunDelay == true: 
		if is_wallrunning == false:
			wallrun_delayTimer.start()
	
	
	#endregion
	
	
	
	var playerspeed = velocity.length()
	
	color.emit(PlayerColor)
	GLB.emit_signal("color", PlayerColor)
	GLB.emit_signal("stamina", stamina)
	GLB.emit_signal("playerspeed", playerspeed)
	staminabar.material.set_shader_parameter("value", stamina)
	
	
	
	jump()
	process_wallrun()
	process_wallrun_rotation(delta)
	
	#region WindSoundEffects
	if velocity.length() > 15.0:
		wind_volume_target = 2.0  # Maximum volume for high speed
	elif velocity.length() > 8.5:
		wind_volume_target = -10.0  # Medium volume for medium speed
	else:
		wind_volume_target = -20.0  # Quiet for low speed

	# Play sound only once
	if not BG_Sound.wind_sound.playing:
		BG_Sound.wind_sound.play()

	# Gradually adjust the volume to target
	BG_Sound.wind_sound.volume_db = lerp(
		BG_Sound.wind_sound.volume_db,
		wind_volume_target,
		transition_speed
	)
	#endregion
	
	#region Detecting standing block type
	if detector.is_colliding():
		
		var collider = detector.get_collider()
		var groups = collider.get_groups()
		for group in groups:
			
			
			if "orange" in group.to_lower():
				if PlayerColor == "Orange":
					OnOrange()
					standingColor = "Orange"
				else: 
					NotSameColor()#death function
			if "green" in group.to_lower():
				if PlayerColor == "Green":
					OnGreen()
					standingColor = "Green"
				else: 
					
					NotSameColor()
			if "black" in group.to_lower():
				if PlayerColor == "Black":
					OnBlack()
					standingColor = "Black"
				else: 
					NotSameColor()
			if "red" in group.to_lower():
				if PlayerColor == "Red":
					OnRed()
					standingColor = "Red"
				else: 
					NotSameColor()
			if "Lime"in group.to_lower():
				pass
			
			if "blue" in group.to_lower():
				if PlayerColor == "Blue":
					OnBlue()
					standingColor = "Blue"
				else:
					NotSameColor()
	else: 
		normal()
	#endregion
	
	#region saved Color effect
	if standingColor == "Black":
		OnBlack()
		
	if standingColor == "Red":
		OnRed()
	if standingColor == "Blue":
		OnBlue()
	#if standingColor == "Green":
		#OnGreen()
	if standingColor == "Orange":
		OnOrange()
	#endregion 
	
	
	if PlayerColor != "Green":
		CanSlimeJump = false
	
	
	if fallen == true: 
		if is_on_floor():
			RandomTimer.start(0.5)
			jumppading = true
			neck_animation.stop()
			neck_animation.play("Falling Animation")
			fallen = false

	if walking != true: 
		camera.fov = lerp(camera.fov, CameraNormalFov, 0.1)
	
	if PlayerColor != "Black":
		GLB.Can_hook = false
		
	else:
		GLB.Can_hook = true
		
	
	sprint()
#region Movement System

	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var camera_basis = camera.global_transform.basis

	# Ignore the camera's y-axis rotation by zeroing out the y-component
	var forward = camera_basis.z
	forward.y = 0
	forward = forward.normalized()

	var right = camera_basis.x
	right.y = 0
	right = right.normalized()

	# Calculate the movement direction based on forward and right
	direction = (right * input_dir.x + forward * input_dir.y).normalized()

	# Apply movement or deceleration
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		walking = true
	else:
		velocity.x = lerp(velocity.x, 0.0, lerp_amount)
		velocity.z = lerp(velocity.z, 0.0, lerp_amount)
		walking = false

#endregion
	
#region Camera Sway and bob
	

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
	
#endregion
	
	
	move_and_slide()

func process_wallrun():
	
		
	if Input.is_action_just_pressed("Jump") and Wallrunned:
		
		if is_wallrunning == false: 
			await(get_tree().create_timer(0.5))
			Wallrunned = false
		
		wallrun_delay = 0.7
		can_wallrun = false
		is_wallrunning = false
		
		velocity = Vector3.ZERO
		
		velocity.y = JUMP_VELOCITY * wall_jump_vertical_power
		is_wallrun_jumping = true
		
		if side == "LEFT":
			wall_jump_dir = global_transform.basis.x * wall_jump_horizontal_power
		elif side == "RIGHT":
			wall_jump_dir = -global_transform.basis.x * wall_jump_horizontal_power
		
		wall_jump_dir *= wall_jump_factor
		
		if is_wallrun_jumping:
			direction = (direction * (1- wall_jump_factor)) + wall_jump_dir
			return
	
	
	
	if can_wallrun == true:
		if is_on_wall() and Input.is_action_pressed("Up"):
			
			var collision = get_slide_collision(0)
			var wall_normal = collision.get_normal()
			
			var wallrun_dir = Vector3.UP.cross(wall_normal)
			
			var player_view_dir = -camera.global_transform.basis.z
			var dot = wallrun_dir.dot(player_view_dir)
			if dot<0:
				wallrun_dir = -wallrun_dir
				
			wallrun_dir += -wall_normal *0.01
			
			is_wallrunning = true
			
			side = get_side(collision.get_position())
			
			velocity.y = -0.01
			direction = wallrun_dir
			
		else: 
			is_wallrunning = false
	if not is_on_wall():
		is_wallrunning = false
func process_wallrun_rotation(delta):
	if is_wallrunning:
		
		if side == "RIGHT":
			wallrun_current_angle += delta * 70
			wallrun_current_angle = clamp(wallrun_current_angle, -wallrun_angle, wallrun_angle)
		elif side == "LEFT":
			wallrun_current_angle -= delta * 70
			wallrun_current_angle = clamp(wallrun_current_angle, -wallrun_angle, wallrun_angle)
	
	
	# Return back to normal view
	else:
		if wallrun_current_angle > 0:
			wallrun_current_angle -= delta * 40
			wallrun_current_angle = max(0, wallrun_current_angle)
		elif wallrun_current_angle < 0:
			wallrun_current_angle += delta * 40
			wallrun_current_angle = min(wallrun_current_angle, 0)
	
	
	neck2.rotation_degrees = Vector3(0, 0, 1) * wallrun_current_angle

func get_side(point):
	point = to_local(point)
	
	if point.x > 0:
		return "RIGHT"
	elif point.x < 0:
		return "LEFT"
	else: 
		return "CENTER"



func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * GLB.sensitivity / 25)
		
		var mouse_y = -event.relative.y * GLB.sensitivity / 25
		x_rotation += mouse_y
		camera.rotate_x(-event.relative.y *GLB.sensitivity/25)
		x_rotation = clamp(x_rotation, -1.5, 1.5)
		
		camera.rotation.x = x_rotation

func sprint(): #(Run this function in physics process delta)
	if Input.is_action_pressed("Sprint"):
		if walking==true:#(when moving set the walking to true)
				SPEED = sprinting_speed
				camera.fov = lerp(camera.fov, CameraSprintFov, 0.075) #(this is for FOV change of camera so you would need a refrence to camera)
				sprinting= true
	
	
	if not Input.is_action_pressed("Sprint") or stamina <= 0:
			camera.fov = lerp(camera.fov, CameraNormalFov, 0.1)
			sprinting = false
			stamina = stamina + 1
			stamina = clamp(stamina, -1, 100)



func jump(): #Jump, you can do tripple or any amount jump by changing 'max jump' var
	
	
	if Input.is_action_just_pressed("Jump") and jump_count< max_jump:
		jumptimer.start()
		velocity.y = velocity.y + JUMP_VELOCITY
		play_random_jump_sound()
		neck.rotation.x = lerp_angle(neck.rotation.x, deg_to_rad(-2), 0.35)
	if PlayerColor != "Orange": 
		max_jump = 1
	elif PlayerColor != "Red" : 
		max_jump= 2
	if is_on_floor() :
		jump_count = 0

func play_random_jump_sound() -> void:
	var jump_sounds = [jump_sound, jump_sound_2]
	var random_index = randi() % jump_sounds.size()
	jump_sounds[random_index].play()


func ColorChanging(color: Variant):
	PlayerColor = color


#region Color Regions
func OnBlack(): #what to do when standing on black
	SPEED = 3
	sprinting_speed = 4
	JUMP_VELOCITY = 4
	CameraSprintFov = 80.0
	CameraNormalFov = 65.0
	GLB.Can_hook = true

func OnOrange():
	max_jump = 3
	
	SPEED =  8
	sprinting_speed = 9.0
	

func OnRed(): #what to do when standing on red
	SPEED =  8
	sprinting_speed = 13
	JUMP_VELOCITY = 5
	CameraSprintFov = 110.0
	CameraNormalFov = 80.0
	max_jump = 1
	lerp_amount = 0.12

func OnGreen(): #what to do when standing on green
	AutoJumping(AutojumpingValue)
	
func OnBlue():
	lerp_amount = 0.005
	JUMP_VELOCITY = 8
	SPEED =  8
	sprinting_speed = 12
	CameraSprintFov = 110.0
	CameraNormalFov = 90.0
	max_jump = 1
	gravity = Vector3(0,-12,0)

#endregion

func stop_animations():
	neck_animation.stop()
	

func normal(): #when youre on something which is not in any group
	SPEED = 5.0
	JUMP_VELOCITY = 4.5
	sprinting_speed = 10
	CameraNormalFov = 75.0
	CameraSprintFov = 90.0
	lerp_amount = 0.09

func AutoJumping(JumpValue: float): #Autojumping, for slimy object
	velocity.y = JumpValue * 1.5
	green_jump_pad_sound.play()
	SlimeJump = true
	neck_animation.stop()
	neck_animation.play("MiniJump")
	jumptimer.start(0.4)
	
	if is_on_floor() and CanSlimeJump == true: 
		AutoJumping(AutojumpingValue)

func NotSameColor(): #function of what to do when our color doesnt match to what Im standing on 
	dead()
	pass

func dead():
	GLB.emit_signal("Died")


func jumppadeffect():
	JumppadTimer.start()
	jumppading = true
	neck_animation.stop()
	neck_animation.play("JumpPad")
	


#region Timers And signal

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
#endregion


func _on_wallrun_delay_timeout() -> void:
	CanWallrunDelay = false
