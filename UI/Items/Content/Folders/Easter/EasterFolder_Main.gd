extends FolderData

func GetUnlockPassword() -> String:
	return String.num_int64(GameGlobals._MainScene.EasterRandomPassword)
