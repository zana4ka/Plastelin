extends ItemData
class_name FolderData

@export var ExplorerPathStart: String = "DESKTOP_PATH"
@export var InnerItemDataArray: Array[ItemData] = []

var GeneratedPath: String = ""

func TryGeneratePathsRecursive(InCurrentStack: Array[FolderData] = []) -> bool:
	
	if not GeneratedPath.is_empty():
		return false
	
	assert(not InCurrentStack.has(self))
	GeneratedPath = TranslationServer.translate(ExplorerPathStart)
	
	## Create new array
	var LocalStack := InCurrentStack.duplicate()
	LocalStack.append(self)
	
	for SampleItemData: ItemData in LocalStack:
		GeneratedPath += "\\" + TranslationServer.translate(SampleItemData.Name)
	
	for SampleItemData: ItemData in InnerItemDataArray:
		if SampleItemData is FolderData:
			SampleItemData.TryGeneratePathsRecursive(LocalStack)
	return true
