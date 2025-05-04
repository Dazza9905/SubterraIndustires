extends ComponentUI
class_name CrafterCompUI

@export var ui_link_id: String
@export var progress_bar: ProgressBar
@export var option_button: OptionButton

var crafter_component: CrafterComponent

func link_to_component(components: Array[Component]) -> void:
	var is_linked: bool = false
	for comp in components:
		if comp is CrafterComponent and comp.ui_link_id == ui_link_id:
			print(self.name, " linked to ", comp.name)
			crafter_component = comp
			crafter_component.craft_progress_changed.connect(update_progress.unbind(1))
			crafter_component.recipe_changed.connect(_on_recipe_changed)
			option_button.selected = Enums.recipes.find(crafter_component.recipe)
			_on_recipe_changed()
			update_progress(false)
	if not is_linked:
		assert(self.name, " did not link!")

func _on_recipe_changed() -> void:
	if crafter_component.recipe:
		progress_bar.max_value = crafter_component.recipe.ticks_to_craft

func update_progress(do_tween: bool = true):
	if crafter_component.recipe:
		if do_tween:
			if get_tree():
				var tween: Tween = get_tree().create_tween()
				var bar_progress: int = crafter_component.craft_progress + 1
				
				
				if crafter_component.craft_progress != 0:
					if bar_progress > crafter_component.recipe.ticks_to_craft:
						tween.tween_property(progress_bar, "value", 0, 0.0)
					else:
						tween.tween_property(progress_bar, "value", bar_progress, 0.4)
				else:
					tween.tween_property(progress_bar, "value", 0, 0.0)
		else:
			progress_bar.value = crafter_component.craft_progress
	else:
		progress_bar.value = 0

func _on_control_item_selected(index: int) -> void:
	crafter_component.recipe = Enums.recipes[index]
