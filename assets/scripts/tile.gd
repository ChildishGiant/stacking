extends Area2D

@export var emoji_name: String = ""
const backup_emoji = "transgender_flag"
const emoji_dir = "res://assets/img/mutant/png-256/"

# Called when the node enters the scene tree for the first time.
func _ready():
	if emoji_name != "":
		set_emoji(emoji_name)


func set_emoji(_emoji_name):
	emoji_name = _emoji_name
	
	var emoji_sprite = $Emoji
	
	# Load the chosen texture
	var texture = ResourceLoader.load(emoji_dir + _emoji_name+ ".png")
	
	if texture == null:
		# Loading failed, likely due to a misspelt emoji
		print("Failed to load emoji texture:", emoji_name)
		# Load a known safe texture
		texture = ResourceLoader.load(emoji_dir + backup_emoji + ".png")
		emoji_name = backup_emoji
	# We for sure have a working texture, load it
	emoji_sprite.texture = texture

func tile_input(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		# if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# Left mouse button pressed
			# print("Left mouse button clicked on " + emoji_name)
		if !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# Left mouse button released
			print("Left mouse button released on " + emoji_name)
			# Try to remove this tile
			click()

func check_collisions() -> bool:
	# Checks if the tile can be moved to the rack
	var overlaps = get_overlapping_areas()
	for area in overlaps:
		# If the overlap is above this tile
		if area.z_index > z_index:
			# Tile can't move
			return false
	# If we've reached here, there's no overlaps
	return true
 
func click():	
	if check_collisions():
		queue_free()
