class_name Capacitor
extends Node

var capacity: int
var charge: int
var recharge_rate: int


func _process(delta: float) -> void:
	if charge < capacity:
		recharge(recharge_rate * delta)


func recharge(amount: int) -> void:
	charge = min(charge + amount, capacity)


func use(amount: int) -> void:
	charge = max(charge - amount, 0)
