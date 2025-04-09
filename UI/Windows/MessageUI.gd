extends WindowUI
class_name MessageUI

@onready var _Label: Label = $VB/MC/VB/Label
@onready var _Confirm: Button = $VB/MC/VB/Confirm

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	
	_Confirm.pressed.connect(OnConfirmPressed)
	
	super()
	
	PlayPopUp()

func UpdateFromOwnerItem():
	
	super()
	
	var OwnerMessageData := OwnerItem._Data as MessageData
	_Label.text = OwnerMessageData.MessageText

func PlayPopUp():
	
	var OwnerMessageData := OwnerItem._Data as MessageData
	_AnimationPlayer.play(OwnerMessageData.PopUpAnimation)
	
	GameGlobals._Error.play()

func OnConfirmPressed():
	TryClose()
