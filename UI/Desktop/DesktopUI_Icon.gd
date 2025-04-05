@tool
extends DesktopUI_IconBase
class_name DesktopUI_Icon

@export var IconTexture: Texture2D = preload("res://addons/windows_95_theme/icon.png"):
	set(InTexture):
		IconTexture = InTexture
		UpdateVisuals()

@export var IconText: String = "COMPUTER":
	set(InText):
		IconText = InText
		UpdateVisuals()

@onready var ParentGrid: DesktopUI_Icons = get_parent() as DesktopUI_Icons

@onready var _Button: TextureButton = $Button
@onready var _Label: Label = $Label

func _ready():
	UpdateVisuals()
	if ParentGrid:
		ParentGrid.AddIcon(self)

func _get_drag_data(AtPosition: Vector2) -> Variant:
	var DragPreview := TextureRect.new()
	DragPreview.texture = IconTexture
	DragPreview.stretch_mode = TextureRect.StretchMode.STRETCH_SCALE
	DragPreview.expand_mode = TextureRect.ExpandMode.EXPAND_IGNORE_SIZE
	DragPreview.custom_minimum_size = _Button.custom_minimum_size
	set_drag_preview(DragPreview)
	return self

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	return InData != self

func UpdateVisuals():
	
	if not is_node_ready():
		return
	
	_Button.texture_normal = IconTexture
	_Label.text = IconText

var SkipReplace: bool = false

func HandleGridPositionChanged(InPrevPosition: Vector2i):
	
	if GridPosition != InPrevPosition:
		
		if is_node_ready() and not SkipReplace:
			ParentGrid.ReplaceIconsOnPositions(GridPosition, InPrevPosition)

func SwapGridPositionWith(InIcon: DesktopUI_IconBase):
	
	SkipReplace = true
	var PrevPosition := GridPosition
	GridPosition = InIcon.GridPosition
	
	InIcon.GridPosition = PrevPosition
	SkipReplace = false
