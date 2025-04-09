extends Node2D
class_name MainScene

@export var CursorPointer: Texture2D = preload("res://UI/Common/Mouse/Pointer001a.png")
@export var CursorPointingHand: Texture2D = preload("res://UI/Common/Mouse/PointingHand001a.png")
@export var CursorDrag: Texture2D = preload("res://UI/Common/Mouse/Drag001a.png")

@onready var _PlayerCamera: PlayerCamera = $PlayerCamera
@onready var _DesktopCanvas: DesktopCanvas = $DesktopCanvas
@onready var _CutSceneCanvas: CanvasLayer = $CutSceneCanvas

@onready var _CreditsText: RichTextLabel = $CreditsCanvas/CreditsColor/Text

@onready var _AnimationPlayer: AnimationPlayer = $AnimationPlayer

@onready var EasterRandomPassword: int = randi_range(1000, 9999)

func _ready():
	
	#Input.set_custom_mouse_cursor(CursorPointer, Input.CURSOR_ARROW, Vector2(2.0, 2.0))
	Input.set_custom_mouse_cursor(CursorPointingHand, Input.CURSOR_POINTING_HAND, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_CAN_DROP, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_DRAG, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_MOVE, Vector2(19.0, 2.0))
	Input.set_custom_mouse_cursor(CursorDrag, Input.CURSOR_FORBIDDEN, Vector2(19.0, 2.0))
	
	BeginPrologue()
	#BeginScene1()
	#BeginScene2()
	#BeginScene3()
	#BeginScene4()
	#BeginScene5()
	#BeginScene6()
	#BeginScene7()
	#BeginScene8()
	#PlayCredits()

func _enter_tree() -> void:
	GameGlobals._MainScene = self

func _exit_tree() -> void:
	GameGlobals._MainScene = null

func TryOpenItem(InItem: ItemsUI_Item, OnScreenCenter: bool = false) -> WindowUI:
	return await _DesktopCanvas.TryOpenWindowForItem(InItem, OnScreenCenter)

func HandleShutDown():
	GameGlobals._ShutDown.play()
	GameGlobals._GlobalLoop1.stop()
	GameGlobals._GlobalLoop2.stop()
	_AnimationPlayer.play(&"ShutDown")

func HandleShutDown_Finish():
	PlayCredits()

func BeginPrologue():
	
	assert(not has_meta(&"Prologue"))
	set_meta(&"Prologue", true)
	
	var PrologueCutScene := CutScene.BeginCutScene(load("res://Scenes/CutScenes/Content/Prologue/CutSceneData.tres"))
	
	GameGlobals._GlobalLoop2.play()
	
	#PrologueCutScene.FinishCutScene()
	await PrologueCutScene.Finished
	
	BeginScene1()

func BeginScene1():
	
	assert(not has_meta(&"Scene1"))
	set_meta(&"Scene1", true)
	
	_DesktopCanvas.SetBackground(load("res://UI/Desktop/Content/Background001a.jpg"))
	
	SpawnEasterFolder()
	SpawnTabsMessageFile()
	
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/MyComputer.tres")).GridPosition = Vector2i(0, 0)
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/SecretFolder1.tres")).GridPosition = Vector2i(0, 1)
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/Recycle.tres")).GridPosition = Vector2i(0, 2)
	
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/SecretFolder2.tres")).GridPosition = Vector2i(2, 1)
	
	_DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Documents/NewDocument1.tres")).GridPosition = Vector2i(1, 0)
	
	#var ModellingPhoto1 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Photos/Modelling/ModellingPhoto1.tres"))
	#ModellingPhoto1.GridPosition = Vector2i(5, 0)
	
	#var ModellingPhoto2 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Photos/Modelling/ModellingPhoto2.tres"))
	#ModellingPhoto2.GridPosition = Vector2i(6, 0)
	
	#var ModellingPhoto3 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Photos/Modelling/ModellingPhoto3.tres"))
	#ModellingPhoto3.GridPosition = Vector2i(6, 2)
	
	GameGlobals._StartUp.play()
	GameGlobals._GlobalLoop2.stop()
	GameGlobals._GlobalLoop1.play()
	
	## Debug
	#var SecretDocument7 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Documents/SecretDocument7.tres"))
	#SecretDocument7.GridPosition = Vector2i(1, 0)

func BeginScene2():
	
	assert(not has_meta(&"Scene2"))
	set_meta(&"Scene2", true)
	
	_DesktopCanvas.SetBackground(load("res://UI/Desktop/Content/Background002a.jpg"))
	GameGlobals.UpdatePanelsModulate(Color.TEAL)

