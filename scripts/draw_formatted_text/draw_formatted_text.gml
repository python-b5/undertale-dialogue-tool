enum text_effects {
	swirl,  // Characters move in circles
	shake  // Characters move around sporadically
}

// Draws text with special formatting (effects and colors).
function draw_formatted_text(_x, _y, font, char_spacing, line_spacing, text) {
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var current_x = _x;
	var current_y = _y;
	
	var effect = undefined;
	var shake_chance = undefined;
	
	// Whether to indent new lines
	var auto_indent = (string_copy(text, 0, 2) == "* ");
	
	// Needed to allow you to see tags as you're typing them out. Dialogue tool-exclusive.
	var ignore_tag = false;
	
	var text_length = string_length(text);
	for (var i = 1; i <= text_length; i++) {
		var char = string_char_at(text, i);
		
		if (char == "\n") {
			current_x = _x;
			current_y += line_spacing;
			continue;
		}
		
		// Check if a tag has been reached ("{{" for a literal "{")
		if (char == "{" && string_char_at(text, i + 1) != "{" && !ignore_tag) {
			var tag = "";
			var previous_i = i;
			
			// Read tag and move past it
			while (true) {
				char = string_char_at(text, ++i);
				
				if (char == "") {
					ignore_tag = true;
					break;
				} else if (char == "}") {
					break;
				} else {
					tag += char;
				}
			}
			
			if (ignore_tag) {
				i = previous_i - 1;
				continue;
			}
			
			// Process tag
			var arguments = string_split(tag, ",");
			var arguments_length = array_length(arguments);
			
			if (arguments_length == 2) {
				switch (arguments[0]) {
					case "e":
						switch (arguments[1]) {
							case "w":
								effect = text_effects.swirl;
								break;
							
							case "s":
								effect = text_effects.shake;
								shake_chance = 2 / 3;
								break;
							
							case "n":
								effect = undefined;
								break;
						}
						
						break;
					
					case "c":
						switch (arguments[1]) {
							case "r": draw_set_color(c_red); break;
							case "gr": draw_set_color(c_lime); break;
							case "w": draw_set_color(c_white); break;
							case "y": draw_set_color(c_yellow); break;
							case "bk": draw_set_color(c_black); break;
							case "bl": draw_set_color(c_blue); break;
							case "o": draw_set_color(c_orange); break;
							case "lb": draw_set_color(#0ec0fd); break;
							case "f": draw_set_color(c_fuchsia); break;
							case "p": draw_set_color(#ffbbd4); break;
							case "gy": draw_set_color(c_gray); break;
						}
						
						break;
				}
			} else if (arguments_length == 3 && arguments[0] == "e" && arguments[1] == "s") {
				var parts = string_split(arguments[2], "/", 1);
				if (
					string_length(string_digits(parts[0])) == string_length(parts[0])
					&& string_length(string_digits(parts[1])) == string_length(parts[1])
				) {
					var numerator = real(parts[0]);
					var denominator = real(parts[1]);
					
					// Make sure it's a valid fraction and greater than zero
					if (numerator <= denominator && numerator > 0 && denominator > 0) {
						// We have to do this check last to avoid potentially dividing by zero.
						// shake_chance just won't be used if the check fails.
						shake_chance = numerator / denominator;
						if (shake_chance <= 1) {
							effect = text_effects.shake;
						}
					}
				}
			}
			
			continue;
		}
		
		if (ignore_tag) {
			ignore_tag = false;
		}
		
		// Handle effects
		// TODO: Make these look more like Undertale's
		var effect_x = 0;
		var effect_y = 0;
		
		switch (effect) {
			case text_effects.swirl:
				var angle = 360 - 10 * (global.time % 36);
				effect_x = round(lengthdir_x(2, (angle - (15 * i))));
				effect_y = round(lengthdir_y(2, (angle - (15 * i))));
			break;
			
			case text_effects.shake:
				// Separate chances for each axis
				if (random(1) <= shake_chance) {
					effect_x = choose(-1, 1);
				}
				
				if (random(1) <= shake_chance) {
					effect_y = choose(-1, 1);
				}
			break;
		}
		
		draw_text(current_x + effect_x, current_y + effect_y, char);
		
		// Faux bold effect for speech bubble text
		if (font == fnt_dialogue_battle) {	
			draw_text(current_x + effect_x + 1, current_y + effect_y, char);
		}
		
		current_x += char_spacing;
	}
	
	draw_set_color(c_white);
}

// Macros for common usages
// (These replace the font, char_spacing, and line_spacing arguments all in one!)
#macro format_basic fnt_main, 16, 36  // Standard dialogue boxes
#macro format_battle fnt_main, 16, 32  // In-battle dialogue box (the line spacing here is different for some reason)
#macro format_bubble fnt_dialogue_battle, 9, 20