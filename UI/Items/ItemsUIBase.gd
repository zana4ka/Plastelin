extends Control
class_name ItemsUIBase

func _ready():
	ReBuild()

func ReBuild():
	pass

func RegisterItem(InItem: ItemsUI_Item):
	pass

func ReplaceItemsOnPositions(InA: Vector2i, InB: Vector2i):
	pass

func GetItemArray() -> Array[ItemsUI_Item]:
	assert(false)
	return []

## Runtime item adding
func AddNewItem(InData: ItemData) -> ItemsUI_Item:
	
	var OutItem := GameGlobals.ItemScene.instantiate() as ItemsUI_Item
	OutItem._Data = InData
	add_child(OutItem)
	return OutItem

func RemoveAllItems():
	
	var ItemArray := GetItemArray()
	for SampleItem: ItemsUI_Item in ItemArray:
		SampleItem.queue_free()
	ItemArray.clear()
