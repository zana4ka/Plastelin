extends Node2D
class_name MainScene

@export var CursorPointer: Texture2D = preload("res://UI/Common/Mouse/Pointer001a.png")
@export var CursorPointingHand: Texture2D = preload("res://UI/Common/Mouse/PointingHand001a.png")
@export var CursorDrag: Texture2D = preload("res://UI/Common/Mouse/Drag001a.png")

@onready var _PlayerCamera: PlayerCamera = $PlayerCamera
@onready var _DesktopCanvas: DesktopCanvas = $DesktopCanvas

func _ready():
	
	Input.set_custom_mouse_cursor(CursorPointer, Input.CURSOR_ARROW, Vector2(2.0, 2.0))
	Input.set_custom_mouse_cursor(CursorPointingHand, Input.CURSOR_POINTING_HAND, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_CAN_DROP, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_DRAG, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_MOVE, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_FORBIDDEN, Vector2(19.0, 2.0))
	
	InitScene1()
	InitScene2()
	InitScene3()

func _enter_tree() -> void:
	GameGlobals._MainScene = self

func _exit_tree() -> void:
	GameGlobals._MainScene = null

func TryOpenItem(InItem: ItemsUI_Item) -> WindowUI:
	return _DesktopCanvas.TryOpenWindowForItem(InItem)

func InitScene1():
	
	assert(not has_meta(&"Scene1"))
	set_meta(&"Scene1", true)
	
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/MyComputer.tres"))
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/SecretFolder1.tres"))
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Recycle.tres"))
	
	var ModellingPhoto1 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Photos/ModellingPhoto1.tres"))
	ModellingPhoto1.GridPosition = Vector2i(5, 0)
	
	var ModellingPhoto2 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Photos/ModellingPhoto2.tres"))
	ModellingPhoto2.GridPosition = Vector2i(6, 0)
	
	var ModellingPhoto3 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Photos/ModellingPhoto3.tres"))
	ModellingPhoto3.GridPosition = Vector2i(6, 2)

func InitScene2():
	
	assert(not has_meta(&"Scene2"))
	set_meta(&"Scene2", true)
	
	var SecretFolder2 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/SecretFolder2.tres"))
	SecretFolder2.GridPosition = Vector2i(2, 1)

func InitScene3():
	
	assert(not has_meta(&"Scene3"))
	set_meta(&"Scene3", true)
	
	var SecretFolder3 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/SecretFolder3.tres"))
	SecretFolder3.GridPosition = Vector2i(2, 2)
