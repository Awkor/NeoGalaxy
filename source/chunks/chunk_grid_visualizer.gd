extends Spatial

export (NodePath) var chunk_grid_path

var chunk_color := Color.green
var chunk_alpha := 0.1

onready var chunk_grid: ChunkGrid = get_node(chunk_grid_path)


func _ready() -> void:
	for row in chunk_grid.chunks:
		for column in row:
			for chunk in column:
				var mesh := CubeMesh.new()
				mesh.size = Vector3(Chunk.SIZE, Chunk.SIZE, Chunk.SIZE)
				var material := SpatialMaterial.new()
				material.albedo_color = chunk_color
				material.albedo_color.a = chunk_alpha
				material.flags_transparent = true
				mesh.material = material
				var instance := MeshInstance.new()
				instance.mesh = mesh
				instance.translation = chunk.translation
				add_child(instance)
