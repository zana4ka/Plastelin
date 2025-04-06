extends MiniGameLevel
class_name ShovelGameLevel

@onready var _Shake: Shake = $Control/Shake
@onready var DigParticles: CPUParticles2D = $Control/Shake/DigParticles
@onready var Interact: Button = $Control/Shake/GroundFrames/Interact

func _ready() -> void:
	Interact.pressed.connect(OnInteractPressed)

func OnInteractPressed():
	TryProgress()

var LastProgressTimeTicksMs: int = 0

func TryProgress() -> bool:
	
	if LastProgressTimeTicksMs + 1000 < Time.get_ticks_msec():
		
		LastProgressTimeTicksMs = Time.get_ticks_msec()
		
		_Shake.Start(Vector2(4.0, 4.0), 0.04, 1.0)
		DigParticles.restart()
		
		return true
	return false
