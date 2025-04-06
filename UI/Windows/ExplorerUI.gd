extends WindowUI
class_name ExplorerUI

@onready var _ItemsUI: ItemsUI_Grid = $VB/SC/ItemsUI

func _ready() -> void:
	super()

func UpdateFromOwnerItem():
	
	_ItemsUI.RemoveAllItems()
	
	var OwnerFolderData := OwnerItem._Data as FolderData
	for SampleInnerItemData: ItemData in OwnerFolderData.InnerItemDataArray:
		_ItemsUI.AddNewItem(SampleInnerItemData)
