extends MiniGameData

func HandlePreOpenWindow(InItem: ItemsUI_Item) -> bool:
	
	if not super(InItem):
		return false
	
	if InItem.WasOpened():
		return true
	
	var ShovelGameCutScene := CutScene.BeginCutScene(load("res://Scenes/CutScenes/Content/ShovelGame/CutSceneData.tres"))
	
	await ShovelGameCutScene.Finished
	return true
