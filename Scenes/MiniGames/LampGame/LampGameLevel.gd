extends MiniGameLevel
class_name LampGameLevel

func _ready() -> void:
	OwnerMiniGameUI._Header._Close.visible = false

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	return InData is LampGameLevel_Document

func _drop_data(AtPosition: Vector2, InData: Variant) -> void:
	
	var _Document := InData as LampGameLevel_Document
	_Document.position = AtPosition + _Document.get_meta(&"Offset")
	
	_Document.move_to_front()
	_Document.visible = true
