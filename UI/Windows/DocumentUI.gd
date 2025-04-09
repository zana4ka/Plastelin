extends WindowUI
class_name DocumentUI

@onready var _Text: TextEdit = $VB/Control/Text

func _ready() -> void:
	
	_Text.focus_entered.connect(OnFocusEntered)
	_Text.text_changed.connect(OnTextChanged)
	
	super()

func UpdateFromOwnerItem():
	
	super()
	
	var _DocumentData := OwnerItem._Data as DocumentData
	_Text.text = _DocumentData.get_meta(&"EditedText", _DocumentData.GetDocumentText())
	_Text.editable = _DocumentData.IsEditable

func OnTextChanged():
	OwnerItem._Data.set_meta(&"EditedText", _Text.text)
