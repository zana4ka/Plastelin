extends CanvasLayer
class_name DesktopCanvas

@onready var _MainControl: Control = $MainControl

@onready var _Background: TextureRect = $MainControl/Background
@onready var _ItemsUI: ItemsUI_Grid = $MainControl/ItemsUI

@onready var _Windows: Control = $MainControl/Windows
@onready var _WindowsDropArea: WindowsDropArea = $MainControl/Windows/DropArea
@onready var _TaskbarUI: TaskbarUI = $MainControl/TaskbarUI

## Keys are ItemsUI_Item instance ids
var WindowsDictionary: Dictionary[ItemData, WindowUI] = {}
@export var WindowsLimit: int = 6

func _ready() -> void:
	pass

func TryOpenWindowForItem(InItem: ItemsUI_Item, OnScreenCenter: bool, InIgnoreLimits: bool = false) -> WindowUI:
	
	var _ItemData := InItem._Data
	CloseInvalidWindows()
	
	if WindowsDictionary.has(_ItemData):
		if WindowsDictionary[_ItemData].TryUnfold():
			return WindowsDictionary[_ItemData]
		else:
			return null
	
	if not InIgnoreLimits and WindowsDictionary.size() > WindowsLimit:
		TryOpenTabsMessageWindow()
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
	
	var OwnerItemData := InWindow.OwnerItem._Data
	WindowsDictionary[OwnerItemData] = InWindow
	
	assert(InWindow.TaskbarTab == null)
	_TaskbarUI.AddTabFor(InWindow)

## UnRegister + remove the tab
func OnWindowTreeExiting(InWindow: WindowUI) -> void:
	
	if is_instance_valid(InWindow.OwnerItem):
		var OwnerItemData := InWindow.OwnerItem._Data
		WindowsDictionary.erase(OwnerItemData)
	#else:
	#	push_error("InWindow.OwnerItem is invalid!")
	
	assert(InWindow.TaskbarTab != null)
	InWindow.TaskbarTab.queue_free()

func SetBackground(InTexture: Texture2D):
	_Background.texture = InTexture

func CloseInvalidWindows():
	
	for SampleItemData: ItemData in WindowsDictionary.keys():
		if not is_instance_valid(WindowsDictionary[SampleItemData]):
			WindowsDictionary.erase(SampleItemData)

func CloseAllWindows():
	
	for SampleItemData: ItemData in WindowsDictionary.keys():
		WindowsDictionary[SampleItemData].TryClose()
	WindowsDictionary.clear()

var HelpDocument: ItemsUI_Item
var EasterFolder: ItemsUI_Item
var TabsMessageFile: ItemsUI_Item

func TryOpenHelpWindow():
	if is_instance_valid(HelpDocument):
		TryOpenWindowForItem(HelpDocument, true)

func TryOpenEasterWindow():
	if is_instance_valid(EasterFolder):
		TryOpenWindowForItem(EasterFolder, true)

func TryOpenTabsMessageWindow():
	
	if is_instance_valid(TabsMessageFile):
		
		if WindowsDictionary.has(TabsMessageFile._Data):
			var MessageWindow := WindowsDictionary[TabsMessageFile._Data] as MessageUI
			MessageWindow.PlayPopUp()
		else:
			TryOpenWindowForItem(TabsMessageFile, true, true)
