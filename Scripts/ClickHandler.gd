extends Node3D

@onready var camera = $"../Env/Camera3D"

var cast_from = null
var cast_to = null

signal click_hit(hit_position)

func _physics_process(delta):
	
	if cast_from != null and cast_to != null:
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(cast_from, cast_to)
		var result = space_state.intersect_ray(query)
		
		if result:
			click_hit.emit(result.position)
			
		cast_from = null
		cast_to = null

func _unhandled_input(event):
	
	# Cast ray to place token
	if event.is_action_pressed("game_action"):
		cast_from = camera.project_ray_origin(event.position)
		cast_to = cast_from + camera.project_ray_normal(event.position) * 50
