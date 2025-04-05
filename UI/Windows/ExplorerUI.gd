extends WindowUI
class_name DocumentUI

@onready var _ItemsUI: ItemsUI_Grid = $VB/Control/ItemsUI

func _ready() -> void:
	super()

func UpdateFromOwnerItem():
	
	_ItemsUI.RemoveAllItems()
	
	var OwnerFolderData := OwnerItem._Data as FolderData
	for SampleInnerItemData: ItemData in OwnerFolderData.InnerItemDataArray:
		_ItemsUI.AddNewItem(SampleInnerItemData)
