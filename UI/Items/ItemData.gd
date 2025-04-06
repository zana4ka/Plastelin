extends Resource
class_name ItemData

@export var IconTexture: Texture2D = preload("res://UI/Items/Content/Folder001a.png")
@export var Name: String = "SECRET_FOLDER_1"

@export var IsInitiallyLocked: bool = false

func GetNamePostfix() -> String:
	return ""
