extends Node2D
class_name MainScene

@onready var _PlayerCamera: PlayerCamera = $PlayerCamera
@onready var _DesktopCanvas: DesktopCanvas = $DesktopCanvas

var WindowsArray: Array[WindowUI] = []

func _ready():
	pass

func _enter_tree() -> void:
	GameGlobals._MainScene = self

func _exit_tree() -> void:
	GameGlobals._MainScene = null

func TryOpenFolder(InFolderItem: ItemsUI_Item) -> ExplorerUI:
	
	var NewExplorer := GameGlobals.ExplorerUIScene.instantiate() as ExplorerUI
	NewExplorer._FolderItem = InFolderItem
	_DesktopCanvas.add_child(NewExplorer)
	return NewExplorer
