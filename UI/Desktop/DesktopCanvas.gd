extends CanvasLayer
class_name DesktopCanvas

@onready var _Background: TextureRect = $Background
@onready var _ItemsUI: ItemsUI_Grid = $ItemsUI

@onready var _Windows: Control = $Windows
@onready var _WindowsDropArea: WindowsDropArea = $Windows/DropArea
@onready var _TaskbarUI: TaskbarUI = $TaskbarUI

var WindowsDictionary: Dictionary[ItemsUI_Item, WindowUI] = {}

func _ready() -> void:
	pass

func TryOpenWindowForItem(InItem: ItemsUI_Item, OnScreenCenter: bool) -> WindowUI:
	
	if WindowsDictionary.has(InItem):
		if WindowsDictionary[InItem].TryUnfold():
			return WindowsDictionary[InItem]
		else:
			return null
	
	if not await InItem._Data.HandlePreOpenWindow(InItem):
		return null
	
	var NewWindow := GameGlobals.CreateWindowForItem(InItem) as WindowUI
	NewWindow.OwnerItem = InItem
	NewWindow.tree_entered.connect(OnWindowTreeEntered.bind(NewWindow))
	NewWindow.tree_exiting.connect(OnWindowTreeExiting.bind(NewWindow))
	_Windows.add_child(NewWindow)
	
	if OnScreenCenter:
		NewWindow.position = _Windows.size * 0.5 - NewWindow.size * 0.5
		NewWindow.position.y -= 32.0
	else:
		NewWindow.position = _Windows.get_global_mouse_position() + Vector2(24.0, -48.0)
	NewWindow.position = GameGlobals.GetOnScreenClampedPosition_TopLeftAnchors(NewWindow)
	InItem._Data.HandlePostOpenWindow(InItem)
	return NewWindow

## Register + create the tab
func OnWindowTreeEntered(InWindow: WindowUI) -> void:
	
	WindowsDictionary[InWindow.OwnerItem] = InWindow
	
	assert(InWindow.TaskbarTab == null)
	_TaskbarUI.AddTabFor(InWindow)

## UnRegister + remove the tab
func OnWindowTreeExiting(InWindow: WindowUI) -> void:
	
	if is_instance_valid(InWindow.OwnerItem):
		WindowsDictionary.erase(InWindow.OwnerItem)
	
	assert(InWindow.TaskbarTab != null)
	InWindow.TaskbarTab.queue_free()

## Remove the window if exists
func OnItemTreeExiting(InItem: ItemsUI_Item) -> void:
	if InItem.is_queued_for_deletion() and WindowsDictionary.has(InItem):
		WindowsDictionary[InItem].queue_free()

func SetBackground(InTexture: Texture2D):
	_Background.texture = InTexture

func CloseAllWindows():
	
	for SampleWindowUI in WindowsDictionary.values():
		if is_instance_valid(SampleWindowUI):
			SampleWindowUI.TryClose.call_deferred(true)
	await get_tree().process_frame
