@tool
extends ItemsUI_GridCell
class_name ItemsUI_Item

@export var _Data: ItemData:
	set(InData):
		_Data = InData
		UpdateFromItemData()

@onready var ParentContainer: ItemsUIBase = get_parent() as ItemsUIBase

@onready var _Button: TextureButton = $Button
@onready var _Lock: TextureRect = $Button/Lock
@onready var _Label: Label = $Control/Label

var WasOpened: bool = false
var IsLocked: bool = false:
	set(InIsLocked):
		IsLocked = InIsLocked
		_Button.modulate = Color.DIM_GRAY if IsLocked else Color.WHITE
		_Lock.visible = InIsLocked

func _ready():
	
	if not Engine.is_editor_hint():
		
		_Button.pressed.connect(OnButtonPressed)
		_Button.focus_entered.connect(OnButtonFocusEntered)
		_Button.focus_exited.connect(OnButtonFocusExited)
		
		UpdateFromItemData()
		
		if ParentContainer:
			ParentContainer.RegisterItem(self)
		
		IsLocked = IsLocked
		tree_exiting.connect(GameGlobals._MainScene._DesktopCanvas.OnItemTreeExiting.bind(self))

func _get_drag_data(AtPosition: Vector2) -> Variant:
	var DragPreview := TextureRect.new()
	DragPreview.texture = _Data.IconTexture
	DragPreview.stretch_mode = TextureRect.StretchMode.STRETCH_SCALE
	DragPreview.expand_mode = TextureRect.ExpandMode.EXPAND_IGNORE_SIZE
	DragPreview.custom_minimum_size = _Button.custom_minimum_size
	GameGlobals._PhotoPickUp.play()
	set_drag_preview(DragPreview)
	return self

func _can_drop_data(AtPosition: Vector2, InData: Variant) -> bool:
	return super(AtPosition, InData) and (InData != self)

func UpdateFromItemData():
	
	if not is_node_ready() or not _Data:
		return
	
	_Button.texture_normal = _Data.IconTexture
	
	_Label.label_settings = _Data._LS
	_Label.text = _Data.Name
	
	if _Data.IsInitiallyLocked:
		IsLocked = true

var SkipReplace: bool = false

func HandleGridPositionChanged(InPrevPosition: Vector2i):
	
	if GridPosition != InPrevPosition:
		
		if is_node_ready() and not SkipReplace:
			ParentContainer.ReplaceItemsOnPositions(GridPosition, InPrevPosition)

func SwapGridPositionWith(InItem: ItemsUI_GridCell):
	
	var PrevPosition := GridPosition
	GridPosition = InItem.GridPosition
	
	InItem.GridPosition = PrevPosition

var LastPressedTimeTicksMs: int = 0

func OnButtonPressed():
	
	var PrevPressedTimeTicksMs := LastPressedTimeTicksMs
	LastPressedTimeTicksMs = Time.get_ticks_msec()
	
	if PrevPressedTimeTicksMs + 500 < LastPressedTimeTicksMs:
		return
	
	if await GameGlobals._MainScene.TryOpenItem(self, _Data.ForceOpenOnScreenCenter):
		WasOpened = true

func OnButtonFocusEntered():
	
	modulate = Color.SKY_BLUE
	
	_Label.label_settings = _Data._FocusedLS

func OnButtonFocusExited():
	
	modulate = Color.WHITE
	
	_Label.label_settings = _Data._LS
