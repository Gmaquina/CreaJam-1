extends Node2D

const MyBallRessource = preload("res://Scene/Balle.tscn")
const MyTokenRessource = preload("res://Scene/Token.tscn")

const cheminSon1 = preload("res://Son/CoinSong1.wav")
const cheminSon2 = preload("res://Son/CoinSong2.wav")
const cheminSon3 = preload("res://Son/CoinSong3.wav")
const cheminSon4 = preload("res://Son/CoinSong4.wav")
const cheminSon5 = preload("res://Son/CoinSong5.wav")
const jumpSound = preload("res://Son/Jump_.wav")
const deathSound = preload("res://Son/Death(1).wav")

var score = 0
var scoreMultiplier = 0
var coin = 0

export(Array, Vector2) var SpawnPoints
export(Array, Vector2) var BalleSpawnPoints

func _physics_process(delta):
	score = score + int(delta*scoreMultiplier)
	$Hud._on_score_changed(score)

func _collected_token(direction, position):
	var tab = [cheminSon1,cheminSon2,cheminSon3,cheminSon4,cheminSon5]
	$Player/AudioStreamPlayer2D.stream = tab[coin]
	$Player/AudioStreamPlayer2D.volume_db = -10
	$Player/AudioStreamPlayer2D.play()
	coin = coin + 1
	if ( coin == 5 ) :
		coin = 0 
		
	_spawn_ball(direction, position)
	_spaw_token(position)

func _spaw_token(current_token_position):
	var token = MyTokenRessource.instance()
	var random_spawn = SpawnPoints[int(rand_range(0, SpawnPoints.size()))]
	while current_token_position.distance_to(random_spawn) < 200:
		random_spawn = SpawnPoints[int(rand_range(0, SpawnPoints.size()))]
	token.global_position = random_spawn
	$Timer.start(5)
	scoreMultiplier += 100
	$Hud._on_combo_changed(scoreMultiplier/100)
	score += 100 * scoreMultiplier/100
	print(token.global_position)
	get_node(".").add_child(token)

func _spawn_ball(launch_direction, spawn_position):
	var ball = MyBallRessource.instance() # Create a new Sprite.
	ball.direction = launch_direction
	var random_spawn = BalleSpawnPoints[int(rand_range(0, BalleSpawnPoints.size()))]
	while spawn_position.distance_to(random_spawn) < 400:
		random_spawn = BalleSpawnPoints[int(rand_range(0, BalleSpawnPoints.size()))]
	ball.global_position = random_spawn
	ball.scale = Vector2.ONE * rand_range(0.25, 1)
	ball.speed = 250 - (100 * ball.scale.x)
	get_node(".").add_child(ball)

func _jump_sound():
	$Player/AudioStreamPlayer2D.volume_db = 0
	$Player/AudioStreamPlayer2D.stream = jumpSound
	$Player/AudioStreamPlayer2D.play()

func _death_sound():
	$Player/AudioStreamPlayer2D.volume_db = -10
	$Player/AudioStreamPlayer2D.stream = deathSound
	$Player/AudioStreamPlayer2D.play()

func _stop_score():
	scoreMultiplier = 0


func _on_Timer_timeout():
	if scoreMultiplier > 1:
		print(scoreMultiplier)
		scoreMultiplier -= 200
		$Hud._on_combo_changed(scoreMultiplier/100)		
		$Timer.start(1)
	elif scoreMultiplier > 0:
		print(scoreMultiplier)
		scoreMultiplier -= 100
		$Hud._on_combo_changed(scoreMultiplier/100)		
		$Timer.start(1)
