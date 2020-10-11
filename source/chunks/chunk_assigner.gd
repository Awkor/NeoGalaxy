class_name ChunkAssigner
extends Spatial

const MAXIMUM_TRANSLATION := Chunk.SIZE / 2

export (NodePath) var chunk_grid_path

onready var chunk_grid: ChunkGrid = get_node(chunk_grid_path)


func _physics_process(delta: float) -> void:
	var chunks: Array = chunk_grid.get_children()
	for chunk in chunks:
		var chunk_children: Array = chunk.get_children()
		for child in chunk_children:
			var ratio: Vector3 = child.translation / MAXIMUM_TRANSLATION
			var target_chunk: Chunk = null
			var target_translation: Vector3 = child.translation
			var x: int = chunk.coordinate.x
			var y: int = chunk.coordinate.y
			var z: int = chunk.coordinate.z
			if ratio.x > 1.0:
				x = min(x + 1, chunk_grid.size - 1)
				target_chunk = chunk_grid.chunks[x][y][z]
				target_translation.x -= float(chunk.SIZE)
			elif ratio.x < -1.0:
				x = max(x - 1, 0)
				target_chunk = chunk_grid.chunks[x][y][z]
				target_translation.x += float(chunk.SIZE)
			if ratio.y > 1.0:
				y = min(y + 1, chunk_grid.size - 1)
				target_chunk = chunk_grid.chunks[x][y][z]
				target_translation.y -= float(chunk.SIZE)
			elif ratio.y < -1.0:
				y = max(y - 1, 0)
				target_chunk = chunk_grid.chunks[x][y][z]
				target_translation.y += float(chunk.SIZE)
			if ratio.z > 1.0:
				z = min(z + 1, chunk_grid.size - 1)
				target_chunk = chunk_grid.chunks[x][y][z]
				target_translation.z -= float(chunk.SIZE)
			elif ratio.z < -1.0:
				z = max(z - 1, 0)
				target_chunk = chunk_grid.chunks[x][y][z]
				target_translation.z += float(chunk.SIZE)
			if target_chunk is Chunk:
				chunk.remove_child(child)
				child.translation = target_translation
				target_chunk.add_child(child)
