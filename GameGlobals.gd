extends Node

@export var ExplorerUIScene: PackedScene = preload("res://UI/Windows/ExplorerUI.tscn")

@export var ItemScene: PackedScene = preload("res://UI/Items/ItemsUI_Item.tscn")
@export var EmptyGridCellScene: PackedScene = preload("res://UI/Items/ItemsUI_EmptyGridCell.tscn")

var _MainScene: MainScene

var IsDraggingWindow: bool = false
