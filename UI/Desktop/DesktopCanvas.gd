extends CanvasLayer
class_name DesktopCanvas

@onready var _MyComputer: ItemsUI_Item = $ItemsUI/MyComputer
@onready var _SecretFolder1: ItemsUI_Item = $ItemsUI/SecretFolder1
@onready var _Recycle: ItemsUI_Item = $ItemsUI/Recycle

func _ready() -> void:
	_MyComputer._Button.pressed.connect(OnMyComputerPressed)
	_SecretFolder1._Button.pressed.connect(OnSecretFolder1Pressed)
	_Recycle._Button.pressed.connect(OnRecyclePressed)

func OnMyComputerPressed():
	pass

func OnSecretFolder1Pressed():
	pass

func OnRecyclePressed():
	pass
