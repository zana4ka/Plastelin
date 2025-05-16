@tool
extends Control
class_name ItemsUI_GridCell

@export var GridPosition: Vector2i = Vector2i.ZERO:
	set(InPosition):
		var PrevPosition := GridPosition
		GridPosition = InPosition
		HandleGridPositionChanged(PrevPosition)

@onready var ParentContainer: ItemsUIBase = get_parent() as ItemsUIBase

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	
	if not InData is ItemsUI_GridCell or InData == self:
		return false
	
	var DropCell := InData as ItemsUI_GridCell
	return ParentContainer == DropCell.ParentContainer

func _drop_data(AtPosition: Vector2, InData: Variant):
	
	GameGlobals._PhotoPickUp.play()
	
	var DropCell := InData as ItemsUI_GridCell
	SwapGridPositionWith(DropCell)

func HandleGridPositionChanged(InPrevPosition: Vector2i):
	pass

func SwapGridPositionWith(InItem: ItemsUI_GridCell):
	InItem.GridPosition = GridPosition
