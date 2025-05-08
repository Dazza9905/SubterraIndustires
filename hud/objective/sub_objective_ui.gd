extends Label
class_name SubObjectiveUI

@export var sub_objective: SubObjective

func _init(pass_sub_objective: SubObjective) -> void:
	sub_objective = pass_sub_objective

func _ready() -> void:
	var l_settings: LabelSettings = LabelSettings.new()
	l_settings.font = preload("res://hud/pixel_font.ttf")
	l_settings.font_size = 20
	
	label_settings = l_settings

func _process(_delta: float) -> void:
	text = sub_objective.name + " " + str(sub_objective.current_completion) + "/" + str(sub_objective.finish_completion)
