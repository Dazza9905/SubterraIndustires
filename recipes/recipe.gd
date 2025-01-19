extends Resource
class_name Recipe

@export var recipe_name: String
@export var item_icon: Enums.MATERIAL_ITEM = Enums.MATERIAL_ITEM.NONE
@export var valid_machines: Array[String]
@export var input_ingredients: Array[Ingredient]
@export var output_products: Array[Ingredient]
@export var ticks_to_craft: int
