extends CutSceneData

func HandleShowFrame(InCutScene: CutScene):
	
	super(InCutScene)
	
	if InCutScene.CurrentFrame == 0:
		InCutScene.NextFrameMinTimeTicksMs += 500
