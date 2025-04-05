extends Control
class_name WindowUI_DragPreview

var Offset: Vector2:
	set(InOffset):
		Offset = InOffset
		$Panel.position = Offset
