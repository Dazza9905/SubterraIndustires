extends OptionButton

func _init() -> void:
	for recipe in Enums.recipes:
		add_icon_item(recipe.icon, recipe.name)
