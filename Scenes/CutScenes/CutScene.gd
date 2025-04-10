extends Control
class_name CutScene

static func BeginCutScene(InData: CutSceneData) -> CutScene:
	
	var NewCutScene := GameGlobals.CutSceneScene.instantiate() as CutScene
	NewCutScene._Data = InData
	GameGlobals._MainScene._CutSceneCanvas.add_child(NewCutScene)
	return NewCutScene

@onready var _CurrentFrame: CutScene_Frame = $CurrentFrame
@onready var _Fade: ColorRect = $Fade
@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

var _Data: CutSceneData

func _ready() -> void:
	
	_CurrentFrame.pressed.connect(OnCurrentFramePressed)
	
	InitFromData()

func _unhandled_input(InEvent: InputEvent) -> void:
	
	if InEvent is InputEventKey:
		if InEvent.is_pressed():
			OnCurrentFramePressed()

func InitFromData():
	
	assert(_Fade.visible)
	assert(not _Data.FrameArray.is_empty())
	
	_CurrentFrame.visible = false
	TryShowFrame(0)
	
	NextFrameMinTimeTicksMs = maxi(NextFrameMinTimeTicksMs, Time.get_ticks_msec() + 500)

var NextFrameMinTimeTicksMs: int = 0
var PendingFrame: int = 0

func OnCurrentFramePressed():
	TryShowFrame(PendingFrame + 1)

func TryShowFrame(InFrame: int) -> bool:
	
	if Time.get_ticks_msec() < NextFrameMinTimeTicksMs:
		return false
	
	PendingFrame = InFrame
	NextFrameMinTimeTicksMs = Time.get_ticks_msec()
	
	_Data.HandleShowFrame(self)
	return true

func TryShowFrame_UpdateFrame():
	_Data.HandleShowFrame_UpdateFrame(self)

signal Finished()

func FinishCutScene(InWaitForAnimation: bool = true):
	
	_CurrentFrame.visible = false
	Finished.emit()
	
	if InWaitForAnimation and _AnimationPlayer.is_playing():
		await _AnimationPlayer.animation_finished
	
	queue_free()
