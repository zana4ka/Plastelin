extends Resource
class_name CutSceneData

@export_category("Fade")
@export_color_no_alpha var FadeColor: Color = Color(0.4, 0.0, 0.0)
@export var FadeDuration: float = 0.5
@export var SkipFirstFrameFade: bool = true

@export_category("Frames")
@export var FrameTextureArray: Array[Texture2D] = []
@export_multiline var FrameTextArray: Array[String] = []

@export var FrameTextColor: Color = Color(0.8, 0.0, 0.0, 1.0)

func HandlePendingFrame(InCutScene: CutScene, InSkipAnimation: bool):
	
	if FadeDuration > 0.0:
		
		InCutScene._AnimationPlayer.play(&"NextFrame", -1.0, 1.0 / FadeDuration)
		InCutScene._Text.visible = false
		
		if InSkipAnimation:
			InCutScene._AnimationPlayer.advance(1.0)
		
	else:
		InCutScene.ShowFrame_UpdateFrame()
	
	InCutScene.NextFrameMinTimeTicksMs += int(FadeDuration * 1000.0)
