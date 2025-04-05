extends PanelContainer
class_name WindowUI

@export var DragPreviewScene: PackedScene = preload("res://UI/Windows/WindowUI_DragPreview.tscn")

@onready var _Icon: TextureRect = $VB/Header/Icon
@onready var _Label: Label = $VB/Header/Label
@onready var _Minimize: TextureButton = $VB/Header/Minimize
@onready var _Expand: TextureButton = $VB/Header/Expand
@onready var _Close: TextureButton = $VB/Header/Close

func _ready() -> void:
	_Minimize.pressed.connect(Minimize)
	_Expand.pressed.connect(Expand)
	_Close.pressed.connect(Close)

func _enter_tree() -> void:
	GameGlobals._MainScene.WindowsArray.append(self)

func _exit_tree() -> void:
	GameGlobals._MainScene.WindowsArray.erase(self)

func _get_drag_data(AtPosition: Vector2) -> Variant:
	
	var DragPreview := DragPreviewScene.instantiate() as Control
	DragPreview.size = size
	DragPreview.Offset = -AtPosition
	set_drag_preview(DragPreview)
	
	set_meta(&"DragOffset", -AtPosition)
	GameGlobals.IsDraggingWindow = true
	
	return self

func Minimize():
	pass

func Expand():
	pass

func Close():
	pass
