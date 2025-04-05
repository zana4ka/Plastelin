extends Window
class_name ExplorerUI

@onready var _ItemsUI: ItemsUI = $Panel/VB/Control/ItemsUI

var _FolderItem: ItemsUI_Item:
	set(InItem):
		_FolderItem = InItem
		if is_node_ready():
			UpdateFromFolderItem()

func _ready() -> void:
	UpdateFromFolderItem()

func UpdateFromFolderItem():
	
	_ItemsUI.RemoveAllItems()
	
	var _FolderData := _FolderItem._Data as FolderData
	for SampleInnerItemData: ItemData in _FolderData.InnerItemDataArray:
		_ItemsUI.AddNewItem(SampleInnerItemData)
