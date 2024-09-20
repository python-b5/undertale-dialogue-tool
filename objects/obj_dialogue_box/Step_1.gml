_typewriter.step();

// Advance page / close box on confirmation
if ((keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) && _typewriter.shown_chars == _typewriter.text_length) {
	if (++current_page < pages_length) {
		_typewriter = new typewriter(format_basic, is_undefined(pages[current_page].face) ? 32 : 25, true, pages[current_page].blip, true, pages[current_page].speaker, 3, pages[current_page].text);
	} else {
		instance_destroy();
	}
}