extends Node3D

@export var token_scene: PackedScene

@onready var camera = $Env/Camera3D
@onready var token_parent = $Tokens
var cast_from = null
var cast_to = null

# --- Temp Stuff ----

@onready var spawn_area: = $SpawnArea as BoxArea

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	for i in range(0, 40):
		var token = _create_token()
		token.position = spawn_area.get_random_point()
		
	pass # Replace with function body.

func _unhandled_input(event):
	
	# Cast ray to place token
	if event.is_action_pressed("game_action"):
		cast_from = camera.project_ray_origin(event.position)
		cast_to = cast_from + camera.project_ray_normal(event.position) * 50

func _physics_process(delta):
	
	if cast_from != null and cast_to != null:
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(cast_from, cast_to)
		var result = space_state.intersect_ray(query)
		
		if result:
			print("hit at ", result.position)
			
			var token = _create_token()
			token.position = result.position + Vector3(0, 2, 0)
			
		cast_from = null
		cast_to = null

func _create_token():
	var token = token_scene.instantiate()
	token_parent.add_child(token)
	return token

func _on_body_fell(body: Node3D):
	print(body)
	body.queue_free()
	pass
