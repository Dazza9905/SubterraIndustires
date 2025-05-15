extends ComponentUI
class_name CrafterCompUI

@export var ui_link_id: String
@export var progress_bar: ProgressBar
@export var option_button: OptionButton
@export var recipe_details: VBoxContainer

var crafter_component: CrafterComponent
var machine_name: String
var tween: Tween

func link_to_component(components: Array[Component]) -> void:
	var is_linked: bool = false
	
	
	for comp in components:
		if comp is CrafterComponent and comp.ui_link_id == ui_link_id:
			#print(self.name, " linked to ", comp.name)
			crafter_component = comp
			crafter_component.craft_progress_changed.connect(update_progress.unbind(1))
			crafter_component.recipe_changed.connect(_on_recipe_changed)
			option_button.selected = Enums.recipes.find(crafter_component.recipe) + 1
			_on_recipe_changed()
			update_progress(false)
			
			machine_name = crafter_component.get_parent_GO().code_name

			option_button.add_item("none")
			
			for recipe in Enums.filter_recipes_by_machine(machine_name):
				option_button.add_icon_item(recipe.icon, recipe.name)
			option_button.select(Enums.filter_recipes_by_machine(machine_name).find(crafter_component.recipe)+1)



func _on_recipe_changed() -> void:
	for c in recipe_details.get_children():
			c.queue_free()
			
	if crafter_component.recipe:
		progress_bar.max_value = crafter_component.recipe.ticks_to_craft

		for in_ingredient in crafter_component.recipe.input_ingredients:
			var entry := Button.new()
			entry.theme_type_variation = "IconLabel"
			entry.mouse_filter = Control.MOUSE_FILTER_IGNORE
			entry.alignment = HORIZONTAL_ALIGNMENT_LEFT
			entry.icon = in_ingredient.item.texture
			entry.text = in_ingredient.item.name + " " + str(in_ingredient.amount) + "X"
			recipe_details.add_child(entry)
	if tween:
		tween.stop()
	progress_bar.value = 0
	

func update_progress(do_tween: bool = true):
	if crafter_component.recipe == null:
		return
	#if get_tree():
	
	tween = get_tree().create_tween()
	var bar_progress: int = crafter_component.craft_progress + 1
	
	
	if crafter_component.craft_progress != 0:
		if bar_progress > crafter_component.recipe.ticks_to_craft:
			tween.tween_property(progress_bar, "value", 0, 0.0)
		else:
			tween.tween_property(progress_bar, "value", bar_progress, Globals.get_tts().tick_max_delta * 2)
	else:
		tween.tween_property(progress_bar, "value", 0, 0.0)
#
	#else:
		#progress_bar.value = 0


# will run after link_components. BE CAREFULL!
func _ready() -> void:
	pass


func _on_control_item_selected(index: int) -> void:
	if index == 0:
		crafter_component.recipe = null
	else:
		crafter_component.recipe = Enums.filter_recipes_by_machine(machine_name)[index-1]
