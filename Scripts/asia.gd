extends Node2D

var faith = Global.asia_faith
var unholy = Global.unholy
var holy = Global.holy
var population = Global.population

var convert_chance_timer := 0.0
var convert_chance_time_to_next_roll = 1.0

var faith_increaser_timer := 0.0
var faith_increaser_time_to_next_roll = 1.0

var faith_increase_chance := 0.05  # 5% chance (0.0 to 1.0)
var faith_increase_amount := 0.1   # Faith to add if successful

func _process(delta: float) -> void:
	randomize()
	continent_data_updater()
	
	
	faith_increaser_timer += delta
	if faith_increaser_timer >= faith_increaser_time_to_next_roll:
		faith_increaser_timer = 0.0
	
		var random = randf()
		
		if random <= faith_increase_chance:
			faith += faith_increase_amount
		
	
	
	convert_chance_timer += delta
	if convert_chance_timer >= convert_chance_time_to_next_roll:
		convert_chance_timer = 0.0
		holy_to_unholy_converter()

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			$VBoxContainer.visible = not $VBoxContainer.visible



func continent_data_updater():
	$VBoxContainer/Faith.text = "Faith: " + str(faith)
	$VBoxContainer/Population.text = "Population: " + str(population)
	$VBoxContainer/Unholy.text = "Unholy: " + str(unholy)
	$VBoxContainer/Holy.text = "Holy: " + str(holy)
	

func holy_to_unholy_converter():
	if unholy <= 0:
		return

	var clamped_faith = clamp(faith, 0, population)
	var chance = clamped_faith / population

	# Calculate how many should be converted based on chance
	var to_convert := int(unholy * chance)
	unholy -= to_convert
	holy += to_convert
