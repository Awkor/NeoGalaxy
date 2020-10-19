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
			var coordinate_delta := Vector3.ZERO
			var translation_ratio: Vector3 = child.translation / MAXIMUM_TRANSLATION
			if translation_ratio.x > 1.0:
				coordinate_delta += Vector3.RIGHT
			elif translation_ratio.x < -1.0:
				coordinate_delta += Vector3.LEFT
			if translation_ratio.y > 1.0:
				coordinate_delta += Vector3.UP
			elif translation_ratio.y < -1.0:
				coordinate_delta += Vector3.DOWN
			if translation_ratio.z > 1.0:
				coordinate_delta += Vector3.BACK
			elif translation_ratio.z < -1.0:
				coordinate_delta += Vector3.FORWARD
			if coordinate_delta != Vector3.ZERO:
				var target_coordinate := ChunkCoordinate.new(
					chunk.coordinate.x + coordinate_delta.x,
					chunk.coordinate.y + coordinate_delta.y,
					chunk.coordinate.z + coordinate_delta.z
				)
				var target_chunk := chunk_grid.get_chunk_at(target_coordinate)
				if target_chunk == null:
					target_chunk = chunk_grid.add_chunk_at(target_coordinate)
				chunk.remove_child(child)
				child.translation -= coordinate_delta * Chunk.SIZE
				target_chunk.add_child(child)


func add_node_to_grid(node: Node, coordinate: ChunkCoordinate) -> void:
	var chunk := chunk_grid.get_chunk_at(coordinate)
	if chunk == null:
		chunk = chunk_grid.add_chunk_at(coordinate)
	chunk.add_child(node)


func add_spatial_to_grid(spatial: Spatial) -> void:
	var coordinate := ChunkCoordinate.new(
		floor(spatial.translation.x / MAXIMUM_TRANSLATION),
		floor(spatial.translation.y / MAXIMUM_TRANSLATION),
		floor(spatial.translation.z / MAXIMUM_TRANSLATION)
	)
	add_node_to_grid(spatial, coordinate)
