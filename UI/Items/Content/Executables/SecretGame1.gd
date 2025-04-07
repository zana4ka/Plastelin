extends MiniGameData

func HandlePreOpenWindow(InItem: ItemsUI_Item):
	
	var SecretGame1CutScene := CutScene.BeginCutScene(load("res://Scenes/CutScenes/Content/SecretGame1/CutSceneData.tres"))
	
	await SecretGame1CutScene.Finished
	
