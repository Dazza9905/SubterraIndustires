extends OptionButton


	
func _init() -> void:
	for item in Enums.items:
		add_icon_item(item.texture, item.name)
