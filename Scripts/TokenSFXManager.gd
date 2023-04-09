extends Node

@export var bus = "Master"

@export var sounds: Array[AudioStream]
@export var num_players:= 10

var rng = RandomNumberGenerator.new()

var players: Array[AudioStreamPlayer3D]

func _ready():
	assert(sounds.size() > 0, "Number of sound effects cannot be 0")
	
	Events.token_collision.connect(_on_token_collision)
	
	for i in range(0, num_players):
		var player = AudioStreamPlayer3D.new()
		player.bus = bus
		add_child(player)
		
		players.append(player)

func _get_player():
	for player in players:
		if !player.playing:
			return player
	
	return null

func play_random():
	var player = _get_player()
	
	if player == null:
		return
		
	if !player.playing:
		player.stream = sounds[rng.randi_range(0, sounds.size() - 1)]
		player.play()

func _on_token_collision(position: Vector3, linear_velocity: Vector3, body: Node):
	
	
	if body is Token and linear_velocity.length() > 2.5:
		play_random()
		
	if body is Pusher and linear_velocity.length() > 2.5:
		play_random()
