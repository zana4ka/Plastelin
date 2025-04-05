extends Control
class_name ExplorerUI_DragPreview

var Offset: Vector2:
	set(InOffset):
		Offset = InOffset
		$Panel.position = Offset
