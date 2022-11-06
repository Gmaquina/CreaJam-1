extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 250
var direction = Vector2(500,500)
var velocity = Vector2()
var player

signal gameover

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"/root/LVL/Player"
	var hud = $"/root/LVL/Hud"
	self.connect("gameover", hud, "_on_gameover", [], CONNECT_DEFERRED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity=Vector2()
	velocity.x += direction.x 
	velocity.y += direction.y 
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			direction = direction.bounce(collision.normal)
		for i in get_slide_count():
			collision = get_slide_collision(i).collider
			if collision == player:
				emit_signal("gameover")
