extends Node
class_name GroupOperation

signal all_ended

var _end_signal: String
var _numer_of_nodes: int = 0
var _nodes = []
var _params = {}

func clear(end_signal: String):
	_nodes = []
	_params = {}
	_numer_of_nodes = 0
	_end_signal = end_signal

func add_object(node: Node, params: Array):
	_numer_of_nodes += 1
	_nodes.append(node)
	_params[node] = params
#	var err = node.connect(_end_signal, self, "_on_end_signal")
#	assert(err == 0)
	
func start(func_name: String):
	if _nodes.empty():
		emit_signal("all_ended")
		return
	
	for node in _nodes:
		node.callv(func_name, _params[node])
	
func _on_end_signal():
	_numer_of_nodes -= 1
	if _numer_of_nodes == 0:
		emit_signal("all_ended")
