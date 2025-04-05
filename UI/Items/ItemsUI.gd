@tool
extends GridContainer
class_name ItemsUI

var IconDictionary: Dictionary[Vector2i, ItemsUI_Item] = {}
var EmptyGridCellDictionary: Dictionary[Vector2i, Control] = {}

func _ready():
	ReBuild()

func GetMaxPosition() -> Vector2i:
	
	var OutMax := Vector2i.ZERO
	for SamplePosition: Vector2i in IconDictionary.keys():
		OutMax = OutMax.max(SamplePosition)
	return OutMax.max(Vector2i(12, 4))

func ReBuild():
	
	if not is_node_ready():
		return
	
	#print("ReBuild...")
	
	for SamplePosition: Vector2i in IconDictionary.keys():
		if IconDictionary[SamplePosition] == null:
			IconDictionary.erase(SamplePosition)
	
	for SamplePosition: Vector2i in EmptyGridCellDictionary.keys():
		EmptyGridCellDictionary[SamplePosition].queue_free()
	EmptyGridCellDictionary.clear()
	
	var MaxPosition := GetMaxPosition()
	columns = MaxPosition.x + 1
	
	var ChildIndex := 0
	for SampleY: int in MaxPosition.y + 1:
		for SampleX: int in MaxPosition.x + 1:
			
			var SamplePosition := Vector2i(SampleX, SampleY)
			if IconDictionary.has(SamplePosition):
				var SampleIcon := IconDictionary[SamplePosition]
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

func RegisterItem(InIcon: ItemsUI_Item):
	
	var TargetPosition := InIcon.GridPosition
	
	if IconDictionary.has(TargetPosition):
		
		var MaxPosition := GetMaxPosition()
		
		var HasFound := false
		for SampleX: int in MaxPosition.x + 1:
			for SampleY: int in MaxPosition.y + 1:
				
				var SamplePosition := Vector2i(SampleX, SampleY)
				if IconDictionary.has(SamplePosition):
					pass
				else:
					TargetPosition = SamplePosition
					HasFound = true
					break
			if HasFound:
				break
	
	if IconDictionary.has(TargetPosition):
		push_error("TargetPosition is still invalid! Can't add Icon.")
	
	if EmptyGridCellDictionary.has(TargetPosition):
		EmptyGridCellDictionary[TargetPosition].queue_free()
		EmptyGridCellDictionary.erase(TargetPosition)
	
	IconDictionary[TargetPosition] = InIcon
	ReBuild()

func ReplaceIconsOnPositions(InA: Vector2i, InB: Vector2i):
	
	if InA == InB:
		return
	
	var IconA: ItemsUI_Item = IconDictionary[InA] if IconDictionary.has(InA) else null
	var IconB: ItemsUI_Item = IconDictionary[InB] if IconDictionary.has(InB) else null
	
	IconDictionary[InA] = IconB
	IconDictionary[InB] = IconA
	
	ReBuild()

## Runtime item adding
func AddNewItem(InData: ItemData) -> ItemsUI_Item:
	
	var OutItem := GameGlobals.ItemScene.instantiate() as ItemsUI_Item
	OutItem._Data = InData
	add_child(OutItem)
	return OutItem

func RemoveAllItems():
	
	for SamplePosition: Vector2i in IconDictionary.keys():
		IconDictionary[SamplePosition].queue_free()
	IconDictionary.clear()
