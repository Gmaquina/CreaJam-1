extends Node2D

const MyBallRessource = preload("res://Scene/Balle.tscn")
const MyTokenRessource = preload("res://Scene/Token.tscn")

export(Array, Vector2) var SpawnPoints

func _collected_token(direction, position):
	_spawn_ball(direction, position)
	_spaw_token(position)

func _spaw_token(current_token_position):
	var token = MyTokenRessource.instance()
	var random_spawn = SpawnPoints[int(rand_range(0, SpawnPoints.size()))]
	while current_token_position.distance_to(random_spawn) < 2:
		random_spawn = SpawnPoints[int(rand_range(0, SpawnPoints.size()))]
	token.global_position = random_spawn
	get_node(".").add_child(token)

func _spawn_ball(launch_direction, spawn_position):
	var ball = MyBallRessource.instance() # Create a new Sprite.
	ball.direction = launch_direction
	ball.position = spawn_position + Vector2.UP*200
	get_node(".").add_child(ball)
