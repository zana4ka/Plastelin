extends Node

@export var ExplorerUIScene: PackedScene = preload("res://UI/Windows/ExplorerUI.tscn")
@export var DocumentUIScene: PackedScene = preload("res://UI/Windows/DocumentUI.tscn")

@export var ItemScene: PackedScene = preload("res://UI/Items/ItemsUI_Item.tscn")
@export var EmptyGridCellScene: PackedScene = preload("res://UI/Items/ItemsUI_EmptyGridCell.tscn")

var _MainScene: MainScene

var IsDraggingWindow: bool = false

func CreateWindowForItem(InItem: ItemsUI_Item) -> WindowUI:
	
	var OutWindow: WindowUI = null
	
	if InItem._Data is FolderData:
		OutWindow = ExplorerUIScene.instantiate()
	elif InItem._Data is DocumentData:
		OutWindow = DocumentUIScene.instantiate()
	return OutWindow
