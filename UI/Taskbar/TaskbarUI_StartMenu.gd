extends PanelContainer
class_name TaskbarUI_StartMenu

@onready var HelpButton: Button = $VB/Help
@onready var SettingsButton: Button = $VB/Settings
@onready var ShutDownButton: Button = $VB/ShutDown

func _ready() -> void:
	visibility_changed.connect(OnVisibilityChanged)
	mouse_exited.connect(OnMouseExited)

func OnVisibilityChanged():
	if visible:
		grab_focus.call_deferred()

func OnMouseExited():
	visible = false
