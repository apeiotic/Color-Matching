extends Node

@onready var musics = [$"Background Music 1",$"Background Music2",$"Background Music3"]
@onready var ambient = [$"Ambient Sound 1", $"Ambient Sound 2"]
@onready var background_music_1: AudioStreamPlayer2D = $"Background Music 1"
@onready var background_music_2: AudioStreamPlayer2D = $"Background Music2"
@onready var background_music_3: AudioStreamPlayer2D = $"Background Music3"
@onready var ambient_sound_1: AudioStreamPlayer2D = $"Ambient Sound 1"
@onready var ambient_sound_2: AudioStreamPlayer2D = $"Ambient Sound 2"
@onready var win_sound: AudioStreamPlayer2D = $WinSound
@onready var wind_sound: AudioStreamPlayer2D = $WindSound


func _ready() -> void:
	GLB.connect("Died", Callable(self, "dead"))
	GLB.connect("Restarted", Callable(self, "restarted"))
	PlayBackgroundSoundeffect()
	PlayAmbientSoundEffect()

func PlayBackgroundSoundeffect():
	var BackgroundMusic = musics[randi() % musics.size()]
	BackgroundMusic.play()

func PlayAmbientSoundEffect():
	var AmbientSound = ambient[randi() % ambient.size()]
	AmbientSound.play()

func dead():
	print("Dead Func called")
	background_music_3.volume_db = -35
	background_music_2.volume_db = -35
	background_music_1.volume_db = -35
	ambient_sound_1.volume_db = -55
	ambient_sound_2.volume_db = -55
	wind_sound.volume_db = -55
	
func restarted():
	background_music_3.volume_db = 0
	background_music_2.volume_db = 0
	background_music_1.volume_db = 0
	wind_sound.volume_db = 0


func BackgroundSoundFinished() -> void:
	PlayBackgroundSoundeffect()
	

func AmbientSoundEffectFinsihed() -> void:
	PlayAmbientSoundEffect()
