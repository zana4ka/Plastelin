@tool
extends PanelContainer
class_name TaskbarUI

@export var TabScene: PackedScene = preload("res://UI/Taskbar/TaskbarUI_Tab.tscn")
@export var TabSize: float = 240.0

@onready var StartButton: Button = $MC/HB/Start
@onready var StartMenu: TaskbarUI_StartMenu = $MC/HB/Start/Menu

@onready var TabsSC: ScrollContainer = $MC/HB/TabsSC
@onready var TabsHB: HBoxContainer = $MC/HB/TabsSC/HB

@onready var LanguageButton: Button = $MC/HB/ToolsPanel/VB/Language
@onready var AudioButton: TextureButton = $MC/HB/ToolsPanel/VB/Audio
@onready var AudioMixer: TaskbarUI_AudioMixer = $MC/HB/ToolsPanel/VB/Audio/Mixer
@onready var TimeLabel: Label = $MC/HB/ToolsPanel/VB/Time
@onready var TimeButtonTimer: Timer = $MC/HB/ToolsPanel/VB/Time/Timer

func _ready() -> void:
	
	if not Engine.is_editor_hint():
		
		StartButton.toggled.connect(OnStartToggled)
		
		StartMenu.visibility_changed.connect(OnStartMenuVisibilityChanged)
		StartMenu.visible = false
		
		LanguageButton.toggled.connect(OnLanguageToggled)
		AudioButton.toggled.connect(OnAudioButtonToggled)
		
		AudioMixer.visibility_changed.connect(OnAudioMixerVisibilityChanged)
		AudioMixer.visible = false
		AudioMixer._Slider.value_changed.connect(OnSliderValueChanged)
		
		TimeButtonTimer.timeout.connect(OnTimeButtonTimerTimeout)
		OnTimeButtonTimerTimeout()
		
		if TranslationServer.get_locale().left(2) == "ru":
			OnLanguageToggled(true)
		else:
			OnLanguageToggled(false)

## Start
func OnStartToggled(InToggledOn: bool):
	StartMenu.visible = InToggledOn

func OnStartMenuVisibilityChanged():
	StartButton.button_pressed = StartMenu.visible

## Tabs
func AddTabFor(InWindow: WindowUI):
	var NewTab := InWindow.CreateTaskbarTab()
	NewTab.tree_exited.connect(UpdateTabsSize, Object.CONNECT_DEFERRED)
	TabsHB.add_child(NewTab)
	UpdateTabsSize()

func UpdateTabsSize():
	
	var Tabs := TabsHB.get_children()
	if Tabs.size() <= 0:
		return
	
	var UpdatedTabSize := minf(TabsSC.size.x / Tabs.size(), TabSize)
	for SampleTab: TaskbarUI_Tab in Tabs:
		SampleTab._Button.custom_minimum_size.x = UpdatedTabSize

## Tools
func OnLanguageToggled(InToggledOn: bool):
	
	if InToggledOn:
		LanguageButton.text = "Ру"
		TranslationServer.set_locale("ru")
	else:
		LanguageButton.text = "En"
		TranslationServer.set_locale("en")

func OnAudioButtonToggled(InToggledOn: bool):
	AudioMixer.visible = InToggledOn

func OnAudioMixerVisibilityChanged():
	AudioButton.button_pressed = AudioMixer.visible

func OnSliderValueChanged(InValue: float):
	
	if InValue == 0.0:
		AudioButton.texture_normal = load("res://UI/Taskbar/Content/AudioOff001a.png")
	else:
		AudioButton.texture_normal = load("res://UI/Taskbar/Content/AudioOn001a.png")

func OnTimeButtonTimerTimeout():
	var TimeData := Time.get_time_dict_from_system()
	TimeLabel.text = "%02d:%02d" % [ TimeData.hour, TimeData.minute ]
