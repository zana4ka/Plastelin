extends PanelContainer
class_name WindowUI

@export var DragPreviewScene: PackedScene = preload("res://UI/Windows/WindowUI_DragPreview.tscn")

var OwnerItem: ItemsUI_Item:
	set(InItem):
		OwnerItem = InItem
		if is_node_ready():
			UpdateFromOwnerItem()

func _ready() -> void:
	
	focus_mode = Control.FOCUS_ALL
	focus_entered.connect(OnFocusEntered)
	
	UpdateFromOwnerItem()
	TryUnfold()

func _enter_tree() -> void:
	GameGlobals._MainScene.WindowsDictionary[OwnerItem] = self

func _exit_tree() -> void:
	GameGlobals._MainScene.WindowsDictionary.erase(OwnerItem)

func _get_drag_data(AtPosition: Vector2) -> Variant:
	
	var DragPreview := DragPreviewScene.instantiate() as Control
	DragPreview.size = size
	DragPreview.Offset = -AtPosition
	set_drag_preview(DragPreview)
	
	set_meta(&"DragOffset", -AtPosition)
	GameGlobals.IsDraggingWindow = true
	
	return self

func OnFocusEntered():
	move_to_front()

func UpdateFromOwnerItem():
	pass

func TryCollapse() -> bool:
	return false

func TryExpand() -> bool:
	return false

func TryClose() -> bool:
	queue_free()
	return true

var IsUnfolded: bool = false

func TryUnfold() -> bool:
	IsUnfolded = true
	return IsUnfolded
