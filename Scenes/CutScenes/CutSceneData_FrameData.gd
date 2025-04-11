extends Resource
class_name CutSceneData_FrameData

@export_category("Textures")
@export var Background: Texture2D = preload("res://Scenes/CutScenes/Content/Common/Background001.tres")
@export var BackgroundColor: Color = Color.WHITE
@export var Foreground: Texture2D = preload("res://Scenes/CutScenes/Content/Common/Foreground001.tres")
@export var ForegroundColor: Color = Color.WHITE

@export_category("Text")
@export var TextColor: Color = Color(0.8, 0.4, 0.0, 1.0)
@export_multiline var TextArray: Array[String] = [ "CUTSCENE_WATCHER_1" ]
@export_enum("Left", "Top", "Right", "Bottom") var TextDirectionArray: Array[int] = [ 3 ]

@export_category("FadeTo")
@export_color_no_alpha var FadeToColor: Color = Color(0.4, 0.0, 0.0)
@export var FadeToDuration: float = 0.0

@export_category("Delay")
@export var FrameHoldExtraDelay: float = 0.0
@export var AutoSwitchDelay: float = -1.0

func PostUpdateFromFrameData(InFrame: CutScene_Frame):
	pass
