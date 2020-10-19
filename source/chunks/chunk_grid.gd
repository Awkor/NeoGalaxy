class_name ChunkGrid
extends Spatial

signal chunk_added(chunk)

var chunks := {}


func add_chunk_at(coordinate: ChunkCoordinate) -> Chunk:
	var key := Chunk.key(coordinate)
	var chunk_exists := chunks.has(key)
	assert(chunk_exists == false)
	var chunk := Chunk.new()
	chunk.setup(coordinate)
	chunks[key] = chunk
	chunk.name = key
	add_child(chunk)
	emit_signal("chunk_added", chunk)
	return chunk


func get_chunk_at(coordinate: ChunkCoordinate) -> Chunk:
	var key := Chunk.key(coordinate)
	var chunk: Chunk = chunks[key] if chunks.has(key) else null
	return chunk


func set_chunk_as_origin(chunk: Chunk) -> void:
	translation = -chunk.translation
