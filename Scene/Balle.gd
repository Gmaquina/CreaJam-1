extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vitesse = 5
var direction = Vector2(100,-100)
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	 # Replace with function body.
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity=Vector2()
	
	velocity = velocity.normalized() * vitesse
	velocity = move_and_slide(velocity)