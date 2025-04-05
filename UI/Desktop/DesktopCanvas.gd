extends CanvasLayer
class_name DesktopCanvas

@onready var _Computer: ItemsUI_Item = $ItemsUI/Computer
@onready var _SecretFolder1: ItemsUI_Item = $ItemsUI/SecretFolder1
@onready var _Recycle: ItemsUI_Item = $ItemsUI/Recycle

func _ready() -> void:
	_Computer._Button.pressed.connect(OnComputerPressed)
	_SecretFolder1._Button.pressed.connect(OnSecretFolder1Pressed)
	_Recycle._Button.pressed.connect(OnRecyclePressed)

func OnComputerPressed():
	pass

func OnSecretFolder1Pressed():
	pass

func OnRecyclePressed():
	pass
