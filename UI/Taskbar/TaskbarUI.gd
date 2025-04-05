@tool
extends HBoxContainer
class_name TaskbarUI

@export var TabScene: PackedScene = preload("res://UI/Taskbar/TaskbarUI_Tab.tscn")

func _ready() -> void:
	
	#if Engine.is_editor_hint():
		AddTab(null)
		AddTab(null)

func AddTab(InWindow: DesktopWindow):
	var NewTab := TabScene.instantiate() as TaskbarUI_Tab
	add_child(NewTab)
