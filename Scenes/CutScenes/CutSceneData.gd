extends Resource
class_name CutSceneData

@export_category("Frames")
@export var FrameArray: Array[CutSceneData_FrameData] = []

@export_category("FadeFrom")
@export_color_no_alpha var FadeFromColor: Color = Color(0.8, 0.0, 0.0)
@export var FadeFromDuration: float = 0.25

func HandleShowFrame(InCutScene: CutScene):
	
	var FadeDuration := FadeFromDuration
	var FadeColor := FadeFromColor
	
	var SampleFrameData := FrameArray[InCutScene.PendingFrame] if InCutScene.PendingFrame < FrameArray.size() else null
	if SampleFrameData:
		FadeDuration = SampleFrameData.FadeToDuration
		FadeColor = SampleFrameData.FadeToColor
	
	if FadeDuration > 0.0:
		
		InCutScene._Fade.color = FadeColor
		InCutScene._AnimationPlayer.play(&"NextFrame", -1.0, 1.0 / FadeDuration)
		
		if SampleFrameData and SampleFrameData.FadeToDuration <= 0.0:
			InCutScene._AnimationPlayer.advance(1.0)
	else:
		InCutScene.TryShowFrame_UpdateFrame()
	
	if SampleFrameData:
		if SampleFrameData.FadeToDuration > 0.0:
			InCutScene.NextFrameMinTimeTicksMs = maxi(InCutScene.NextFrameMinTimeTicksMs, int(SampleFrameData.FadeToDuration * 1000.0))
		if SampleFrameData.AutoSwitchDelay > 0.0:
			InCutScene.SetAutoSwitch(SampleFrameData.AutoSwitchDelay)

func HandleShowFrame_UpdateFrame(InCutScene: CutScene):
	
	if InCutScene.PendingFrame < FrameArray.size():
		
		InCutScene._CurrentFrame.visible = true
		
		var SampleFrameData := FrameArray[InCutScene.PendingFrame]
		InCutScene._CurrentFrame.UpdateFromFrameData(SampleFrameData)
		InCutScene.NextFrameMinTimeTicksMs += int(SampleFrameData.FrameHoldExtraDelay * 1000.0)
	else:
		InCutScene.FinishCutScene(true)
