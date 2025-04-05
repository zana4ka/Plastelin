@tool
extends Control
class_name DesktopUI_IconBase

@export var GridPosition: Vector2i = Vector2i.ZERO:
	set(InPosition):
		var PrevPosition := GridPosition
		GridPosition = InPosition
		HandleGridPositionChanged(PrevPosition)

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	return true

func _drop_data(AtPosition: Vector2, InData: Variant):
	var DropIcon := InData as DesktopUI_IconBase
	SwapGridPositionWith(DropIcon)

func HandleGridPositionChanged(InPrevPosition: Vector2i):
	pass

func SwapGridPositionWith(InIcon: DesktopUI_IconBase):
	InIcon.GridPosition = GridPosition
