extends Node2D
class_name MainScene

@export var ExplorerUIScene: PackedScene = preload("res://UI/Explorer/ExplorerUI.tscn")

@onready var _PlayerCamera: PlayerCamera = $PlayerCamera
@onready var _DesktopCanvas: CanvasLayer = $DesktopCanvas

func _ready():
	pass

func _enter_tree() -> void:
	GameGlobals._MainScene = self

func _exit_tree() -> void:
	GameGlobals._MainScene = null

func TryOpenFolder(InData: FolderData):
	
	var NewExplorer := ExplorerUIScene.instantiate() as ExplorerUI
	NewExplorer._FolderData = InData
	add_child(NewExplorer)
