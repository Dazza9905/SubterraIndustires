extends PlacementRule
class_name OrRule

@export var rules : Array[PlacementRule]

func validate_condition() -> RuleResult:
	var OR_result := RuleResult.new(self, false, "")
	var i : int = 1
	for rule in rules:
		var problems : Array[String] = rule.setup(_params)
		var result : RuleResult = rule.validate_condition()
		if result.is_successful:
			OR_result.is_successful = true
		OR_result.reason += "R" + str(i) + ": " + str(result.reason) + " "
		i += 1
		for p in problems:
			print(p)
	print(OR_result.reason)
	return OR_result
	
	
