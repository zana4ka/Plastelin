extends PanelContainer
class_name TaskbarUI_StartMenu

@onready var HelpButton: Button = $VB/Help
@onready var SettingsButton: Button = $VB/Settings
@onready var ShutDownButton: Button = $VB/ShutDown
@onready var ShutDownConfirm: TaskbarUI_Confirm = $VB/ShutDown/Confirm

func _ready() -> void:
	
	visibility_changed.connect(OnVisibilityChanged)
	mouse_exited.connect(OnMouseExited)
	
	HelpButton.pressed.connect(OnHelpButtonPressed)
	SettingsButton.pressed.connect(OnSettingsButtonPressed)
	ShutDownButton.pressed.connect(OnShutDownButtonPressed)
	ShutDownConfirm.ConfirmPressed.connect(OnShutDownConfirmPressed)

func OnVisibilityChanged():
	if visible:
		grab_focus.call_deferred()
	else:
		ShutDownConfirm.Reset()

func OnMouseExited():
	
	if not ShutDownConfirm.visible:
		visible = false

func OnHelpButtonPressed():
	pass

func OnSettingsButtonPressed():
	GameGlobals._MainScene._DesktopCanvas.TryOpenEasterWindow()

func OnShutDownButtonPressed():
	ShutDownConfirm.ShowConfirm()

func OnShutDownConfirmPressed():
	GameGlobals._MainScene.HandleShutDown()
