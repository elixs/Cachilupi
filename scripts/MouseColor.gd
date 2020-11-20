extends ColorRect


onready var viewport_rect = get_viewport_rect()


func _process(delta: float) -> void:
	# TODO make this support window resize
	var pos = 2 * get_global_mouse_position() / get_viewport().size
	(material as ShaderMaterial).set_shader_param("mouse", pos)

