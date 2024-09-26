extends Node2D
@onready var label = $Label
@onready var timer = $Timer
@onready var total_time_seconds : int = 00
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	total_time_seconds += 1
	var min = int(total_time_seconds / 60)
	var sec= total_time_seconds - min *60
	$Label.text = '%02d: %02d' % [min, sec]
