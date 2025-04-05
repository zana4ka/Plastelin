extends ItemData
class_name FolderData

@export var InnerItemDataArray: Array[ItemData] = []

func TryOpen(InItemUI: ItemsUI_Item) -> bool:
	return GameGlobals._MainScene.TryOpenFolder(InItemUI) != null
