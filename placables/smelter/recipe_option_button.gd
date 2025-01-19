extends OptionButton

@export var ui_root: GridObjectUI

func _init() -> void:
	for each in Globals.recipes:
		add_icon_item(load(Globals.ITEM_PATH + each.recipe_icon + "/" + each.recipe_icon + "_sprite.png"), each.recipe_name)
