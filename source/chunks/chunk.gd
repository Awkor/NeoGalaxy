class_name Chunk
extends Spatial

const SIZE = pow(2.0, 16.0)

var coordinate: ChunkCoordinate


func set_coordinate(x: int, y: int, z: int) -> void:
	coordinate = ChunkCoordinate.new(x, y, z)


class ChunkCoordinate:
	var x: int
	var y: int
	var z: int

	func _init(x: int, y: int, z: int) -> void:
		self.x = x
		self.y = y
		self.z = z
