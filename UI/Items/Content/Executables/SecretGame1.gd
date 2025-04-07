extends MiniGameData

func HandlePreOpenWindow(InItem: ItemsUI_Item) -> bool:
	
	if not super(InItem):
		return false
	
	if InItem.WasOpened:
		return true
	
	var SecretGame1CutScene := CutScene.BeginCutScene(load("res://Scenes/CutScenes/Content/SecretGame1/CutSceneData.tres"))
	
	await SecretGame1CutScene.Finished
	return true
