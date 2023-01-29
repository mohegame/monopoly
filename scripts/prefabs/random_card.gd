extends Node3D

@export
var area_name: String = ""
@export
var area_description: String = ""

@export
var card_name: String = ""
@export
var card_description: String = ""

var area: Area3D
var card: Node3D
var label_area: Label3D
var label_card_title: Label3D
var label_card_description: Label3D
var label_title: Label
var label_description: Label
var button_draw: Button
var control: Control
var cards: Array = []
var random_duration: float = 0
var draw_silent_duration: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.label_area = self.get_node("Title")
	self.label_card_title = self.get_node("Card/Title")
	self.label_card_description = self.get_node("Card/Description")
	self.label_title = self.get_node("Control/Card/Title")
	self.label_description = self.get_node("Control/Card/Description")
	self.button_draw = self.get_node("Control/Draw")
	self.control = self.get_node("Control")
	self.card = self.get_node("Card")
	self.area = self.get_node("Area3D")
	if !self.multiplayer.is_server():
		self.area.body_entered.connect(_player_entered)
		self.area.body_exited.connect(_player_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.multiplayer.is_server():
		if self.card_name != "":
			return

		random_duration += delta
		if random_duration >= 1:
			var index = randi() % self.cards.size()
			self.card_name = self.cards[index].name
			self.card_description = self.cards[index].description
		return

	if self.draw_silent_duration > 0:
		self.draw_silent_duration -= delta

	if self.draw_silent_duration <= 0 && self.button_draw.disabled:
		self.button_draw.disabled = false

	if self.area_name != "":
		self.label_area.text = self.area_name
		self.label_title.text = self.area_name
		self.label_description.text = self.area_description

	if self.card_name != "":
		self.card.rotation = Vector3.ZERO
	else:
		self.card.rotation.y += PI * delta * 2

	self.label_card_title.text = self.card_name
	self.label_card_description.text = self.card_description



func _player_entered(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = true

func _player_exited(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		self.control.visible = false


func _on_draw_button_up():
	self.button_draw.disabled = true
	self.draw_silent_duration = 1
	rpc_id(1, "draw", true)


@rpc("any_peer", "call_remote", "reliable")
func draw(_unused: bool):
	self.random_duration = 0
	self.card_name = ""
	self.card_description = ""
