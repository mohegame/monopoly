extends Node3D

@export
var area_name: String = ""
@export
var area_description: String = ""

var area: Area3D
var label_area: Label3D
var label_card_title: Label
var label_card_description: Label
var control: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	self.label_area = self.get_node("Title")
	self.label_card_title = self.get_node("Control/Card/Title")
	self.label_card_description = self.get_node("Control/Card/Description")
	self.control = self.get_node("Control")

	self.area = self.get_node("Area3D")
	if !self.multiplayer.is_server():
		self.area.body_entered.connect(_player_entered)
		self.area.body_exited.connect(_player_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.multiplayer.is_server():
		return

	if self.area_name != "":
		self.label_area.text = self.area_name
		self.label_card_title.text = self.area_name
		self.label_card_description.text = self.area_description

func _player_entered(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = true

func _player_exited(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = false
