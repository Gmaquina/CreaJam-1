extends Area2D

func _on_Token_body_entered(body):
	if body.name == "Player":
		$"/root/LVL"._collected_token(Vector2(-1, 1), global_position)
		queue_free()
