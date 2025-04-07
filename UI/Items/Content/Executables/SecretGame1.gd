extends MiniGameData

func HandlePreOpenWindow(InItem: ItemsUI_Item):
	
	await super(InItem)
	
	if InItem.WasOpened:
		return
	
	var SecretGame1CutScene := CutScene.BeginCutScene(load("res://Scenes/CutScenes/Content/SecretGame1/CutSceneData.tres"))
	
	await SecretGame1CutScene.Finished
