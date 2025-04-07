extends WindowUI
class_name MiniGameUI

@onready var _Header: WindowUI_Header = $VB/Header
@onready var _SubViewport: SubViewport = $VB/SubViewportContainer/SubViewport

var _MiniGameLevel: MiniGameLevel

func _ready() -> void:
	
	#_CanvasLayer.focus_entered.connect(OnFocusEntered)
	
	super()
	
	position = get_parent_area_size() * 0.5 - size * 0.5
	position.y -= 32.0

func UpdateFromOwnerItem():
	
	for SampleChild: Node in _SubViewport.get_children():
		SampleChild.queue_free()
	
	var _MiniGameData := OwnerItem._Data as MiniGameData
	_MiniGameLevel = _MiniGameData.MiniGameScene.instantiate()
	_MiniGameLevel.OwnerMiniGameUI = self
	_SubViewport.add_child(_MiniGameLevel)
