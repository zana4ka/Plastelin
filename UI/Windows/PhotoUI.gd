extends WindowUI
class_name PhotoUI

@onready var _Photo: TextureRect = $VB/Control/Photo

func _ready() -> void:
	super()

func UpdateFromOwnerItem():
	
	super()
	
	var _PhotoData := OwnerItem._Data as PhotoData
	_Photo.texture = _PhotoData.PhotoTexture
