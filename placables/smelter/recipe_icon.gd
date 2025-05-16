@tool
extends RotatableSprite2D
class_name RecipeIcon

@export var craft_comp: CrafterComponent
var icon_display: Sprite2D

func _ready() -> void:
	if not Engine.is_editor_hint():
		craft_comp.recipe_changed.connect(_on_recipe_changed)
	base_texture_atlas = preload("uid://db8wqsht48jhq")
	update_button.call()
	icon_display = Sprite2D.new()
	add_child(icon_display)
	_on_recipe_changed()
	icon_display.offset = offset
	
func _on_recipe_changed():
	if craft_comp.recipe:
		icon_display.texture = craft_comp.recipe.icon
	else :
		icon_display.texture = null
	
	
