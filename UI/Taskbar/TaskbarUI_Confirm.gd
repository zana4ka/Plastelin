extends Control
class_name TaskbarUI_Confirm

@export var ConfirmText: String = "ARE_YOU_SURE"

signal ConfirmPressed()

func _ready() -> void:
	$Confirm.pressed.connect(OnConfirmPressed)

func ShowConfirm():
	$AnimationPlayer.play(&"Show")

func Reset():
	$AnimationPlayer.play(&"RESET")

func OnConfirmPressed():
	ConfirmPressed.emit()
