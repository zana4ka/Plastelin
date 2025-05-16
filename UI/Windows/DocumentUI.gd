extends WindowUI
class_name DocumentUI

@onready var _Text: TextEdit = $VB/MC/Text

func _ready() -> void:
	
	_Text.focus_entered.connect(OnFocusEntered)
	_Text.text_changed.connect(OnTextChanged)
	
	GameGlobals.LanguageChanged.connect(OnLanguageChanged)
	
	super()

func UpdateFromOwnerItem():
	
	super()
	
	var _DocumentData := OwnerItem._Data as DocumentData
	_Text.editable = _DocumentData.IsEditable
	UpdateText()

func UpdateText():
	var _DocumentData := OwnerItem._Data as DocumentData
	_Text.text = _DocumentData.get_meta(&"EditedText", _DocumentData.GetDocumentText())

func OnTextChanged():
	OwnerItem._Data.set_meta(&"EditedText", _Text.text)

func OnLanguageChanged():
	UpdateText()
