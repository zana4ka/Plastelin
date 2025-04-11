extends TextureButton
class_name CutScene_Frame

@onready var _Foreground: TextureRect = $Foreground
@onready var _TextLabelDictionary: Dictionary[int, Label] = {
	SIDE_LEFT: $TextLeft,
	SIDE_TOP: $TextTop,
	SIDE_RIGHT: $TextRight,
	SIDE_BOTTOM: $TextBottom,
}

var PlaceholderTexture := preload("res://Scenes/CutScenes/Content/Common/Foreground001.tres")

func UpdateFromFrameData(InData: CutSceneData_FrameData):
	
	texture_normal = InData.Background
	self_modulate = InData.BackgroundColor
	
	if texture_normal is AnimatedTexture:
		texture_normal.current_frame = 0
	
	if InData.Foreground == PlaceholderTexture:
		_Foreground.texture = null
		_Foreground.visible = false
	else:
		
		if InData.Foreground is AnimatedTexture:
			InData.Foreground.current_frame = 0
		
		_Foreground.texture = InData.Foreground
		_Foreground.self_modulate = InData.ForegroundColor
		_Foreground.visible = true
	
	for SampleLabel: Label in _TextLabelDictionary.values():
		SampleLabel.visible = false
	
	assert(InData.TextArray.size() == InData.TextDirectionArray.size())
	for SampleIndex: int in range(InData.TextArray.size()):
		
		var SampleText := InData.TextArray[SampleIndex]
		var SampleDirection := InData.TextDirectionArray[SampleIndex]
		
		var TargetLabel := _TextLabelDictionary[SampleDirection]
		TargetLabel.text = SampleText
		TargetLabel.add_theme_color_override(&"font_color", InData.TextColor)
		TargetLabel.visible = true
	InData.PostUpdateFromFrameData(self)
