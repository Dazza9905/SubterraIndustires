extends ComponentUI
class_name CrafterComponentUI

@export var ui_link_id: String
@export var recipe_icon: TextureRect
@export var progress_bar: ProgressBar

var crafter_component: CrafterComponent

func link_to_component(components: Array[Component]) -> void:
	for comp in components:
		if comp is CrafterComponent and comp.ui_link_id == ui_link_id:
			print(self.name, " linked to ", comp.name)
			crafter_component = comp
			crafter_component.recipe_changed.connect(update_recipe)
			crafter_component.craft_progress_changed.connect(update_progress)
			update_recipe()
			update_progress()

func update_recipe():
	if crafter_component.recipe:
		recipe_icon.texture = crafter_component.recipe.icon
		progress_bar.max_value = crafter_component.recipe.ticks_to_craft

func update_progress():
	progress_bar.max_value = crafter_component.craft_progress
	if not crafter_component.recipe:
		progress_bar.max_value = 0

func _on_control_item_selected(index: int) -> void:
	crafter_component.recipe = Enums.recipes[index]
