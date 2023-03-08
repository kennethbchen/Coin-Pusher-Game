@tool

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



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if Engine.is_editor_hint():
		cylinder_shape.radius = radius
		cylinder_shape.height = height
	
		cylinder_mesh.top_radius = radius
		cylinder_mesh.bottom_radius = radius
		cylinder_mesh.height = height
