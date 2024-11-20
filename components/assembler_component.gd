extends Component

class_name AssemblerComponent

@export var recipe: Recipe
#@export var inputs: 
#@export var outputs:

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for material in recipe.input_materials:
		print(material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
