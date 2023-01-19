extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var script_name = "res://scripts/client.gd"
	if "--server" in OS.get_cmdline_args():
		script_name = "res://scripts/server.gd"
	
	var script = load(script_name)
	var delegator = Node3D.new()
	delegator.set_script(script)
	self.add_child(delegator)