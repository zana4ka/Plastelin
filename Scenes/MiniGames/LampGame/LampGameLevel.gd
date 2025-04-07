extends MiniGameLevel
class_name LampGameLevel

func _ready() -> void:
	#OwnerMiniGameUI._Header._Close.disabled = true
	pass

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	return InData is LampGameLevel_Photo

func _drop_data(AtPosition: Vector2, InData: Variant) -> void:
	
	var _Photo := InData as LampGameLevel_Photo
	_Photo.position = AtPosition + _Photo.get_meta(&"Offset")
	
	_Photo.move_to_front()
	_Photo.visible = true
