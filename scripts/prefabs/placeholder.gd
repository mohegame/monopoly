extends Node3D

@export
var area_name: String = ""

var label_area: Label3D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.label_area = self.get_node("Title")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.multiplayer.is_server():
		return

	self.label_area.text = self.area_name
