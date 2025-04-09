extends WindowUI
class_name MiniGameUI

@onready var _Header: WindowUI_Header = $VB/Header
@onready var _Viewport: SubViewport = $VB/ViewportPanel/Container/Viewport

var _MiniGameLevel: MiniGameLevel

func _ready() -> void:
	
	#_CanvasLayer.focus_entered.connect(OnFocusEntered)
	
	super()

func _enter_tree() -> void:
	GameGlobals._MainScene._DesktopCanvas.WindowsLimit += 1

func _exit_tree() -> void:
	GameGlobals._MainScene._DesktopCanvas.WindowsLimit -= 1

func UpdateFromOwnerItem():
	
	super()
	
	for SampleChild: Node in _Viewport.get_children():
		SampleChild.queue_free()
	
	var _MiniGameData := OwnerItem._Data as MiniGameData
	_MiniGameLevel = _MiniGameData.MiniGameScene.instantiate()
	_MiniGameLevel.OwnerMiniGameUI = self
	_Viewport.add_child(_MiniGameLevel)

func TryClose(InForceRemove: bool = false) -> bool:
	return super(InForceRemove) if InForceRemove else TryCollapse()
