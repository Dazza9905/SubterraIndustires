extends RefCounted
class_name IOConnection

var conn1: IOComponent
var conn2: IOComponent

func _init(comp1:IOComponent, comp2:IOComponent) -> void:
	conn1 = comp1
	conn2 = comp2

func get_connection(caller: IOComponent) -> IOComponent:
	if get_reference_count() <= 1:
		self.free()
	if (caller == conn1):
		return conn2
	else:
		return conn1

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		print("Destructor called: Object deleted")
