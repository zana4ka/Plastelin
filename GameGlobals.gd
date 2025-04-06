extends Node

@export var ExplorerUIScene: PackedScene = preload("res://UI/Windows/ExplorerUI.tscn")
@export var DocumentUIScene: PackedScene = preload("res://UI/Windows/DocumentUI.tscn")
@export var PhotoUIScene: PackedScene = preload("res://UI/Windows/PhotoUI.tscn")
@export var MiniGameUIScene: PackedScene = preload("res://UI/Windows/MiniGameUI.tscn")

@export var ItemScene: PackedScene = preload("res://UI/Items/ItemsUI_Item.tscn")
@export var EmptyGridCellScene: PackedScene = preload("res://UI/Items/ItemsUI_EmptyGridCell.tscn")

@export var TaskbarTabScene: PackedScene = preload("res://UI/Taskbar/TaskbarUI_Tab.tscn")

var _MainScene: MainScene

var IsDraggingWindow: bool = false

func CreateWindowForItem(InItem: ItemsUI_Item) -> WindowUI:
	
	var OutWindow: WindowUI = null
	
	if InItem._Data is FolderData:
		OutWindow = ExplorerUIScene.instantiate()
	elif InItem._Data is DocumentData:
		OutWindow = DocumentUIScene.instantiate()
	elif InItem._Data is PhotoData:
		OutWindow = PhotoUIScene.instantiate()
	elif InItem._Data is MiniGameData:
		OutWindow = MiniGameUIScene.instantiate()
	return OutWindow

func GetOnScreenClampedPosition_TopLeftAnchors(InControl: Control) -> Vector2:
	
	var PositionBoundaries = InControl.get_viewport_rect().grow_individual(-8.0, -8.0, -InControl.size.x - 8.0, -InControl.size.y - 72.0)
	
	var CurrentPosition := InControl.get_screen_position()
	var ClampedPosition := CurrentPosition
	
	ClampedPosition.x = clampf(CurrentPosition.x, PositionBoundaries.position.x, PositionBoundaries.end.x)
	ClampedPosition.y = clampf(CurrentPosition.y, PositionBoundaries.position.y, PositionBoundaries.end.y)
	return ClampedPosition
