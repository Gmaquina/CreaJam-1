extends Camera2D

var _player


func _ready():
	_player = $"/root/LVL/Player"

func _process(_delta):
	var px = _player.position.x
	var py = _player.position.y
	var wx = OS.window_size.x
	var wy = OS.window_size.y
	var x = (px - (wx / 2)) / 15
	var y = (py - (wy / 2)) / 15
	offset.x = x
	offset.y = y
