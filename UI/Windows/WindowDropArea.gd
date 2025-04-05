extends Control
class_name WindowDropArea

func _notification(InCode: int) -> void:
	if InCode == Node.NOTIFICATION_DRAG_BEGIN:
		if GameGlobals.IsDraggingWindow:
			mouse_filter = Control.MOUSE_FILTER_STOP
			move_to_front()
	elif InCode == Node.NOTIFICATION_DRAG_END:
		GameGlobals.IsDraggingWindow = false
		mouse_filter = Control.MOUSE_FILTER_IGNORE

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	return InData is WindowUI

func _drop_data(AtPosition: Vector2, InData: Variant):
	if InData is WindowUI:
		InData.global_position = InData.get_meta(&"DragOffset") + AtPosition
