extends Camera2D

var offsetValue = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	
	#variables
	var right : = Input.is_action_pressed("stick_right")
	var left : = Input.is_action_pressed("stick_left")
	var up : = Input.is_action_pressed("stick_up")
	var down : = Input.is_action_pressed("stick_down")
	
	#returns the default offset of THE camera
	offset_h = 0
	offset_v = 0
	
	#yandereDev
	if right:
		$".".offset_h = offsetValue
	elif left:
		$".".offset_h = -offsetValue
	elif down:
		$".".offset_v = offsetValue
	elif up:
		$".".offset_v = -offsetValue
