extends Button
class_name TaskbarUI_Tab

var OwnerWindowUI: WindowUI

func _ready() -> void:
	
	toggled.connect(OnToggled)
	
	UpdateFromOwner()

func UpdateFromOwner():
	
	OwnerWindowUI.UnfoldedChanged.connect(OnWindowUnfoldedChanged)
	
	var _OwnerItemData := OwnerWindowUI.OwnerItem._Data
	if _OwnerItemData:
		icon = _OwnerItemData.IconTexture
		text = _OwnerItemData.Name

func OnToggled(InToggledOn: bool):
	
	if InToggledOn:
		OwnerWindowUI.TryUnfold()
	else:
		OwnerWindowUI.TryCollapse()

func OnWindowUnfoldedChanged():
	button_pressed = OwnerWindowUI.IsUnfolded()
