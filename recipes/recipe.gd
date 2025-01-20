extends Resource
class_name Recipe

@export var name: String
@export var icon: Texture2D
@export var valid_machines: Array[String]
@export var input_ingredients: Array[Ingredient]
@export var output_products: Array[Ingredient]
@export var ticks_to_craft: int
