extends Node2D
class_name MainScene

@onready var _PlayerCamera: PlayerCamera = $PlayerCamera
@onready var _DesktopCanvas: DesktopCanvas = $DesktopCanvas

func _ready():
	Input.set_custom_mouse_cursor(null, Input.CURSOR_POINTING_HAND, Vector2(2.0, 2.0))

func _enter_tree() -> void:
	GameGlobals._MainScene = self

func _exit_tree() -> void:
	GameGlobals._MainScene = null

func TryOpenItem(InItem: ItemsUI_Item) -> WindowUI:
	return _DesktopCanvas.TryOpenWindowForItem(InItem)

func InitScene2():
	
	assert(not has_meta(&"Scene2"))
	set_meta(&"Scene2", true)
	
	
