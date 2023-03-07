extends AnimatableBody3D

@export var enabled: = true
@export var push_direction: Vector3
@export var push_distance: float = 1
@export var push_frequency: float = 1

var _init_position: Vector3

func _init():
	_init_position = position
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var weight = sin(Time.get_ticks_msec() / 1000.0 * push_frequency) + 1
	
	position = lerp(_init_position, _init_position + (push_direction * push_distance), weight)

func _process(delta):
	pass
