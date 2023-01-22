extends Node3D

@export
var number: int
var random_duration: float

var area: Area3D
var label_number: Label3D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.area = self.get_node("Area3D")
	self.label_number = self.get_node("Number")
	if !self.multiplayer.is_server():
		self.area.body_entered.connect(_player_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if number >= 0:
		self.label_number.text = str(number)
		return

	if self.multiplayer.is_server():
		random_duration += delta
		if random_duration >= 1:
			self.number = randi() % 24
	else:
		self.label_number.text = str(randi() % 24)


func _player_entered(body: Node3D):
	if self.multiplayer.get_unique_id() == body.get_multiplayer_authority():
		rpc_id(1, "random_number")

@rpc(any_peer, call_remote, reliable)
func random_number():
	self.number = -1
	self.random_duration = 0
