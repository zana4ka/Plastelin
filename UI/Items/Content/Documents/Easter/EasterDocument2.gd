extends DocumentData

func GetDocumentText() -> String:
	return String.num_int64(GameGlobals._MainScene.EasterRandomPassword).left(2)
