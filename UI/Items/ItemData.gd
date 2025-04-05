extends Resource
class_name ItemData

@export var IconTexture: Texture2D = preload("res://UI/Items/Content/Folder.png")
@export var Name: String = "SECRET_FOLDER_1"

func TryOpen(InItemUI: ItemsUI_Item) -> WindowUI:
	return GameGlobals._MainScene.TryOpenItem(InItemUI)
