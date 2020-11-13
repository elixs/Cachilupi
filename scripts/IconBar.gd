tool

extends CanvasLayer

var is_ready = false

export var amount = 3 setget set_amount
func set_amount(value):
	amount = max(0, value)
	if is_ready:
		while $HBoxContainer.get_child_count() > amount:
			var child = $HBoxContainer.get_child($HBoxContainer.get_child_count() - 1)
			$HBoxContainer.remove_child(child)
			child.queue_free()
		while $HBoxContainer.get_child_count() < amount:
			var child = $Dummy.duplicate()
			child.show()
			$HBoxContainer.add_child(child)

func _ready() -> void:
	is_ready = true 
	self.amount = amount
