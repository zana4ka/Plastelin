extends Resource
class_name ItemData

@export_category("Common")
@export var IconTexture: Texture2D = preload("res://UI/Items/Content/Folders/Folder001a.png")
@export var Name: String = "SECRET_FOLDER_1"
@export var ForceOpenOnScreenCenter: bool = false
@export var ForceExpand: bool = false
@export var CanBeMoved: bool = true

@export_category("Label")
@export var _LS: LabelSettings = preload("res://UI/Common/DefaultLS.tres")
@export var _FocusedLS: LabelSettings = preload("res://UI/Common/DefaultLS_Focused.tres")

@export_category("Lock")
@export var IsInitiallyLocked: bool = false
@export var OpenItemAfterUnlock: bool = true
@export var UnlockPassword: String = ""

const WasOpenedMeta: StringName = &"WasOpened"

func GetUnlockPassword() -> String:
	return UnlockPassword

func HandlePostUnlock(InPasswordUI: PasswordUI):
	
	if OpenItemAfterUnlock:
		InPasswordUI.tree_exited.connect(GameGlobals._MainScene.TryOpenItem.bind(InPasswordUI.OwnerItem, true), Object.CONNECT_DEFERRED)
	
	if InPasswordUI.TryClose():
		InPasswordUI.OwnerItem.IsLocked = false

func HandlePreOpenWindow(InItem: ItemsUI_Item) -> bool:
	return true

func HandlePostOpenWindow(InItem: ItemsUI_Item):
	pass

func WasOpened() -> bool:
	return get_meta(WasOpenedMeta, false)

func SetWasOpened(InWasOpened: bool):
	set_meta(WasOpenedMeta, InWasOpened)
