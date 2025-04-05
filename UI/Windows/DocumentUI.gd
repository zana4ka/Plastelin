extends WindowUI
class_name DocumentUI

@onready var _Text: TextEdit = $VB/Control/Text

func _ready() -> void:
	
	_Text.focus_entered.connect(OnFocusEntered)
	
	super()

func UpdateFromOwnerItem():
	
	var _DocumentData := OwnerItem._Data as DocumentData
	_Text.text = _DocumentData.DocumentText