func BeginScene3():
	
	assert(not has_meta(&"Scene3"))
	set_meta(&"Scene3", true)
	
	## LampMiniGame

func BeginScene4():
	
	assert(not has_meta(&"Scene4"))
	set_meta(&"Scene4", true)
	
	## LampMiniGame

func BeginScene5():
	
	assert(not has_meta(&"Scene5"))
	set_meta(&"Scene5", true)
	
	## CutScene

func BeginScene6():
	
	assert(not has_meta(&"Scene6"))
	set_meta(&"Scene6", true)
	
	var PreFinalCutScene := CutScene.BeginCutScene(load("res://Scenes/CutScenes/Content/PreFinal/CutSceneData.tres"))
	
	#PreFinalCutScene.FinishCutScene()
	await PreFinalCutScene.Finished
	
	_DesktopCanvas.SetBackground(load("res://UI/Desktop/Content/Background003_Flash.tres"))
	GameGlobals.UpdatePanelsModulate(Color.CRIMSON)
	
	await _DesktopCanvas.CloseAllWindows()
	_DesktopCanvas._ItemsUI.RemoveAllItems()
	
	SpawnEasterFolder()
	SpawnTabsMessageFile()
	
	var SecretFolder3 := _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/SecretFolder3.tres"))
	SecretFolder3.GridPosition = Vector2i(0, 0)
	
	SecretFolder3.ready.connect(_DesktopCanvas._ItemsUI.MoveToScreenCenter, Object.CONNECT_DEFERRED)
	_DesktopCanvas._TaskbarUI.visible = false
	
	GameGlobals._GlobalLoop1.stop()
	GameGlobals._GlobalLoop2.play()

func BeginScene7():
	
	assert(not has_meta(&"Scene7"))
	set_meta(&"Scene7", true)
	
	## SecretFolder3

var FinalPhotoCounter: int = 0:
	set(InCounter):
		
		FinalPhotoCounter = InCounter
		
		if FinalPhotoCounter >= 5:
			BeginScene8()

func BeginScene8():
	
	assert(not has_meta(&"Scene8"))
	set_meta(&"Scene8", true)
	
	var FinalCutScene := CutScene.BeginCutScene(load("res://Scenes/CutScenes/Content/Final/CutSceneData.tres"))
	
	#FinalCutScene.FinishCutScene()
	await FinalCutScene.Finished
	PlayCredits()

func PlayCredits():
	
	GameGlobals._GlobalLoop1.stop()
	GameGlobals._GlobalLoop2.stop()
	
	_AnimationPlayer.play(&"Credits")
	
	_CreditsText.text = ""
	
	_CreditsText.push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
	_CreditsText.add_image(load("res://Scenes/Credits/IWantPizza.png"), 112, 112)
	_CreditsText.add_text(TranslationServer.translate("CREDITS_1") + "\n\n")
	_CreditsText.pop()
	
	_CreditsText.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	_CreditsText.add_image(load("res://Scenes/Credits/zanayn.png"), 112, 112)
	_CreditsText.add_text(TranslationServer.translate("CREDITS_2") + "\n\n")
	_CreditsText.pop()
	
	_CreditsText.push_paragraph(HORIZONTAL_ALIGNMENT_RIGHT)
	_CreditsText.add_image(load("res://Scenes/Credits/Pompila.png"), 112, 112)
	_CreditsText.add_text(TranslationServer.translate("CREDITS_3") + "\n\n")
	_CreditsText.pop()
	
	_CreditsText.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	_CreditsText.add_image(load("res://Scenes/Credits/Prussichger.png"), 112, 112)
	_CreditsText.add_text(TranslationServer.translate("CREDITS_4") + "\n\n")
	_CreditsText.pop()
	
	_CreditsText.push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
	_CreditsText.add_image(load("res://Scenes/Credits/ElLozerroXD.png"), 112, 112)
	_CreditsText.add_text(TranslationServer.translate("CREDITS_5"))
	_CreditsText.pop()

func SpawnEasterFolder():
	_DesktopCanvas.EasterFolder = _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Folders/Easter/EasterFolder_Main.tres"))
	_DesktopCanvas.EasterFolder.GridPosition = Vector2i(0, 6)

func SpawnTabsMessageFile():
	_DesktopCanvas.TabsMessageFile = _DesktopCanvas._ItemsUI.AddNewItem(load("res://UI/Items/Content/Messages/TabsMessage.tres"))
	_DesktopCanvas.TabsMessageFile.GridPosition = Vector2i(1, 6)
