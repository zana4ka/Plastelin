extends Node2D
class_name MainScene

@onready var _PlayerCamera: PlayerCamera = $PlayerCamera
@onready var _DesktopCanvas: DesktopCanvas = $DesktopCanvas

var WindowsDictionary: Dictionary[ItemsUI_Item, WindowUI] = {}

func _ready():
	pass

func _enter_tree() -> void:
	GameGlobals._MainScene = self

func _exit_tree() -> void:
	GameGlobals._MainScene = null

func TryOpenItem(InItem: ItemsUI_Item) -> WindowUI:
	
	if WindowsDictionary.has(InItem):
		if WindowsDictionary[InItem].IsUnfolded:
			return WindowsDictionary[InItem]
		if WindowsDictionary[InItem].TryUnfold():
			return WindowsDictionary[InItem]
		else:
			return null
	
	var NewWindow := GameGlobals.CreateWindowForItem(InItem) as WindowUI
	NewWindow.OwnerItem = InItem
	_DesktopCanvas.add_child(NewWindow)
	NewWindow.global_position = get_global_mouse_position() + InItem.size * Vector2(0.8, -0.2)
	return NewWindow
