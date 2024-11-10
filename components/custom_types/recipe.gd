extends Resource

class_name Recipe

@export var input_materials: Array[MaterialEnum.MATERIAL_ITEM]

func _ready() -> void:
	for material in input_materials:
		print(material)



func _process(delta: float) -> void:
	pass
