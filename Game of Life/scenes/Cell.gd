extends RigidBody2D

var alive_texture = preload("res://assets/alivecell.png")
var dead_texture = preload("res://assets/deadcell.png")

var is_alive:bool = false
var ind: Vector2i
var will_alive: bool

func get_ind() -> Vector2i:
	return ind
func set_ind(vec:Vector2i) -> void:
	ind = vec
	position = vec*(scale.x*100) + Vector2(scale.x*50, scale.x*50)

func set_cell_scale(s: float) -> void:
	set_scale(Vector2(s,s))
	#$CollisionShape2D.set_scale(Vector2(s,s))

func get_is_alive() -> bool:
	return is_alive

func set_is_alive(b: bool) -> void:
	if is_alive != b:
		toggle_alive()
		

func toggle_alive() -> void:
	is_alive = !is_alive
	
	if is_alive:
		$Sprite2D.set_texture(alive_texture) 
	else:
		$Sprite2D.set_texture(dead_texture)

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_left"):
		#toggle_alive()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			toggle_alive()
