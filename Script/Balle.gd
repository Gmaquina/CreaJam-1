extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 250
var direction = Vector2(500,500)
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	 # Replace with function body.
	 pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity=Vector2()
	velocity.x += direction.x 
	velocity.y += direction.y 
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			direction = direction.bounce(collision.normal) 
