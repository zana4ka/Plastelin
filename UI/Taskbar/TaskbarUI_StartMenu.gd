extends PanelContainer
class_name TaskbarUI_StartMenu

@onready var HelpButton: Button = $VB/Help
@onready var HelpConfirm: TaskbarUI_Confirm = $VB/Help/Confirm

@onready var SettingsButton: Button = $VB/Settings
@onready var ShutDownButton: Button = $VB/ShutDown
@onready var ShutDownConfirm: TaskbarUI_Confirm = $VB/ShutDown/Confirm

func _ready() -> void:
	
	visibility_changed.connect(OnVisibilityChanged)
	mouse_exited.connect(OnMouseExited)
	
	HelpButton.pressed.connect(OnHelpButtonPressed)
	HelpConfirm.ConfirmPressed.connect(OnHelpConfirmPressed)
	
	SettingsButton.pressed.connect(OnSettingsButtonPressed)
	ShutDownButton.pressed.connect(OnShutDownButtonPressed)
	ShutDownConfirm.ConfirmPressed.connect(OnShutDownConfirmPressed)

func OnVisibilityChanged():
	if visible:
		grab_focus.call_deferred()
	else:
		HelpConfirm.Reset()
		ShutDownConfirm.Reset()

func OnMouseExited():
	
	if not HelpConfirm.visible and not ShutDownConfirm.visible:
		visible = false

func OnHelpButtonPressed():
	HelpConfirm.ToggleConfirm()
	ShutDownConfirm.HideConfirm()

func OnHelpConfirmPressed():
	GameGlobals._MainScene.HandleHelp()
	visible = false

func OnSettingsButtonPressed():
	GameGlobals._MainScene._DesktopCanvas.TryOpenEasterWindow()
	visible = false

func OnShutDownButtonPressed():
	ShutDownConfirm.ToggleConfirm()
	HelpConfirm.HideConfirm()

func OnShutDownConfirmPressed():
	GameGlobals._MainScene.HandleShutDown()
	visible = false
