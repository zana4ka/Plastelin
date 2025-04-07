extends PanelContainer
class_name WindowUI

var OwnerItem: ItemsUI_Item:
	set(InItem):
		
		OwnerItem = InItem
		
		if is_node_ready():
			UpdateFromOwnerItem()

var TaskbarTab: TaskbarUI_Tab

func _ready() -> void:
	
	#clip_contents = true
	
	focus_mode = Control.FOCUS_ALL
	focus_entered.connect(OnFocusEntered)
	
	UpdateFromOwnerItem()
	TryUnfold()

func _get_drag_data(AtPosition: Vector2) -> Variant:
	
	var DragPreview := GameGlobals.WindowDragPreviewScene.instantiate() as Control
	DragPreview.size = size
	DragPreview.Offset = -AtPosition
	set_drag_preview(DragPreview)
	
	set_meta(&"DragPreview", DragPreview)
	GameGlobals.IsDraggingWindow = true
	return self

func OnFocusEntered():
	move_to_front()

func UpdateFromOwnerItem():
	pass

func TryCollapse() -> bool:
	
	if not IsUnfolded():
		return false
	
	visible = false
	set_meta(&"IsUnfolded", false)
	UnfoldedChanged.emit()
	
	return not IsUnfolded()

func IsExpanded() -> bool:
	return get_meta(&"IsExpanded", false)

func TryExpand() -> bool:
	
	if IsExpanded():
		size = get_meta(&"DefaultSize")
		position = get_meta(&"PreviousPosition")
		
		set_meta(&"IsExpanded", false)
	else:
		set_meta(&"DefaultSize", size)
		set_meta(&"PreviousPosition", position)
		
		size = GameGlobals._MainScene._DesktopCanvas._Windows.size
		position = Vector2.ZERO
		
		set_meta(&"IsExpanded", true)
	return IsExpanded()

func TryClose(InForceRemove: bool = false) -> bool:
	queue_free()
	return true

signal UnfoldedChanged()

func IsUnfolded() -> bool:
	return get_meta(&"IsUnfolded", false)

func TryUnfold() -> bool:
	
	if IsUnfolded():
		grab_focus.call_deferred()
		return false
	
	visible = true
	set_meta(&"IsUnfolded", true)
	UnfoldedChanged.emit()
	
	grab_focus.call_deferred()
	
	return IsUnfolded()

func CreateTaskbarTab() -> TaskbarUI_Tab:
	
	TaskbarTab = GameGlobals.TaskbarTabScene.instantiate() as TaskbarUI_Tab
	TaskbarTab.OwnerWindowUI = self
	return TaskbarTab
