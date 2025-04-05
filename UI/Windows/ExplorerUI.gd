extends WindowUI
class_name ExplorerUI

@onready var _ItemsUI: ItemsUI_Grid = $VB/Control/ItemsUI

var _FolderItem: ItemsUI_Item:
	set(InItem):
		_FolderItem = InItem
		if is_node_ready():
			UpdateFromFolderItem()

func _ready() -> void:
	
	super()
	
	UpdateFromFolderItem()

func UpdateFromFolderItem():
	
	_ItemsUI.RemoveAllItems()
	
	var _FolderData := _FolderItem._Data as FolderData
	for SampleInnerItemData: ItemData in _FolderData.InnerItemDataArray:
		_ItemsUI.AddNewItem(SampleInnerItemData)
