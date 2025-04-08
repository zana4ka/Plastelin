extends Control
class_name CutScene

static func BeginCutScene(InData: CutSceneData) -> CutScene:
	
	var NewCutScene := GameGlobals.CutSceneScene.instantiate() as CutScene
	NewCutScene._Data = InData
	GameGlobals._MainScene._CutSceneCanvas.add_child(NewCutScene)
	return NewCutScene

@onready var _CurrentFrame: CutScene_Frame = $CurrentFrame
@onready var _Text: Label = $Text
@onready var _Fade: ColorRect = $Fade
@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

var _Data: CutSceneData

func _ready() -> void:
	
	_CurrentFrame.pressed.connect(OnCurrentFramePressed)
	
	InitFromData()

func InitFromData():
	
	assert(_Fade.visible)
	_Fade.color = _Data.FadeColor
	
	assert(not _Data.FrameTextureArray.is_empty())
	
	_Text.visible = false
	_CurrentFrame.visible = false
	TryShowFrame(0)

var NextFrameMinTimeTicksMs: int = 0
var CurrentFrame: int = 0

func OnCurrentFramePressed():
	TryShowFrame(CurrentFrame + 1)

func TryShowFrame(InFrame: int) -> bool:
	
	if Time.get_ticks_msec() < NextFrameMinTimeTicksMs:
		return false
	
	CurrentFrame = InFrame
	NextFrameMinTimeTicksMs = Time.get_ticks_msec()
	
	_Data.HandleShowFrame(self)
	return true

func ShowFrame_UpdateFrame():
	
	if CurrentFrame < _Data.FrameTextureArray.size():
		
		_CurrentFrame.visible = true
		_CurrentFrame.texture_normal = _Data.FrameTextureArray[CurrentFrame]
		
		if CurrentFrame < _Data.FrameTextArray.size():
			_Text.text = _Data.FrameTextArray[CurrentFrame]
			_Text.visible = true
	else:
		FinishCutScene(true)

signal Finished()

func FinishCutScene(InWaitForAnimation: bool = true):
	
	_CurrentFrame.visible = false
	Finished.emit()
	
	if InWaitForAnimation and _AnimationPlayer.is_playing():
		await _AnimationPlayer.animation_finished
	
	queue_free()
