extends Node3D

@export
var color: Color:
	set(value):
		if color != value:
			color = value
			var material = StandardMaterial3D.new()
			material.albedo_color = color
			var head: MeshInstance3D = self.get_node("Head")
			head.mesh.material = material
			var pedestal: MeshInstance3D = self.get_node("Pedestal")
			pedestal.mesh.material = material