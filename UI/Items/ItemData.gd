extends Resource
class_name ItemData

@export_category("Common")
@export var IconTexture: Texture2D = preload("res://UI/Items/Content/Folders/Folder001a.png")
@export var Name: String = "SECRET_FOLDER_1"
@export var ForceOpenOnScreenCenter: bool = false

@export_category("Lock")
@export var IsInitiallyLocked: bool = false
@export var UnlockPassword: String = ""

func HandlePreOpenWindow(InItem: ItemsUI_Item):
	pass
