extends FolderData

func HandlePostOpenWindow(InItem: ItemsUI_Item):
	GameGlobals._MainScene.FinalFolderOpenCounter += 1
