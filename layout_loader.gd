extends Node2D

var layouts:Dictionary = {}
var emoji = []
var tile_scene = preload("res://assets/nodes/tile.tscn")

func load_layouts():
	# Load all layouts from files
	var dir := DirAccess.open("res://assets/layouts")
	dir.list_dir_begin()

	while true:
		var file := dir.get_next()
		if file == "":
			break
		elif file.ends_with(".layout"):
			# Open text file
				var layout := FileAccess.open("res://assets/layouts/"+file, FileAccess.READ)
				layouts[file.replace(".layout","")] = layout.get_as_text()

	dir.list_dir_end()

func build_layout(_layout):
	
	var layout: String = layouts[_layout]
	var lines: PackedStringArray = layout.split("\n")
	var layers: int = 1
	var width: int = 0 # How many tiles wide this layout is
	var height: int = 0
	var tile_width: int = 128
	var tile_height: int = 128
	var layer: int = -1
	var last_seperator: int = 0
	
	for line_index in range(0, lines.size()):
		var line: String = lines[line_index]
	
		if line.begins_with("WIDTH"):
			width = int(line.replace("WIDTH=",""))
			continue
			
		if line.begins_with("HEIGHT"):
			height = int(line.replace("HEIGHT=",""))
			continue
			
		if line.begins_with("--"):
			layer += 1
			last_seperator = line_index
			continue

		var y_pos = line_index - (last_seperator + 1)
		print(line_index, " ", last_seperator)
		print("ypos ", y_pos)

		for character_index in range(0, line.length()):
			
			var x_pos = character_index
			
			var character = line[character_index]
			if character == "*":
				var instance = tile_scene.instantiate()
				var half_tile = tile_width/2
				var offset = (layer % 2) * half_tile
				# Set tile position
				instance.position.x = 75+ (x_pos * tile_width) + offset
				instance.position.y = 75+ (y_pos * tile_width) + offset
				
				# Set tile size
				instance.apply_scale(Vector2(1,1))

				# Randomly pick an emoji for now
				instance.set_emoji(str(layer)+"_char")
				# Set layer
				instance.z_index = layer
				instance.name = str(layer) + " : "+str(x_pos)+" - " + str(y_pos) 
				add_child(instance)
			
			
			
			
		
		print(line)
		

func load_emoji():
	var file := FileAccess.open("res://assets/emoji_list.json", FileAccess.READ)
	emoji = JSON.parse_string(file.get_as_text())
	

# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_emoji()
	load_layouts()
	build_layout("simple")

