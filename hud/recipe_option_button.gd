extends OptionButton

func _init() -> void:
	add_item("none")
	for recipe in Enums.recipes:
		add_icon_item(recipe.icon, recipe.name)
