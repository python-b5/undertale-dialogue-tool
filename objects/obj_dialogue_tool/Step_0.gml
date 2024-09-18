if (instance_exists(obj_cutscene)) {
	exit;
}

if (keyboard_check_pressed(vk_enter)) {
	keyboard_string += "\n";
}

if (keyboard_check(vk_control)) {
	if (keyboard_check_pressed(ord("C"))) {
		clipboard_set_text(keyboard_string);
	}
	
	if (keyboard_check_pressed(ord("V"))) {
		keyboard_string = clipboard_get_text();
	}
}

if (keyboard_check_pressed(vk_f1)) {
	face = !face;
}

text = keyboard_string;

if (keyboard_check_pressed(vk_f2)) {
	var filename = get_open_filename(".wav files|*.wav", "");
	
	if (filename != "" && file_exists(filename)) {
		var file = buffer_load(filename);
		var size = buffer_get_size(file);
		
		buffer = buffer_create(size, buffer_fixed, 1);
		buffer_copy(file, 0, size, buffer, 0);
		buffer_delete(file);
		
		var sample_rate = buffer_peek(buffer, 24, buffer_u32);
		var audio_bits = buffer_peek(buffer, 34, buffer_u16);
		var samples = (size - 44) * 8 div audio_bits;
		
		blip = audio_create_buffer_sound(buffer, buffer_s16, sample_rate, 44, samples, audio_stereo);
		
		cutscene_init()
			.add(new ev_lerp_var(id, "overlay_alpha", 0, 1, 0.1))
			.add(new ev_dialogue(directions.down, [{
				face: face ? {sprite: spr_bnuuy, talk_sprite: noone, image: 0} : undefined,
				blip: obj_dialogue_tool.blip,
				speaker: noone,
				text: text
			}]))
			.add(new ev_lerp_var(id, "overlay_alpha", 1, 0, 0.1))
			.add({initialize: function() {
				keyboard_string = obj_dialogue_tool.text;
				audio_free_buffer_sound(obj_dialogue_tool.blip);
				buffer_delete(obj_dialogue_tool.buffer);
			}})
			.start();
	} else {
		show_message("Couldn't load .wav file!");
	}
}