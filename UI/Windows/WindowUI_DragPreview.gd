extends Control
class_name WindowUI_DragPreview

@onready var _Panel: PanelContainer = $Panel

var Offset: Vector2:
	set(InOffset):
		
		Offset = InOffset
		
		if not is_node_ready():
			await ready
		
		_Panel.position = Offset

func _ready() -> void:
	pass

func _process(InDelta: float) -> void:
	
	var ClampedPosition := GameGlobals.GetOnScreenClampedPosition_TopLeftAnchors(_Panel) as Vector2
	Offset += (ClampedPosition - _Panel.get_screen_position())
