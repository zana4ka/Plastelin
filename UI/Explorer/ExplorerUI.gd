extends Window
class_name ExplorerUI

@onready var _ItemsUI: ItemsUI = $Panel/VB/ItemsUI

var _FolderData: FolderData:
	set(InData):
		_FolderData = InData
		if is_node_ready():
			UpdateFromFolderData()

func _ready() -> void:
	UpdateFromFolderData()

func UpdateFromFolderData():
	
	_ItemsUI.RemoveAllItems()
	
	for SampleInnerItemData: ItemData in _FolderData.InnerItemDataArray:
		_ItemsUI.AddNewItem(SampleInnerItemData)
