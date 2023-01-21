extends Control
class_name Joystick

@export
var movement_radius: float = 100
@export
var button_color: Color = Color8(100, 100, 100, 100)
@export
var button_border_color: Color = Color8(50, 50, 50, 140)
@export
var input_action_left: String = "input_action_left"
@export
var input_action_right: String = "input_action_right"
@export
var input_action_forward: String = "input_action_forward"
@export
var input_action_backward: String = "input_action_backward"

var touch_index: int = -1
var original_position: Vector2
var target_position: Vector2
var radius: float

func _init() -> void:
	self.focus_mode = Control.FOCUS_NONE

func _enter_tree() -> void:
	self.original_position = self.position
	self.radius = min(self.size.x, self.size.y)/2


func _draw() -> void:
	if self.touch_index < 0:
		# Window size may be changed. Correct original position
		self.original_position = self.position

	self.draw_circle(self.size/2, self.radius , self.button_color)
	self.draw_arc(self.size/2, self.radius - 5, 0, PI * 2, 200, self.button_border_color, 2)

func _gui_input(event: InputEvent) -> void:
	var event_index = -1
	if event is InputEventMouseButton:
		event_index = event.button_index
	elif event is InputEventScreenTouch:
		event_index = event.index

	if event_index >= 0:
		if event.pressed && self.touch_index < 0:
			self.touch_index = event_index
			self.target_position = self.original_position
		if !event.pressed && self.touch_index == event_index:
			self.touch_index = -1
	
	var left = 0
	var right = 0
	var forward = 0
	var backward = 0

	if self.touch_index >= 0:
		if event is InputEventMouseMotion || event is InputEventScreenDrag:
			self.target_position += event.relative
			var distance = (self.target_position - self.original_position).length()
			if distance > self.movement_radius:
				self.position = self.original_position + (self.target_position - self.original_position) * self.movement_radius / distance 
			else:
				self.position = self.target_position
			
			var direction = self.position - self.original_position

			if direction.x > 0:
				right = direction.x / self.movement_radius
			else:
				left = -direction.x / self.movement_radius

			if direction.y > 0:
				backward = direction.y / self.movement_radius
			else:
				forward = -direction.y / self.movement_radius
	else:
		self.position = self.original_position

	Input.action_press(self.input_action_left, left)
	Input.action_press(self.input_action_right, right)
	Input.action_press(self.input_action_forward, forward)
	Input.action_press(self.input_action_backward, backward)
