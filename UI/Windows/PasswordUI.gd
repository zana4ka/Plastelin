extends WindowUI
class_name PasswordUI

@onready var _LineEdit: LineEdit = $VB/MC/VB/LineEdit
@onready var _Confirm: Button = $VB/MC/VB/Confirm

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	
	_Confirm.pressed.connect(OnConfirmPressed)
	
	super()

func UpdateFromOwnerItem():
	
	assert(not OwnerItem._Data.UnlockPassword.is_empty())
	_LineEdit.grab_focus.call_deferred()

func OnConfirmPressed():
	
	if _LineEdit.text.is_empty():
		return
	
	if _LineEdit.text == OwnerItem._Data.UnlockPassword:
		OwnerItem._Data.HandlePostUnlock(self)
	else:
		_LineEdit.text = ""
		_AnimationPlayer.play(&"Decline")
		GameGlobals._Error.play()
