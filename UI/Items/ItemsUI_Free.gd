@tool
extends ItemsUIBase
class_name ItemsUI_Free

var ItemArray: Array[ItemsUI_Item] = []

func ReBuild():
	
	if not is_node_ready():
		return
	
	var ItemNum := ItemArray.size()
	var ItemIndex := 0
	
	for SampleItem: ItemsUI_Item in ItemArray:
		
		if SampleItem:
			var OffsetX := SampleItem.size.x * (ItemIndex - ItemNum / 2)
			SampleItem.position = size * 0.5 + Vector2(OffsetX, 0.0)
		ItemIndex += 1

func RegisterItem(InItem: ItemsUI_Item):
	
	ItemArray.append(InItem)

func GetItemArray() -> Array[ItemsUI_Item]:
	return ItemArray
