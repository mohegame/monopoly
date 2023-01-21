extends Node3D

@export
var owner_name: String = ""
@export
var area_name: String = ""
@export
var level: int = 0

var label_owner: Label3D
var label_area: Label3D
var levels: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.label_owner = self.get_node("Owner")
	self.label_area = self.get_node("Title")
	self.levels = self.get_node("Level")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.multiplayer.is_server():
		return
	
	self.label_owner.text = self.owner_name
	self.label_area.text = self.area_name
	
	for i in range(1, 4):
		var level_room: Node3D = self.levels.get_node("Level"+str(i))
		if i <= self.level:
			level_room.visible = true
		else:
			level_room.visible = false

