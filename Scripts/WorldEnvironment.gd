extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Graphics.world_environment = self



func _on_timer_timeout() -> void:
	environment.sdfgi_enabled = false
