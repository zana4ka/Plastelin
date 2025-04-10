@tool
extends Control
class_name TaskbarUI_Confirm

@export var ConfirmText: String = "ARE_YOU_SURE":
	set(InText):
		
		ConfirmText = InText
		
		$Label.text = ConfirmText

signal ConfirmPressed()

func _ready() -> void:
	$Label/Confirm.pressed.connect(OnConfirmPressed)

func ShowConfirm():
	if not visible:
		$AnimationPlayer.play(&"Show", -1.0, 20.0 / float(ConfirmText.length()))

func HideConfirm():
	if visible:
		$AnimationPlayer.play(&"Show", -1.0, -40.0 / float(ConfirmText.length()), true)

func ToggleConfirm():
	
	if visible:
		HideConfirm()
	else:
		ShowConfirm()

func Reset():
	$AnimationPlayer.play(&"RESET")

func OnConfirmPressed():
	ConfirmPressed.emit()
