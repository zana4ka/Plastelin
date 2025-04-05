extends WindowUI
class_name MiniGameUI

@onready var _SubViewportContainer: SubViewportContainer = $VB/SubViewportContainer

var _MiniGameLevel: MiniGameLevel

func _ready() -> void:
	
	#_CanvasLayer.focus_entered.connect(OnFocusEntered)
	
	super()

func UpdateFromOwnerItem():
	
	for SampleChild: Node in _SubViewportContainer.get_children():
		SampleChild.queue_free()
	
	var _MiniGameData := OwnerItem._Data as MiniGameData
	_MiniGameLevel = _MiniGameData.MiniGameScene.instantiate()
	_SubViewportContainer.add_child(_MiniGameLevel)
