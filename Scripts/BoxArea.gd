class_name BoxArea

extends CollisionShape3D

@onready var box: = shape as BoxShape3D

func _ready():
	assert(box is BoxShape3D)


func get_random_point() -> Vector3: 
	
	var x = randf_range(position.x - (box.size.x / 2), position.x + (box.size.x / 2))
	var y = randf_range(position.y - (box.size.y / 2), position.y + (box.size.y / 2))
	var z = randf_range(position.z - (box.size.z / 2), position.z + (box.size.z / 2))
	
	return Vector3(x, y, z)
	

