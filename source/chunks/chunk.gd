class_name Chunk
extends Spatial

const SIZE = pow(2.0, 16.0)

var coordinate: ChunkCoordinate

static func key(coordinate: ChunkCoordinate) -> String:
	return "(%d, %d, %d)" % [coordinate.x, coordinate.y, coordinate.z]


func setup(coordinate: ChunkCoordinate) -> void:
	self.coordinate = coordinate
	translation.x = coordinate.x * SIZE
	translation.y = coordinate.y * SIZE
	translation.z = coordinate.z * SIZE
