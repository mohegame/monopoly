extends Node3D

@export
var player_names: Dictionary

var area: Area3D
var control: Node
var player_states: Dictionary
var line_edit_amount: LineEdit
var menu_button_pay_to: MenuButton
var menu_items: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	self.control = self.get_node("Control")
	self.area = self.get_node("Area3D")
	self.line_edit_amount = self.get_node("Control/Panel/Amount")
	self.menu_button_pay_to = self.get_node("Control/Panel/PayTo")
	self.control.visible = false
	self.menu_button_pay_to.get_popup().id_pressed.connect(_pay_to)
	if !self.multiplayer.is_server():
		self.area.body_entered.connect(_player_entered)
		self.area.body_exited.connect(_player_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.multiplayer.is_server():
		self.player_names.clear()
		for id in self.player_states:
			if self.player_states[id].name == "":
				continue
			self.player_names[self.player_states[id].name] = id
		return
	
	if !(self.player_names.size() == self.menu_items.size() && self.player_names.has_all(self.menu_items)):
		self.menu_button_pay_to.get_popup().clear()
		self.menu_button_pay_to.get_popup().add_item("Bank", 0)
		self.menu_button_pay_to.get_popup().add_separator()
		self.menu_items.clear()
		for player_name in player_names:
			self.menu_items.append(player_name)
			self.menu_button_pay_to.get_popup().add_item(player_name, self.menu_items.size())



func _player_entered(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = true

func _player_exited(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = false

func _pay_to(id: int):
	print(">>>>>>>", id)
