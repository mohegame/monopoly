extends Node3D
class_name PlayerController

@export
var owner_id: int = 0

@export
var player_states: Dictionary

var player_index = 0
var start_positions: Node3D
var players: Node3D
var player: Player
var label_score: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	self.start_positions = self.get_node("../../StartPositions")
	self.players = self.get_node("../../Players")
	self.label_score = self.get_node("Control/Score")
	if self.multiplayer.is_server():
		var syncer: MultiplayerSynchronizer = self.get_node("MultiplayerSynchronizer")
		syncer.set_visibility_for(self.owner_id, true)
		
	if !self.multiplayer.is_server():
		rpc_id(1, "need_initialized_info")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.owner_id != self.multiplayer.get_unique_id():
		return
	
	for id in self.player_states:
		if id == self.owner_id:
			self.label_score.text = "$" + str(self.player_states[id].score)


@rpc(any_peer, call_remote, reliable)
func need_initialized_info():
	var position_index = self.player_index % self.start_positions.get_children().size()
	var transfrom = self.start_positions.get_node("StartPosition"+str(position_index)).transform
	rpc_id(self.owner_id, "initialize_player", transfrom)

@rpc(authority, call_remote, reliable)
func initialize_player(transform: Transform3D):
	self.player = self.players.get_node(str(self.multiplayer.get_unique_id()))
	self.player.transform = transform
	self.player.initialize()
