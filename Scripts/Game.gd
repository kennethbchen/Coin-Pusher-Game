extends Node3D

@export var token_scene: PackedScene

# Workaround until you can add Nodes to an array directly through the editor
@export var drop_points_parent: Node
var drop_points: Array[Node] = []

@onready var token_parent = $Tokens

# --- Temp Stuff ----
@onready var spawn_area: = $SpawnArea as BoxArea

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in drop_points_parent.get_children():
		drop_points.append(child)
	
	for i in range(0, 100):
		var token = _create_token()
		token.position = spawn_area.get_random_point()

func _unhandled_input(event):
	
	# Is there a better way to do this?
	if event.is_action_pressed("game_drop_1"):
		drop_token(0, true)
		
	if event.is_action_pressed("game_drop_2"):
		drop_token(1, true)
		
	if event.is_action_pressed("game_drop_3"):
		drop_token(2, true)
		
	if event.is_action_pressed("game_drop_4"):
		drop_token(3, true)
		
	if event.is_action_pressed("game_drop_5"):
		drop_token(4, true)
		
	if event.is_action_pressed("game_drop_6"):
		drop_token(5, true)

func drop_token(index: int, jitter:= false) -> void: 
	
	var ind = clamp(index, 0, drop_points.size() - 1)
	
	var token = _create_token() as Token
	token.position = drop_points[ind].global_position
	token.rotation.x = 90
	
	if jitter:
		token.jitter()

func _create_token() -> Token:
	var token = token_scene.instantiate()
	token_parent.add_child(token)
	return token

func _on_body_fell(body: Node3D):
	if body is Token:
		body.destroy()
