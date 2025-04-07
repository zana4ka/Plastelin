extends Control
class_name Shake

var ShakeTarget: Control = self

var CenterPosition: Vector2 = Vector2.ZERO

var MaxOffset: Vector2 = Vector2(10.0, 10.0)
var MaxRotation: float = 0.01

var DecayAlpha: float = 0.0
var DecaySpeed: float = 1.0

func _ready():
	pass

func _process(InDelta: float):
	
	if DecayAlpha > 0.0:
		
		var TargetOffset := MaxOffset * DecayAlpha
		var TargetRotation := MaxRotation * DecayAlpha
		
		ShakeTarget.position = CenterPosition + Vector2(
			randf_range(-TargetOffset.x, TargetOffset.x),
			randf_range(-TargetOffset.y, TargetOffset.y),
		)
		ShakeTarget.rotation = randf_range(-TargetRotation, TargetRotation)
		
		DecayAlpha -= InDelta * DecaySpeed

func Start(InMaxOffset: Vector2, InMaxRotation: float, InDecaySpeed: float):
	
	assert(is_node_ready())
	
	CenterPosition = ShakeTarget.position
	
	MaxOffset = InMaxOffset
	MaxRotation = InMaxRotation
	
	DecaySpeed = InDecaySpeed
	DecayAlpha = 1.0
