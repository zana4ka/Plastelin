extends FolderData

func HandlePostOpenWindow(InItem: ItemsUI_Item):
	await GameGlobals._MainScene.BeginScene8()
