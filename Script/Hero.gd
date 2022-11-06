extends KinematicBody2D

export var speed = 200.0
export var jump_min_strength = 400.0
export var jump_max_strength = 500.0
export var max_jump_time = 0.2
export var max_double_jump_time = 0.2
export var maximum_jumps = 2
export var double_jump_min_strength = 400.0
export var double_jump_max_strength = 500.0
export var gravity = 2000.0

var _jumps_made = 0
var _velocity = Vector2.ZERO
var _time_till_max_jump = 0.0
var _time_till_max_double_jump = 0.0


#func _ready():
#	pass


func _physics_process(delta):
	var rightStrength = 0.0
	var leftStrength = 0.0
	if Input.is_action_pressed("ui_right"):
		rightStrength = 1.0
	if Input.is_action_pressed("ui_left"):
		leftStrength = 1.0
	
	var _horizontal_direction = rightStrength - leftStrength
	
	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta
	
	var is_falling = _velocity.y > 0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	var is_boosting_jump = Input.is_action_pressed("jump") and _time_till_max_jump > 0
	var is_double_jumping = Input.is_action_just_pressed("jump") and is_falling
	var is_boosting_double_jump = Input.is_action_pressed("jump") and _time_till_max_double_jump > 0
	var is_jump_cancelled = Input.is_action_just_released("jump") and _velocity.y < 0.0
	#var is_idling = is_on_floor() and is_zero_approx(_velocity.x)
	#var is_running = is_on_floor() and not is_zero_approx(_velocity.x)

	if is_jumping:
		_jumps_made += 1
		_velocity.y -= jump_min_strength
		_time_till_max_jump = max_jump_time
	elif is_boosting_jump:
		_time_till_max_jump -= delta
		var amplitude =  jump_max_strength - jump_min_strength
		var t_since_jump = max_jump_time - _time_till_max_jump
		_velocity.y -= ((t_since_jump * amplitude) / max_jump_time)
	elif is_double_jumping:
		_jumps_made += 1
		if _jumps_made <= maximum_jumps:
			_velocity.y = - double_jump_min_strength
			_time_till_max_double_jump = max_double_jump_time
	elif is_boosting_double_jump:
		_time_till_max_double_jump -= delta
		var amplitude =  double_jump_max_strength - double_jump_min_strength
		var t_since_jump = max_double_jump_time - _time_till_max_double_jump
		_velocity.y -= ((t_since_jump * amplitude) / max_double_jump_time)
	elif is_jump_cancelled:
		_time_till_max_jump = 0
		_time_till_max_double_jump = 0
	elif is_on_floor() and _jumps_made > 0:
		_jumps_made = 0
	
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
	
