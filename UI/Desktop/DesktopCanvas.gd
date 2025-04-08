extends CanvasLayer
class_name DesktopCanvas

@onready var _MainControl: Control = $MainControl

@onready var _Background: TextureRect = $MainControl/Background
@onready var _ItemsUI: ItemsUI_Grid = $MainControl/ItemsUI

@onready var _Windows: Control = $MainControl/Windows
@onready var _WindowsDropArea: WindowsDropArea = $MainControl/Windows/DropArea
@onready var _TaskbarUI: TaskbarUI = $MainControl/TaskbarUI

## Keys are ItemsUI_Item instance ids
var WindowsDictionary: Dictionary[int, WindowUI] = {}

func _ready() -> void:
	pass

func TryOpenWindowForItem(InItem: ItemsUI_Item, OnScreenCenter: bool) -> WindowUI:
	
	var ItemInstanceId := InItem.get_instance_id()
	CloseInvalidWindows()
	
	if WindowsDictionary.has(ItemInstanceId):
		if WindowsDictionary[ItemInstanceId].TryUnfold():
			return WindowsDictionary[ItemInstanceId]
		else:
			return null
	
	if WindowsDictionary.size() > 5:
		GameGlobals._Error.play()
		OS.alert("Too many tabs!")
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
	await InItem._Data.HandlePostOpenWindow(InItem)
	return NewWindow

## Register + create the tab
func OnWindowTreeEntered(InWindow: WindowUI) -> void:
	
	if not is_instance_valid(InWindow.OwnerItem):
		push_error("InWindow.OwnerItem is invalid!")
		return
	
	var OwnerItemInstanceId := InWindow.OwnerItem.get_instance_id()
	WindowsDictionary[OwnerItemInstanceId] = InWindow
	
	assert(InWindow.TaskbarTab == null)
	_TaskbarUI.AddTabFor(InWindow)

## UnRegister + remove the tab
func OnWindowTreeExiting(InWindow: WindowUI) -> void:
	
	if is_instance_valid(InWindow.OwnerItem):
		var OwnerItemInstanceId := InWindow.OwnerItem.get_instance_id()
		WindowsDictionary.erase(OwnerItemInstanceId)
	#else:
	#	push_error("InWindow.OwnerItem is invalid!")
	
	assert(InWindow.TaskbarTab != null)
	InWindow.TaskbarTab.queue_free()

## Remove the window if exists
func OnItemTreeExiting(InItem: ItemsUI_Item) -> void:
	
	var ItemInstanceId := InItem.get_instance_id()
	if InItem.is_queued_for_deletion() and WindowsDictionary.has(ItemInstanceId):
		WindowsDictionary[ItemInstanceId].queue_free()

func SetBackground(InTexture: Texture2D):
	_Background.texture = InTexture

func CloseInvalidWindows():
	
	for SampleInstanceId: int in WindowsDictionary.keys():
		if not is_instance_valid(WindowsDictionary[SampleInstanceId]):
			WindowsDictionary.erase(SampleInstanceId)

func CloseAllWindows():
	
	for SampleInstanceId: int in WindowsDictionary.keys():
		WindowsDictionary[SampleInstanceId].TryClose()
	WindowsDictionary.clear()

var EasterFolder: ItemsUI_Item

func TryOpenEasterWindow():
	if is_instance_valid(EasterFolder):
		TryOpenWindowForItem(EasterFolder, true)
