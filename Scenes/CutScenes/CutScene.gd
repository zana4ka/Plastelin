extends Control
class_name CutScene

static func BeginCutScene(InData: CutSceneData) -> CutScene:
	
	var NewCutScene := GameGlobals.CutSceneScene.instantiate() as CutScene
	NewCutScene._Data = InData
	GameGlobals._MainScene._CutSceneCanvas.add_child(NewCutScene)
	return NewCutScene

@export var FrameScene: PackedScene = preload("res://Scenes/CutScenes/CutScene_Frame.tscn")

@onready var FrameSwitcher: TabContainer = $FrameSwitcher
@onready var _Fade: ColorRect = $Fade
@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

var _Data: CutSceneData

var FrameArray: Array[CutScene_Frame] = []

func _ready() -> void:
	InitFromData()

func InitFromData():
	
	assert(FrameArray.is_empty())
	
	for SampleChild: Node in FrameSwitcher.get_children():
		SampleChild.queue_free()
	
	_Fade.color = _Data.FadeColor
	
	assert(not _Data.FrameTextureArray.is_empty())
	
	for SampleFrameIndex: int in range(_Data.FrameTextureArray.size()):
		
		var SampleFrame := FrameScene.instantiate() as CutScene_Frame
		
		SampleFrame.texture_normal = _Data.FrameTextureArray[SampleFrameIndex]
		SampleFrame.pressed.connect(TryShowFrame.bind(SampleFrameIndex + 1))
		
		FrameSwitcher.add_child(SampleFrame)
		FrameArray.append(SampleFrame)
	
	TryShowFrame(0, true)

var PendingFrame: int = -1

func TryShowFrame(InFrame: int, InSkipAnimation: bool = false) -> bool:
	
	if _AnimationPlayer.is_playing():
		return false
	
	PendingFrame = InFrame
	
	if _Data.FadeDuration > 0.0:
		_AnimationPlayer.play(&"NextFrame", -1.0, 1.0 / _Data.FadeDuration)
		
		if InSkipAnimation:
			_AnimationPlayer.advance(1.0)
		
	else:
		ShowFrame_UpdateFrame()
	
	return true

func ShowFrame_UpdateFrame():
	
	if PendingFrame < FrameArray.size():
		FrameSwitcher.visible = true
		FrameSwitcher.current_tab = PendingFrame
	else:
		FinishCutScene(true)

signal Finished()

func FinishCutScene(InWaitForAnimation: bool):
	
	FrameSwitcher.visible = false
	Finished.emit()
	
	if InWaitForAnimation and _AnimationPlayer.is_playing():
		await _AnimationPlayer.animation_finished
	
	queue_free()
