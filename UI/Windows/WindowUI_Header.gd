extends VBoxContainer
class_name WindowUI_Header

@export var OwnerWindowUI: WindowUI:
	set(InWindowUI):
		
		OwnerWindowUI = InWindowUI
		
		if is_node_ready():
			UpdateFromOwner()

@onready var _Icon: TextureRect = $TitleBarPanel/MC/VB/Icon
@onready var _Label: Label = $TitleBarPanel/MC/VB/Label
@onready var _Minimize: TextureButton = $TitleBarPanel/MC/VB/Minimize
@onready var _Expand: TextureButton = $TitleBarPanel/MC/VB/Expand
@onready var _Close: TextureButton = $TitleBarPanel/MC/VB/Close

func _ready() -> void:
	
	assert(OwnerWindowUI)
	
	_Minimize.pressed.connect(Minimize)
	_Expand.pressed.connect(Expand)
	_Close.pressed.connect(Close)
	
	UpdateFromOwner()

func UpdateFromOwner():
	
	var _OwnerItemData := OwnerWindowUI.OwnerItem._Data
	if _OwnerItemData:
		_Icon.texture = _OwnerItemData.IconTexture
		_Label.text = _OwnerItemData.Name

func Minimize():
	OwnerWindowUI.TryMinimize()

func Expand():
	OwnerWindowUI.TryExpand()

func Close():
	OwnerWindowUI.TryClose()
