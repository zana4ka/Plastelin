extends MiniGameLevel
class_name ShovelGameLevel

@onready var _Shake: Shake = $Control/Shake
@onready var DigParticles: CPUParticles2D = $Control/DigParticles

@onready var Coffin: AnimatedSprite2D = $Control/Coffin
@onready var Interact: Button = $Control/Coffin/Interact

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

var ProgressTicks: int = 0

func _ready() -> void:
	
	Interact.pressed.connect(OnInteractPressed)
	
	#OwnerMiniGameUI._Header._Close.disabled = true
	
	_Shake.ShakeTarget = OwnerMiniGameUI

func OnInteractPressed():
	TryProgress()

var NextProgressMinTimeTicksMs: int = 0

func TryProgress() -> bool:
	
	if NextProgressMinTimeTicksMs < Time.get_ticks_msec():
		
		ProgressTicks += 1
		#Interact.text = String.num_int64(ProgressTicks)
		
		if ProgressTicks % 2 == 0:
			
			_Shake.Start(Vector2(5.0, 5.0), 0.02, 1.0)
			DigParticles.restart()
			
			Coffin.frame = ProgressTicks / 2
			_AnimationPlayer.play(&"NextLayer")
			
			NextProgressMinTimeTicksMs = Time.get_ticks_msec() + 1000
		else:
			_Shake.Start(Vector2(2.0, 2.0), 0.002, 2.0)
			
			NextProgressMinTimeTicksMs = Time.get_ticks_msec() + 400
		
		if ProgressTicks == 6:
			FinishGame()
		
		return true
	return false

func FinishGame():
	
	Interact.disabled = true
	
	GameGlobals._MainScene.BeginScene2()
