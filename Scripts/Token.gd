@tool

class_name Token

extends RigidBody3D

@onready var mesh: = $MeshInstance3D

# Box Collider shapes are used because 
# as of Godot 4.0.stable, cylinder collider shapes are bad.
# Instead, we approximate the cylinder with box collision shapes
# However, adding multiple collision shapes appears to do a strange thing:
# The pusher doesn't apply friction to the token sometimes
@export_range(1, 8) var num_box_colliders = 4
@export_range(0.001, 10, 0.001, "or_greater") var height: float = 0.15
@export_range(0.001, 10, 0.001, "or_greater") var radius: float = 0.5

var cylinder_mesh: CylinderMesh

func _ready():
	assert(mesh.mesh is CylinderMesh)
	
	cylinder_mesh = mesh.mesh as CylinderMesh
	
	# Change dimensions of token

	cylinder_mesh.top_radius = radius
	cylinder_mesh.bottom_radius = radius
	cylinder_mesh.height = height
	
	linear_velocity.y = -5
	if not Engine.is_editor_hint():
		mesh.scale = Vector3.ZERO
		var tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(mesh, "scale", Vector3(1,1,1), 0.25)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if Engine.is_editor_hint():
		_generate_colliders()
		cylinder_mesh.top_radius = radius
		cylinder_mesh.bottom_radius = radius
		cylinder_mesh.height = height

func _generate_colliders():
	
	if _get_num_colliders() != num_box_colliders:
		
		# Delete and re-create all children
		for child in _get_collider_children():
			if child != null and child is CollisionShape3D:
				child.queue_free()
	
		for i in range (0, num_box_colliders):
			var child = CollisionShape3D.new()
			child.shape = BoxShape3D.new()
			
			add_child(child)
			child.set_owner(get_tree().edited_scene_root)
			
	
	var colliders = _get_collider_children()
	
	for i in range(0, colliders.size()):
		var collider = colliders[i]
		collider.shape.size = Vector3(radius * sqrt(2), height, radius * sqrt(2))
		collider.rotation.y = ((360 / num_box_colliders) * i)

func _get_collider_children() -> Array[CollisionShape3D]:
	var output: Array[CollisionShape3D] = []
	
	for child in get_children():
		if child is CollisionShape3D:
			output.append(child)
	
	return output

func _get_num_colliders():
	var count = 0
	
	for child in get_children():
		if child is CollisionShape3D:
			count += 1
			
	return count
	
func destroy():
	mesh.scale = Vector3(1,1,1)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(mesh, "scale", Vector3.ZERO, 0.4)
	tween.tween_callback(queue_free)
