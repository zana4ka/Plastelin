extends DocumentData

func GetDocumentText() -> String:
	return String.num_int64(GameGlobals._MainScene.EasterRandomPassword).right(2)
