extends HBoxContainer

func _on_button_pressed() -> void:
	GameManager.load_world($Label.text)


func _on_delete_pressed() -> void:
	GameManager.delete_world($Label.text)
