extends KinematicBody2D

export var speed = 200.0
export var jump_strength = 1200.0
export var maximum_jumps = 2
export var double_jump_strength = 800.0
export var gravity = 2000.0

var _jumps_made = 0
var _velocity = Vector2.ZERO


#func _ready():
#	pass # Replace with function body.


func _physics_process(delta):
	var rightStrength = 0.0
	var leftStrength = 0.0
	if Input.is_action_pressed("ui_right"):
		rightStrength = 1.0
	elif Input.is_action_pressed("ui_left"):
		leftStrength = 1.0
	
	var _horizontal_direction = rightStrength - leftStrength
	
	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta
	
	var is_falling = _velocity.y > 0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	var is_double_jumping = Input.is_action_just_pressed("jump") and is_falling
	var is_jump_cancelled = Input.is_action_just_released("jump") and _velocity.y < 0.0
	#var is_idling = is_on_floor() and is_zero_approx(_velocity.x)
	#var is_running = is_on_floor() and not is_zero_approx(_velocity.x)
	
	if is_jumping:
		_jumps_made += 1
		_velocity.y -= jump_strength
	elif is_double_jumping:
		_jumps_made += 1
		if _jumps_made <= maximum_jumps:
			_velocity.y = -double_jump_strength
	elif is_jump_cancelled:
		_velocity.y = 0.0
	elif is_on_floor() and _jumps_made > 0:
		_jumps_made = 0
	
	_velocity = move_and_slide(_velocity, Vector2.UP)
