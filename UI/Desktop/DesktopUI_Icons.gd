@tool
extends GridContainer
class_name DesktopUI_Icons

@export var EmptyIconScene: PackedScene = preload("res://UI/Desktop/DesktopUI_EmptyIcon.tscn")

var IconDictionary: Dictionary[Vector2i, DesktopUI_Icon] = {}
var EmptyIconDictionary: Dictionary[Vector2i, Control] = {}

func _ready():
	ReBuild()

func GetMaxPosition() -> Vector2i:
	
	var OutMax := Vector2i.ZERO
	for SamplePosition: Vector2i in IconDictionary.keys():
		OutMax = OutMax.max(SamplePosition)
	return OutMax.max(Vector2i(15, 5))

func ReBuild():
	
	if not is_node_ready():
		return
	
	#print("ReBuild...")
	
	for SamplePosition: Vector2i in IconDictionary.keys():
		if IconDictionary[SamplePosition] == null:
			IconDictionary.erase(SamplePosition)
	
	for SamplePosition: Vector2i in EmptyIconDictionary.keys():
		EmptyIconDictionary[SamplePosition].queue_free()
	EmptyIconDictionary.clear()
	
	var MaxPosition := GetMaxPosition()
	columns = MaxPosition.x + 1
	
	var ChildIndex := 0
	for SampleY: int in MaxPosition.y + 1:
		for SampleX: int in MaxPosition.x + 1:
			
			var SamplePosition := Vector2i(SampleX, SampleY)
			if IconDictionary.has(SamplePosition):
				var SampleIcon := IconDictionary[SamplePosition]
				move_child(SampleIcon, ChildIndex)
				SampleIcon.GridPosition = SamplePosition
			else:
				var NewEmptyIcon := EmptyIconScene.instantiate() as DesktopUI_IconBase
				NewEmptyIcon.GridPosition = SamplePosition
				
				add_child(NewEmptyIcon)
				move_child(NewEmptyIcon, ChildIndex)
				EmptyIconDictionary[SamplePosition] = NewEmptyIcon
			
			ChildIndex += 1

func AddIcon(InIcon: DesktopUI_Icon):
	
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
	
	if EmptyIconDictionary.has(TargetPosition):
		EmptyIconDictionary[TargetPosition].queue_free()
		EmptyIconDictionary.erase(TargetPosition)
	
	IconDictionary[TargetPosition] = InIcon
	ReBuild()

func ReplaceIconsOnPositions(InA: Vector2i, InB: Vector2i):
	
	if InA == InB:
		return
	
	var IconA: DesktopUI_Icon = IconDictionary[InA] if IconDictionary.has(InA) else null
	var IconB: DesktopUI_Icon = IconDictionary[InB] if IconDictionary.has(InB) else null
	
	IconDictionary[InA] = IconB
	IconDictionary[InB] = IconA
	
	ReBuild()
