@tool
extends PanelContainer
class_name TaskbarUI

@export var TabScene: PackedScene = preload("res://UI/Taskbar/TaskbarUI_Tab.tscn")

@onready var StartButton: Button = $MC/HB/Start
@onready var StartMenu: TaskbarUI_StartMenu = $MC/HB/Start/Menu

@onready var TabsHB: HBoxContainer = $MC/HB/TabsSC/HB

@onready var LanguageButton: Button = $MC/HB/ToolsPanel/VB/Language
@onready var AudioButton: TextureButton = $MC/HB/ToolsPanel/VB/Audio
@onready var TimeLabel: Label = $MC/HB/ToolsPanel/VB/Time
@onready var TimeButtonTimer: Timer = $MC/HB/ToolsPanel/VB/Time/Timer

func _ready() -> void:
	
	if not Engine.is_editor_hint():
		
		StartButton.toggled.connect(OnStartToggled)
		
		StartMenu.visibility_changed.connect(OnStartMenuVisibilityChanged)
		StartMenu.visible = false
		
		LanguageButton.toggled.connect(OnLanguageToggled)
		AudioButton.toggled.connect(OnAudioToggled)
		
		TimeButtonTimer.timeout.connect(OnTimeButtonTimerTimeout)
		OnTimeButtonTimerTimeout()

## Start
func OnStartToggled(InToggledOn: bool):
	StartMenu.visible = InToggledOn

func OnStartMenuVisibilityChanged():
	StartButton.button_pressed = StartMenu.visible

## Tabs
func AddTabFor(InWindow: WindowUI):
	var NewTab := InWindow.CreateTaskbarTab()
	TabsHB.add_child(NewTab)

## Tools
func OnLanguageToggled(InToggledOn: bool):
	
	if InToggledOn:
		LanguageButton.text = "Ру"
		TranslationServer.set_locale("ru")
	else:
		LanguageButton.text = "En"
		TranslationServer.set_locale("en")

func OnAudioToggled(InToggledOn: bool):
	
	if InToggledOn:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)

func OnTimeButtonTimerTimeout():
	var TimeData := Time.get_time_dict_from_system()
	TimeLabel.text = "%02d:%02d" % [ TimeData.hour, TimeData.minute ]
