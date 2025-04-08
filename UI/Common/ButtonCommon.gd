extends BaseButton
class_name ButtonCommon

func _gui_input(InEvent: InputEvent) -> void:
	
	if InEvent is InputEventMouseButton:
		if InEvent.button_index == MOUSE_BUTTON_LEFT and InEvent.pressed:
			GameGlobals._MouseClick.play()
