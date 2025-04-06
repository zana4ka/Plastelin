extends MarginContainer
class_name TaskbarUI_Tab

@onready var _Button: Button = $Button

var OwnerWindowUI: WindowUI

func _ready() -> void:
	
	_Button.toggled.connect(OnButtonToggled)
	
	UpdateFromOwner()

func UpdateFromOwner():
	
	OwnerWindowUI.UnfoldedChanged.connect(OnWindowUnfoldedChanged)
	
	var _OwnerItemData := OwnerWindowUI.OwnerItem._Data
	if _OwnerItemData:
		_Button.icon = _OwnerItemData.IconTexture
		_Button.text = _OwnerItemData.Name

func OnButtonToggled(InToggledOn: bool):
	
	if InToggledOn:
		OwnerWindowUI.TryUnfold()
	else:
		OwnerWindowUI.TryCollapse()

func OnWindowUnfoldedChanged():
	_Button.button_pressed = OwnerWindowUI.IsUnfolded()
