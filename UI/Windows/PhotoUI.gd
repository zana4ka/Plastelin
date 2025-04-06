extends WindowUI
class_name PhotoUI

@onready var _Photo: TextureRect = $VB/Control/Photo

func _ready() -> void:
	
	#_Image.focus_entered.connect(OnFocusEntered)
	
	super()

func UpdateFromOwnerItem():
	
	var _PhotoData := OwnerItem._Data as PhotoData
	_Photo.texture = _PhotoData.PhotoTexture
