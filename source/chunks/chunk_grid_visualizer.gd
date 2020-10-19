extends Spatial

const CHUNK_ALPHA := 0.1
const CHUNK_COLOR := Color.green
const CHUNK_SIZE := Vector3(Chunk.SIZE, Chunk.SIZE, Chunk.SIZE)

export (NodePath) var chunk_grid_path

onready var chunk_grid: ChunkGrid = get_node(chunk_grid_path)


func _ready() -> void:
	chunk_grid.connect("chunk_added", self, "_on_ChunkGrid_chunk_added")


func _process(delta: float) -> void:
	translation = chunk_grid.translation


func _on_ChunkGrid_chunk_added(chunk: Chunk) -> void:
	var mesh := CubeMesh.new()
	mesh.size = CHUNK_SIZE
	var material := SpatialMaterial.new()
	material.albedo_color = CHUNK_COLOR
	material.albedo_color.a = CHUNK_ALPHA
	material.flags_transparent = true
	mesh.material = material
	var instance := MeshInstance.new()
	instance.mesh = mesh
	instance.translation = chunk.translation
	add_child(instance)
