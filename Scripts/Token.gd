@tool

class_name Token

extends RigidBody3D

@onready var collision: = $CollisionShape3D
@onready var mesh: = $MeshInstance3D

@export_range(0.001, 10, 0.001, "or_greater") var height: float = 0.2
@export_range(0.001, 10, 0.001, "or_greater") var radius: float = 0.5

var cylinder_shape: CylinderShape3D
var cylinder_mesh: CylinderMesh

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(collision.shape is CylinderShape3D)
	assert(mesh.mesh is CylinderMesh)
	
	cylinder_shape = collision.shape as CylinderShape3D
	cylinder_mesh = mesh.mesh as CylinderMesh
	
	# Change dimensions of token
	cylinder_shape.radius = radius
	cylinder_shape.height = height
	
	cylinder_mesh.top_radius = radius
	cylinder_mesh.bottom_radius = radius
	cylinder_mesh.height = height
	
	mesh.scale = Vector3.ZERO
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(mesh, "scale", Vector3(1,1,1), 0.25)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if Engine.is_editor_hint():
		cylinder_shape.radius = radius
		cylinder_shape.height = height
	
		cylinder_mesh.top_radius = radius
		cylinder_mesh.bottom_radius = radius
		cylinder_mesh.height = height

func destroy():
	mesh.scale = Vector3(1,1,1)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(mesh, "scale", Vector3.ZERO, 0.4)
	tween.tween_callback(queue_free)
