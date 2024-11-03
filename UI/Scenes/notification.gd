extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ColorName: Label = $MarginContainer/VBoxContainer/Label
@onready var PerksName: Label = $MarginContainer/VBoxContainer/Label2
@onready var LifeTimer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("new_animation")
	GLB.connect("Notification_color", Callable(self, "GiveTextColorAndText"))
	GLB.connect("Notification_Abilitytext", Callable(self, "GiveAbilityList"))
	hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func GiveTextColorAndText(GivenColor, Text):
	ColorName.add_theme_color_override("font_color", GivenColor)
	ColorName.text = Text
	animation_player.play("new_animation")
	show()
	LifeTimer.start()
	

func GiveAbilityList(AbilityList):
	PerksName.text = AbilityList


func _on_timer_timeout() -> void:
	animation_player.play("FromEnd")
	await animation_player.animation_finished
	hide()
	
