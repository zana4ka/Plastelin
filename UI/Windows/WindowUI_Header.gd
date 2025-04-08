@tool
extends VBoxContainer
class_name WindowUI_Header

@export var OwnerWindowUI: WindowUI:
	set(InWindowUI):
		
		OwnerWindowUI = InWindowUI
		
		if is_node_ready():
			UpdateFromOwner()

@export var ShowToolBar: bool = true:
	set(InShow):
		
		ShowToolBar = InShow
		
		if not is_node_ready():
			await ready
		_ToolBarVB.visible = ShowToolBar

@onready var _Icon: TextureRect = $TitleBarPanel/MC/VB/Icon
@onready var _Label: Label = $TitleBarPanel/MC/VB/Label
@onready var _Collapse: TextureButton = $TitleBarPanel/MC/VB/ButtonsVB/Collapse
@onready var _Expand: TextureButton = $TitleBarPanel/MC/VB/ButtonsVB/Expand
@onready var _Close: TextureButton = $TitleBarPanel/MC/VB/ButtonsVB/Close

@onready var _ToolBarVB: HBoxContainer = $ToolBarVB

func _ready() -> void:
	
	assert(OwnerWindowUI)
	
	if not Engine.is_editor_hint():
		
		_Collapse.pressed.connect(Collapse)
		_Expand.pressed.connect(Expand)
		_Close.pressed.connect(Close)
		
		#_Expand.disabled = true
		
		UpdateFromOwner()

func UpdateFromOwner():
	
	var _OwnerItemData := OwnerWindowUI.OwnerItem._Data
	if _OwnerItemData:
		_Icon.texture = _OwnerItemData.IconTexture
		_Label.text = _OwnerItemData.Name

func Collapse():
	GameGlobals._WindowCollapse.play()
	OwnerWindowUI.TryCollapse()

func Expand():
	GameGlobals._WindowCollapse.play()
	OwnerWindowUI.TryExpand()

func Close():
	GameGlobals._WindowClose.play()
	OwnerWindowUI.TryClose()
