extends WindowUI
class_name PasswordUI

@onready var _LineEdit: LineEdit = $VB/MC/VB/LineEdit
@onready var _Confirm: Button = $VB/MC/VB/Confirm

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	
	_Confirm.pressed.connect(OnConfirmPressed)
	_LineEdit.text_submitted.connect(OnPasswordSubmitted)
	
	super()

func UpdateFromOwnerItem():
	
	assert(not OwnerItem._Data.GetUnlockPassword().is_empty())
	_LineEdit.grab_focus.call_deferred()

func OnConfirmPressed():
	TryConfirmPassword()

func OnPasswordSubmitted(InNewText: String):
	TryConfirmPassword()

func TryConfirmPassword():
	
	if _LineEdit.text.is_empty():
		return
	
	if _LineEdit.text == OwnerItem._Data.GetUnlockPassword():
		OwnerItem._Data.HandlePostUnlock(self)
	else:
		_LineEdit.text = ""
		_AnimationPlayer.play(&"Decline")
		GameGlobals._Error.play()
