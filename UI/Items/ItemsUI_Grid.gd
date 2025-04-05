@tool
extends ItemsUIBase
class_name ItemsUI_Grid

@onready var SelfGrid: GridContainer = self as Control as GridContainer

var ItemDictionary: Dictionary[Vector2i, ItemsUI_Item] = {}
var EmptyGridCellDictionary: Dictionary[Vector2i, Control] = {}

func GetMaxPosition() -> Vector2i:
	
	var OutMax := Vector2i.ZERO
	for SamplePosition: Vector2i in ItemDictionary.keys():
		OutMax = OutMax.max(SamplePosition)
	return OutMax.max(Vector2i(12, 4))

func ReBuild():
	
	if not is_node_ready():
		return
	
	#print("ReBuild...")
	
	for SamplePosition: Vector2i in ItemDictionary.keys():
		if ItemDictionary[SamplePosition] == null:
			ItemDictionary.erase(SamplePosition)
	
	for SamplePosition: Vector2i in EmptyGridCellDictionary.keys():
		EmptyGridCellDictionary[SamplePosition].queue_free()
	EmptyGridCellDictionary.clear()
	
	var MaxPosition := GetMaxPosition()
	SelfGrid.columns = MaxPosition.x + 1
	
	var ChildIndex := 0
	for SampleY: int in MaxPosition.y + 1:
		for SampleX: int in MaxPosition.x + 1:
			
			var SamplePosition := Vector2i(SampleX, SampleY)
			if ItemDictionary.has(SamplePosition):
				
				var SampleIcon := ItemDictionary[SamplePosition]
				move_child(SampleIcon, ChildIndex)
				SampleIcon.SkipReplace = true
				SampleIcon.GridPosition = SamplePosition
				SampleIcon.SkipReplace = false
			else:
				var NewEmptyGridCell := GameGlobals.EmptyGridCellScene.instantiate() as ItemsUI_GridCell
				NewEmptyGridCell.GridPosition = SamplePosition
				
				add_child(NewEmptyGridCell)
				move_child(NewEmptyGridCell, ChildIndex)
				EmptyGridCellDictionary[SamplePosition] = NewEmptyGridCell
			
			ChildIndex += 1

func RegisterItem(InItem: ItemsUI_Item):
	
	var TargetPosition := InItem.GridPosition
	
	if ItemDictionary.has(TargetPosition):
		
		var MaxPosition := GetMaxPosition()
		
		var HasFound := false
		for SampleX: int in MaxPosition.x + 1:
			for SampleY: int in MaxPosition.y + 1:
				
				var SamplePosition := Vector2i(SampleX, SampleY)
				if ItemDictionary.has(SamplePosition):
					pass
				else:
					TargetPosition = SamplePosition
					HasFound = true
					break
			if HasFound:
				break
	
	if ItemDictionary.has(TargetPosition):
		push_error("TargetPosition is still invalid! Can't add Icon.")
	
	if EmptyGridCellDictionary.has(TargetPosition):
		EmptyGridCellDictionary[TargetPosition].queue_free()
		EmptyGridCellDictionary.erase(TargetPosition)
	
	ItemDictionary[TargetPosition] = InItem
	ReBuild()

func ReplaceItemsOnPositions(InA: Vector2i, InB: Vector2i):
	
	if InA == InB:
		return
	
	var IconA: ItemsUI_Item = ItemDictionary[InA] if ItemDictionary.has(InA) else null
	var IconB: ItemsUI_Item = ItemDictionary[InB] if ItemDictionary.has(InB) else null
	
	ItemDictionary[InA] = IconB
	ItemDictionary[InB] = IconA
	
	ReBuild()

func GetItemArray() -> Array[ItemsUI_Item]:
	return ItemDictionary.values()

func RemoveAllItems():
	super()
	ItemDictionary.clear()
