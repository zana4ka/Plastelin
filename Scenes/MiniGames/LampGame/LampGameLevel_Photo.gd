extends TextureRect
class_name LampGameLevel_Photo

func _ready() -> void:
	pass

func _notification(InCode: int) -> void:
	if InCode == Node.NOTIFICATION_DRAG_BEGIN:
		mouse_filter = Control.MOUSE_FILTER_IGNORE
	elif InCode == Node.NOTIFICATION_DRAG_END:
		mouse_filter = Control.MOUSE_FILTER_STOP
		visible = true

func _get_drag_data(AtPosition: Vector2) -> Variant:
	
	var DragPreview := Control.new()
	var DragTexture := duplicate(DUPLICATE_USE_INSTANTIATION) as TextureRect
	
	DragTexture.size = size
	DragTexture.position = -AtPosition
	DragPreview.add_child(DragTexture)
	set_drag_preview(DragPreview)
	
	set_meta(&"Offset", -AtPosition)
	visible = false
	GameGlobals._PhotoPickUp.play()
	return self
