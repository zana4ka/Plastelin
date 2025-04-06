extends Control
class_name WindowsDropArea

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
		
		var DragPreview := InData.get_meta(&"DragPreview") as WindowUI_DragPreview
		InData.global_position = DragPreview.Offset + AtPosition
