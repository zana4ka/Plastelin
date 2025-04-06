extends CanvasLayer
class_name DesktopCanvas

@onready var _MyComputer: ItemsUI_Item = $ItemsUI/MyComputer
@onready var _SecretFolder1: ItemsUI_Item = $ItemsUI/SecretFolder1
@onready var _Recycle: ItemsUI_Item = $ItemsUI/Recycle

@onready var _Windows: Control = $Windows
@onready var _WindowsDropArea: WindowsDropArea = $Windows/DropArea
@onready var _TaskbarUI: TaskbarUI = $TaskbarUI

var WindowsDictionary: Dictionary[ItemsUI_Item, WindowUI] = {}

func _ready() -> void:
	pass

func TryOpenWindowForItem(InItem: ItemsUI_Item) -> WindowUI:
	
	if WindowsDictionary.has(InItem):
		if WindowsDictionary[InItem].TryUnfold():
			return WindowsDictionary[InItem]
		else:
			return null
	
	var NewWindow := GameGlobals.CreateWindowForItem(InItem) as WindowUI
	NewWindow.OwnerItem = InItem
	NewWindow.tree_entered.connect(OnWindowTreeEntered.bind(NewWindow))
	NewWindow.tree_exiting.connect(OnWindowTreeExiting.bind(NewWindow))
	_Windows.add_child(NewWindow)
	NewWindow.global_position = InItem.get_global_mouse_position() + InItem.size * Vector2(0.2, -0.4)
	return NewWindow

## Register + create the tab
func OnWindowTreeEntered(InWindow: WindowUI) -> void:
	
	WindowsDictionary[InWindow.OwnerItem] = InWindow
	
	assert(InWindow.TaskbarTab == null)
	_TaskbarUI.AddTabFor(InWindow)

## UnRegister + remove the tab
func OnWindowTreeExiting(InWindow: WindowUI) -> void:
	
	WindowsDictionary.erase(InWindow.OwnerItem)
	
	assert(InWindow.TaskbarTab != null)
	InWindow.TaskbarTab.queue_free()
