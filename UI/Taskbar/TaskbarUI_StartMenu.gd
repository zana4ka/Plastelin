extends PanelContainer
class_name TaskbarUI_StartMenu

@onready var HelpButton: Button = $VB/Help
@onready var SettingsButton: Button = $VB/Settings
@onready var ShutDownButton: Button = $VB/ShutDown
@onready var ShutDownConfirmControl: Control = $VB/ShutDown/Control
@onready var ShutDownConfirm: Button = $VB/ShutDown/Control/Confirm

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	
	visibility_changed.connect(OnVisibilityChanged)
	mouse_exited.connect(OnMouseExited)
	
	ShutDownButton.pressed.connect(OnShutDownButtonPressed)
	ShutDownConfirm.pressed.connect(OnShutDownConfirmButtonPressed)

func OnVisibilityChanged():
	if visible:
		grab_focus.call_deferred()
	else:
		_AnimationPlayer.play(&"RESET")

func OnMouseExited():
	if not ShutDownConfirmControl.visible:
		visible = false

func OnShutDownButtonPressed():
	_AnimationPlayer.play(&"ShowShotDownConfirm")

func OnShutDownConfirmButtonPressed():
	GameGlobals._MainScene.HandleShutDown()
