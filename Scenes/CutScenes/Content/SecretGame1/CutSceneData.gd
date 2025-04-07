extends CutSceneData

func HandlePendingFrame(InCutScene: CutScene, InSkipAnimation: bool):
	
	super(InCutScene, InSkipAnimation)
	
	if InCutScene.CurrentFrame == 0:
		InCutScene.NextFrameMinTimeTicksMs += 600
