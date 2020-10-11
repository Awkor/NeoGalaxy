class_name ChunkGrid
extends Spatial

var chunks := []
var size := 16


func _init() -> void:
	for x in range(size):
		chunks.append([])
		for y in range(size):
			chunks[x].append([])
			for z in range(size):
				var chunk := Chunk.new()
				chunk.set_coordinate(x, y, z)
				chunk.translation.x = x * chunk.SIZE
				chunk.translation.y = y * chunk.SIZE
				chunk.translation.z = z * chunk.SIZE
				chunks[x][y].append(chunk)
				add_child(chunk)
