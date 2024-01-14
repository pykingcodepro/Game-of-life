extends Node2D

@export var cell_scene: PackedScene
var cellsList: Array
var loop: bool
var loop_cooldown: int = 0
var display_size = DisplayServer.window_get_size()

func init_cell_data() -> void:
	for i in range(20):
		var temp:Array = []
		for j in range(12):
			var cell = cell_scene.instantiate()
			var s = display_size.x/2000.0
			cell.set_cell_scale(s)
			cell.set_ind(Vector2(i,j))
			temp.append(cell)
		cellsList.append(temp)

func checkAlive(cell: RigidBody2D) -> void:
	var ind: Vector2i = cell.get_ind()
	var total_neighbour_alive: int = 0
	
	if ind.x != 0:
		if cellsList[ind.x - 1][ind.y].get_is_alive():
			total_neighbour_alive += 1
		if ind.y != 0 and cellsList[ind.x - 1][ind.y -1].get_is_alive():
			total_neighbour_alive += 1
		if ind.y != (len(cellsList[0]) - 1) and cellsList[ind.x - 1][ind.y + 1].get_is_alive():
			total_neighbour_alive += 1
			
			
	if ind.x != len(cellsList) -1 :
		if cellsList[ind.x + 1][ind.y].get_is_alive():
			total_neighbour_alive += 1
		if ind.y != 0 and cellsList[ind.x+1][ind.y-1].get_is_alive():
			total_neighbour_alive += 1
		if ind.y != (len(cellsList[0]) - 1) and cellsList[ind.x + 1][ind.y + 1].get_is_alive():
			total_neighbour_alive += 1
	
	if ind.y != 0 and cellsList[ind.x][ind.y-1].get_is_alive():
		total_neighbour_alive += 1
	if ind.y != (len(cellsList[0]) - 1) and cellsList[ind.x][ind.y + 1].get_is_alive():
		total_neighbour_alive += 1
		
	
	if cell.get_is_alive():
		if total_neighbour_alive < 2 or total_neighbour_alive > 3:
			cell.will_alive = false
		else:
			cell.will_alive = true
	else:
		if total_neighbour_alive == 3:
			cell.will_alive = true
		else:
			cell.will_alive = false

func updateGen() -> void:
	for i in cellsList:
		for cell in i:
			checkAlive(cell)
	for i in cellsList:
		for cell in i:
			cell.set_is_alive(cell.will_alive)
			

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_cell_data()
	for i in cellsList:
		for cell in i:
			$Pickable.add_child(cell)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		loop = !loop
	if loop:
		if loop_cooldown == 0:
			updateGen()
		if loop_cooldown != 6:
			loop_cooldown += 1
		else:
			loop_cooldown = 0
