extends MiniGameLevel
class_name ShovelGameLevel

@onready var _Shake: Shake = $Control/Shake
@onready var DigParticles: CPUParticles2D = $Control/DigParticles

@onready var Coffin: AnimatedSprite2D = $Control/Coffin
@onready var Password: Sprite2D = $Control/Coffin/Password
#@onready var Interact: Button = $Control/Coffin/Interact

@onready var Shovel: AnimatedSprite2D = $Control/Shovel
@onready var ShovelResetTimer: Timer = $Control/Shovel/ResetTimer

@onready var Key: TextureRect = $Key
@onready var KeyAP: AnimationPlayer = $Key/AP
@onready var KeyLabel: Label = $Key/Label

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

var ProgressTicks: int = 0:
	set(InTicks):
		
		ProgressTicks = InTicks
		Coffin.frame = (ProgressTicks + 1) / 3
		Shovel.frame = ProgressTicks % 3

func _ready() -> void:
	
	ProgressTicks = 0
	
	#Interact.pressed.connect(OnInteractPressed)
	ShovelResetTimer.timeout.connect(ResetShovel)
	
	Password.visible = false
	
	#OwnerMiniGameUI._Header._Close.disabled = true
	
	_Shake.ShakeTarget = OwnerMiniGameUI
	
	ProgressCooldownTimeLeft = 0.6
	
	ResetCurrentKey()

var ProgressCooldownTimeLeft: float = 0.0

func _process(InDelta: float) -> void:
	
	if not IsFinished:
		if ProgressCooldownTimeLeft > 0.0:
			
			ProgressCooldownTimeLeft -= InDelta
			
			if ProgressCooldownTimeLeft <= 0.0:
				SetNewKey()

var NextKeyId: int = 0:
	set(InId):
		
		NextKeyId = InId
		KeyLabel.text = OS.get_keycode_string(NextKeyId)
		
		if NextKeyId == KEY_NONE:
			Key.visible = false
			KeyAP.stop()
		else:
			Key.visible = true
			KeyAP.play(&"Flicker", -1.0, 2.0)

func SetNewKey():
	assert(ProgressCooldownTimeLeft <= 0.0)
	NextKeyId = randi_range(KEY_A, KEY_Z)

func ResetCurrentKey():
	assert(ProgressCooldownTimeLeft > 0.0)
	NextKeyId = KEY_NONE

#func OnInteractPressed():
#	TryProgress()

func _unhandled_input(InEvent: InputEvent):
	
	assert(not IsFinished)
	if not InEvent is InputEventKey:
		return
	
	if InEvent.physical_keycode != NextKeyId:
		return
	
	if ProgressCooldownTimeLeft > 0.0:
		return
	
	ProgressTicks += 1
	#Interact.text = String.num_int64(ProgressTicks)
	
	if ProgressTicks % 3 == 2:
		
		_Shake.Start(Vector2(5.0, 5.0), 0.02, 1.0)
		DigParticles.restart()
		
		GameGlobals._DirtDigging.play()
		_AnimationPlayer.play(&"NextLayer")
		
		ProgressCooldownTimeLeft = 0.5
		
	elif ProgressTicks % 3 == 0:
		
		GameGlobals._WindowClose.play()
		ProgressCooldownTimeLeft = 0.1
		
	else:
		GameGlobals._WindowCollapse.play()
		_Shake.Start(Vector2(2.0, 2.0), 0.002, 2.0)
		
		ProgressCooldownTimeLeft = 0.2
	
	assert(ProgressTicks <= 11)
	if ProgressTicks == 11:
		IsFinished = true
	
	ResetCurrentKey()

var IsFinished: bool = false:
	set(InIsFinished):
		
		IsFinished = InIsFinished
		
		if IsFinished:
			
			Coffin.frame = 4
			ShovelResetTimer.start()
			
			Password.visible = true
			#Interact.visible = false
			set_process_unhandled_input(false)
			
			GameGlobals._MainScene.BeginScene2()

func ResetShovel():
	Shovel.frame = 0
