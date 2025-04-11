extends WindowUI
class_name PasswordUI

@onready var _LineEdit: LineEdit = $VB/MC/VB/LineEdit
@onready var _Confirm: Button = $VB/MC/VB/Confirm

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	
	_Confirm.pressed.connect(OnConfirmPressed)
	_LineEdit.text_submitted.connect(OnPasswordSubmitted)
	_LineEdit.focus_entered.connect(OnFocusEntered)
	
	super()

func UpdateFromOwnerItem():
	
	super()
	
	assert(not OwnerItem._Data.GetUnlockPassword().is_empty())
	_LineEdit.grab_focus.call_deferred()
	
	OwnerItem.tree_exiting.connect(TryClose)

func OnConfirmPressed():
	TryConfirmPassword()

func OnPasswordSubmitted(InNewText: String):
	TryConfirmPassword()

func TryConfirmPassword():
	
	if _LineEdit.text.is_empty():
		return
	
	if _LineEdit.text == OwnerItem._Data.GetUnlockPassword():
		
		GameGlobals._Accept.play()
		
		_Confirm.disabled = true
		_AnimationPlayer.play(&"Accept", -1.0, 4.0)
		
		await get_tree().create_timer(0.25).timeout
		
		OwnerItem._Data.HandlePostUnlock(self)
	else:
		GameGlobals._Error.play()
		
		_LineEdit.text = ""
		_AnimationPlayer.play(&"Decline")
