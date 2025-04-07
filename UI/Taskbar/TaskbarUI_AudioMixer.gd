extends Control
class_name TaskbarUI_AudioMixer

@onready var _Panel: PanelContainer = $Panel
@onready var _Slider: VSlider = $Panel/Slider

func _ready() -> void:
	
	visibility_changed.connect(OnVisibilityChanged)
	_Panel.mouse_exited.connect(OnPanelMouseExited)
	
	_Slider.value_changed.connect(OnSliderValueChanged)
	_Slider.drag_started.connect(OnSliderDragStarted)
	_Slider.drag_ended.connect(OnSliderDragEnded)
	
	_Slider.ratio = 1.0

func OnVisibilityChanged():
	if visible:
		grab_focus.call_deferred()

func OnPanelMouseExited():
	visible = false

func OnSliderValueChanged(InValue: float):
	
	if InValue == 0.0:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_linear(0, InValue)

func OnSliderDragStarted():
	_Slider.mouse_default_cursor_shape = Control.CURSOR_DRAG

func OnSliderDragEnded(InValueChanged: bool):
	_Slider.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
