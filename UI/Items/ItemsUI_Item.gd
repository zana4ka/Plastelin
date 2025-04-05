@tool
extends ItemsUI_GridCell
class_name ItemsUI_Item

@export var _Data: ItemData:
	set(InData):
		_Data = InData
		UpdateFromItemData()

@onready var ParentGrid: ItemsUI = get_parent() as ItemsUI

@onready var _Button: TextureButton = $Button
@onready var _Label: Label = $Label

func _ready():
	
	_Button.pressed.connect(OnPressed)
	
	UpdateFromItemData()
	
	if ParentGrid:
		ParentGrid.RegisterItem(self)

func _get_drag_data(AtPosition: Vector2) -> Variant:
	var DragPreview := TextureRect.new()
	DragPreview.texture = _Data.IconTexture
	DragPreview.stretch_mode = TextureRect.StretchMode.STRETCH_SCALE
	DragPreview.expand_mode = TextureRect.ExpandMode.EXPAND_IGNORE_SIZE
	DragPreview.custom_minimum_size = _Button.custom_minimum_size
	set_drag_preview(DragPreview)
	return self

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	return InData != self

func UpdateFromItemData():
	
	if not is_node_ready() or not _Data:
		return
	
	_Button.texture_normal = _Data.IconTexture
	_Label.text = _Data.Name

var SkipReplace: bool = false

func HandleGridPositionChanged(InPrevPosition: Vector2i):
	
	if GridPosition != InPrevPosition:
		
		if is_node_ready() and not SkipReplace:
			ParentGrid.ReplaceIconsOnPositions(GridPosition, InPrevPosition)

func SwapGridPositionWith(InIcon: ItemsUI_GridCell):
	
	var PrevPosition := GridPosition
	GridPosition = InIcon.GridPosition
	
	InIcon.GridPosition = PrevPosition

func OnPressed():
	_Data.TryOpen(self)
