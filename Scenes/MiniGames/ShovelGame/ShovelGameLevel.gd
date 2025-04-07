extends MiniGameLevel
class_name ShovelGameLevel

@onready var _Shake: Shake = $Control/Shake
@onready var DigParticles: CPUParticles2D = $Control/DigParticles

@onready var Coffin: AnimatedSprite2D = $Control/Coffin
@onready var Hint: Sprite2D = $Control/Coffin/Hint
@onready var Interact: Button = $Control/Coffin/Interact

@onready var Shovel: AnimatedSprite2D = $Control/Shovel
@onready var ShovelResetTimer: Timer = $Control/Shovel/ResetTimer

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

var ProgressTicks: int = 0:
	set(InTicks):
		
		ProgressTicks = InTicks
		Coffin.frame = (ProgressTicks + 1) / 3
		Shovel.frame = ProgressTicks % 3

func _ready() -> void:
	
	ProgressTicks = 0
	
	Interact.pressed.connect(OnInteractPressed)
	ShovelResetTimer.timeout.connect(ResetShovel)
	
	Hint.visible = false
	
	#OwnerMiniGameUI._Header._Close.disabled = true
	
	_Shake.ShakeTarget = OwnerMiniGameUI

func OnInteractPressed():
	TryProgress()

var NextProgressMinTimeTicksMs: int = 0

func TryProgress() -> bool:
	
	if NextProgressMinTimeTicksMs < Time.get_ticks_msec():
		
		ProgressTicks += 1
		#Interact.text = String.num_int64(ProgressTicks)
		
		if ProgressTicks % 3 == 2:
			
			_Shake.Start(Vector2(5.0, 5.0), 0.02, 1.0)
			DigParticles.restart()
			
			_AnimationPlayer.play(&"NextLayer")
			
			NextProgressMinTimeTicksMs = Time.get_ticks_msec() + 500
			
		elif ProgressTicks % 3 == 0:
			
			pass
			
		else:
			_Shake.Start(Vector2(2.0, 2.0), 0.002, 2.0)
			
			NextProgressMinTimeTicksMs = Time.get_ticks_msec() + 200
		
		if ProgressTicks == 11:
			FinishGame()
		
		return true
	return false

func FinishGame():
	
	Coffin.frame = 4
	ShovelResetTimer.start()
	
	Hint.visible = true
	Interact.visible = false
	
	GameGlobals._MainScene.BeginScene2()

func ResetShovel():
	Shovel.frame = 0
